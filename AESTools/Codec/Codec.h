//
//  Codec.h
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/9.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Codec   [CODEC sharedInstance]

typedef enum {
    CodecModeUnknown,
    CodecModeEncrypt,
    CodecModeDecrypt
} CodecMode;


@protocol CodecDelete;


@interface CODEC : NSObject

#pragma mark - 加密相關函式
// 加密 MP3 檔案
- (BOOL)encryptMP3FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath;

// 加密 MP4 檔案
- (BOOL)encryptMP4FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath;



#pragma mark - 解密相關函式
// 解密 MP3 檔案
- (BOOL)decryptMP3FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath;

// 解密 MP4 檔案
- (BOOL)decryptMP4FileWithSourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath;


#pragma mark - 其他功能函式
//
- (BOOL)codingAtMode:(CodecMode)mode suffix:(NSString *)suffix sourcePath:(NSString *)sourcePath targetPath:(NSString *)targetPath;

//
+ (CODEC *)sharedInstance;

@property (strong, nonatomic) id<CodecDelete>     delegate;
@property (        nonatomic) BOOL                isCancel;

@end


@protocol CodecDataSource <NSObject>


@end

@protocol CodecDelete <NSObject>

- (void)codec:(CODEC *)codec didFinishedWithProgressSize:(NSUInteger)progressSize totalSize:(NSUInteger)totalSize;

@end
