//
//  Codec.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/9.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "Codec.h"
#import "NSData+AESCrypt.h"


// AES 加解密密鑰
#define AES_KEY_MP3             @"________________"
#define AES_KEY_MP4             @"________________"


// 檔案大小
#define FILE_SIZE_10MB          10 * 1000 * 1000


// 後輟名
#define SUFFIX_NAME_MP3         @"mp3"
#define SUFFIX_NAME_MP4         @"mp4"
#define SUFFIX_NAME_MP3_AES     @"mp3.aes"
#define SUFFIX_NAME_MP4_AES     @"mp4.aes"
#define SUFFIX_NAME_AES         @"aes"

@interface CODEC ()

@property (strong, nonatomic) NSString *cachePath;

@end

@implementation CODEC

+ (CODEC *)sharedInstance
{
    static CODEC *sharedInstance = nil;
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:nil] init];
    }
    
    return sharedInstance;
}

- (NSString *)cachePath
{
    if (_cachePath) {
        return _cachePath;
    }
    
    _cachePath = [NSTemporaryDirectory() stringByAppendingString:[[NSUUID UUID] UUIDString]];
    
    return _cachePath;
}

#pragma mark - 加密相關函式
// 加密 MP3 檔案
- (BOOL)encryptMP3FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    return [CODEC codingMP3FileWithSourcePath:sourcePath targetPath:targetPath mode:CodecModeEncrypt];
}

// 加密 MP4 檔案
- (BOOL)encryptMP4FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    return [CODEC codingMP4FileWithSourcePath:sourcePath targetPath:targetPath mode:CodecModeEncrypt];
}

#pragma mark - 解密相關函式
// 解密 MP3 檔案
- (BOOL)decryptMP3FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    return [CODEC codingMP3FileWithSourcePath:sourcePath targetPath:targetPath mode:CodecModeDecrypt];
}

// 解密 MP4 檔案
- (BOOL)decryptMP4FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    return [CODEC codingMP4FileWithSourcePath:sourcePath targetPath:targetPath mode:CodecModeDecrypt];
}

#pragma mark - 核心函式
// 加解密 MP3 檔案
+ (BOOL)codingMP3FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath mode:(CodecMode)mode
{
    Codec.isCancel = NO;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    // 取得來源檔案內容
    NSMutableData *sourceData = [NSMutableData dataWithContentsOfURL:[NSURL fileURLWithPath:sourcePath]];
    
    // 將檔案內容進行加密
    NSData *targetData = [Codec codingMP3FileWithSourceData:sourceData mode:mode];
    
    // 建立目標文件
    [fileManager createFileAtPath:targetPath contents:nil attributes:nil];
    
    // 將加密數據寫入至目標文件中
    [targetData writeToFile:targetPath atomically:NO];

    // 通知代理
    if ([Codec.delegate respondsToSelector:@selector(codec:didFinishedWithProgressSize:totalSize:)]) {
        [Codec.delegate codec:Codec didFinishedWithProgressSize:sourceData.length totalSize:sourceData.length];
    }
    
    return YES;
}

// 加解密 MP3 數據
- (NSData *)codingMP3FileWithSourceData:(NSData *)sourceData mode:(CodecMode)mode
{
    return mode == CodecModeEncrypt ? [sourceData AES256EncryptWithKey:AES_KEY_MP3] : [sourceData AES256DecryptWithKey:AES_KEY_MP3];
}

// 加解密 MP4 檔案
+ (BOOL)codingMP4FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath mode:(CodecMode)mode
{
    // 啟用旗標
    Codec.isCancel = NO;
    
    // 取得來源檔案大小
    NSInteger sourceFileSize = [Codec getFileBytesAtPath:sourcePath];
    
    // 計算每次要讀取的 Bytes 數
    size_t willReadSize = FILE_SIZE_10MB + (mode == CodecModeEncrypt ? 0 : 16);
    
    //
    unsigned char *binaryArray = malloc(willReadSize + 1);
    
    // 檔案指標
    FILE *sourceFilePoint = fopen([sourcePath cStringUsingEncoding:NSUTF8StringEncoding], "r");
    FILE *targetFilePoint = fopen([targetPath cStringUsingEncoding:NSUTF8StringEncoding], "w+");
    
    // 循序處理檔案內容
    for (NSInteger i = 0 ; i < sourceFileSize ; i += willReadSize) {
        
        // 防呆: 當使用者選擇中斷執行時，取消後續加解密的動作。
        if (Codec.isCancel == YES) {
            break;
        }
        
        // 設置偏移量
        fseek(sourceFilePoint, i, SEEK_SET);
        
        // 對數據進行加解密與拷貝的動作
        NSUInteger progressSize = [CODEC codecDataWithArrayPoint:binaryArray arraySize:willReadSize fromSourceFilePoint:sourceFilePoint toTargetFilePoint:targetFilePoint mode:mode];
        
        // 通知代理
        if ([Codec.delegate respondsToSelector:@selector(codec:didFinishedWithProgressSize:totalSize:)]) {
            [Codec.delegate codec:Codec didFinishedWithProgressSize:progressSize totalSize:sourceFileSize];
        }
    }
    
    // 釋放指標
    free(binaryArray);
    
    // 關檔
    fclose(sourceFilePoint);
    fclose(targetFilePoint);
    
//    // 防呆: 當使用者選擇中斷執行時，刪除未完成的檔案。
//    if (Codec.isCancel == YES) {
//        remove([targetPath UTF8String]);
//    }
    
    return Codec.isCancel ? NO : YES;
}

+ (NSUInteger)codecDataWithArrayPoint:(unsigned char *)arrayPoint arraySize:(size_t)arraySize fromSourceFilePoint:(FILE *)sourceFilePoint toTargetFilePoint:(FILE *)targetFilePoint mode:(CodecMode)mode
{
    @autoreleasepool {
        // 讀取檔案內容
        NSInteger didDataSize = fread(arrayPoint, 1, arraySize, sourceFilePoint);
        
        // 依不同模式( mode )進行加密或解密的動作
        NSData *sourceData = [NSData dataWithBytes:arrayPoint length:didDataSize];
        NSData *targetData = [self codingMP4FileWithSourceData:sourceData mode:mode];
        
        // 寫入數據
        fwrite([targetData bytes], 1, targetData.length, targetFilePoint);
        
        // 傳回處理的 Bytes 數
        return sourceData.length;
    }
}

// 加解密 MP4 數據
+ (NSData *)codingMP4FileWithSourceData:(NSData *)sourceData mode:(CodecMode)mode
{
    return mode == CodecModeEncrypt ? [sourceData AES256EncryptWithKey:AES_KEY_MP4] : [sourceData AES256DecryptWithKey:AES_KEY_MP4];
}

#pragma mark - 其他功能函式
- (BOOL)codingAtMode:(CodecMode)mode suffix:(NSString *)suffix sourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    BOOL state = NO;
    
    switch (mode) {
        case CodecModeEncrypt:
            state = [self encryptBySuffix:suffix sourcePath:sourcePath targetPath:self.cachePath];
            break;
        case CodecModeDecrypt:
            state = [self decryptBySuffix:suffix sourcePath:sourcePath targetPath:self.cachePath];
            break;
        default:
            return NO;
    }
    
    // 防呆: 當使用者取消時刪除中繼檔
    if (state != YES) {
        remove([self.cachePath UTF8String]);
    } else {
        // 將中繼檔更名為目地檔名
        [[NSFileManager defaultManager] removeItemAtPath:targetPath error:nil];
        [[NSFileManager defaultManager] moveItemAtPath:self.cachePath toPath:targetPath error:nil];
    }
    
    return state;
}

- (BOOL)encryptBySuffix:(NSString *)suffix sourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    // 依檔案類型執行相對應的函式
    if (NO) {
    } else if ([suffix isEqualToString:SUFFIX_NAME_MP3]) {
        return [self encryptMP3FileWithSourcePath:sourcePath targetPath:targetPath];
    } else if ([suffix isEqualToString:SUFFIX_NAME_MP4]) {
        return [self encryptMP4FileWithSourcePath:sourcePath targetPath:targetPath];
    } else {
        NSLog(@"嚴重錯誤: 加密時發現未處理的後輟名 %@", suffix);
    }
    
    return NO;
}

- (BOOL)decryptBySuffix:(NSString *)suffix sourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    // 依檔案類型執行相對應的函式
    if (NO) {
    } else if ([suffix isEqualToString:SUFFIX_NAME_MP3]) {
        return [self decryptMP3FileWithSourcePath:sourcePath targetPath:targetPath];
    } else if ([suffix isEqualToString:SUFFIX_NAME_MP4]) {
        return [self decryptMP4FileWithSourcePath:sourcePath targetPath:targetPath];
    } else {
        NSLog(@"嚴重錯誤: 解密時發現未處理的後輟名 %@", suffix);
    }
    
    return NO;
}

- (NSUInteger)getFileBytesAtPath:(NSString *)path
{
    NSUInteger bytes = 0;
    
    FILE *fp = fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "a+");
    bytes = ftell(fp);
    fclose(fp);
    
    return bytes;
}

@end
