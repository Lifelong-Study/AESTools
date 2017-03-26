
//  ViewController.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/7.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "ViewController.h"
#import "NSData+AESCrypt.h"
#import "ProgressViewController.h"
#import "PreferenceConfig.h"
@import EliteFramework;

#define DOCUMENTS_PATHS  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
#define DOCUMENTS_DIR   [DOCUMENTS_PATHS objectAtIndex:0]

// 後輟名
#define SUFFIX_NAME_MP3         @"mp3"
#define SUFFIX_NAME_MP4         @"mp4"
#define SUFFIX_NAME_MP3_AES     @"mp3.aes"
#define SUFFIX_NAME_MP4_AES     @"mp4.aes"
#define SUFFIX_NAME_AES         @"aes"

@interface ViewController() <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIPopoverPresentationControllerDelegate, CodecDelete>
{
    BOOL isKeepCodec;
    
    NSMutableArray *waitingEncodeFilesNameArray;
    NSMutableArray *waitingDecodeFilesNameArray;
    
    NSArray *preferenceTitleArray;
    NSArray *preferenceKeyArray;
    
//    NSMutableArray *errorsArray;
}
@property (strong, nonatomic) NSMutableArray *errorsArray;
@property (        nonatomic) CGFloat       singlePrintProgress;        // 記錄單檔已列印的百分比
@property (        nonatomic) CGFloat       singleProcessingProgress;   // 記錄單檔已完成的百分比
@property (        nonatomic) NSUInteger    totalProcessingBytes;       // 記錄已處理的 Bytes 數
@property (        nonatomic) NSUInteger    totalBytes;                 // 記錄此次加解密待處理的 Bytes 數

@property (strong, nonatomic) ProgressViewController *progressViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.encryptTableView.layer.cornerRadius = 10.0;
    self.decryptTableView.layer.cornerRadius = 10.0;
    
    // 重置 UITableView 的編輯狀態
    [self resetTableViewEditingState];
    
    // 更新"待編碼"和"已編碼"數據陣列的內容
    [self refreshWaitsingFilenamesArray];
    
    // 設置代理
    [Codec setDelegate:self];
    
    
    // 載入偏好設定
    [self loadPreferences];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
    // 顯示進度視窗
    [self showProgressViewController];
}

// 載入偏好設定
- (void)loadPreferences
{
    if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:@"OVERWRITE_TARGET_FILE"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"OVERWRITE_TARGET_FILE"];
    }
    
    if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:@"STOP_CODING_WHEN_OCCURS_ERROR"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"STOP_CODING_WHEN_OCCURS_ERROR"];
    }
    
    Preferences.overwriteTargetFile = [[[NSUserDefaults standardUserDefaults] objectForKey:@"OVERWRITE_TARGET_FILE"] boolValue];

    Preferences.stopCodingWhenOccursError = [[[NSUserDefaults standardUserDefaults] objectForKey:@"STOP_CODING_WHEN_OCCURS_ERROR"] boolValue];
}

#pragma mark - UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 60);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    if (NO) {
    } else if ([tableView isEqual:self.encryptTableView]) {
        label.text = @"待加密檔案清單";
    } else if ([tableView isEqual:self.decryptTableView]) {
        label.text = @"待解密檔案清單";
    }
    
    [label setFont:[UIFont boldSystemFontOfSize:18.0]];
    [label setTextColor:EliteColor(WHITE_COLOR)];
    [label setTextAlignment: NSTextAlignmentCenter];
    
    // 準備漸層顏色
    NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
    [colorsArray addObject:EliteColor(0x600060)];
    [colorsArray addObject:EliteColor(0x200020)];
    
    // 渲染漸層效果
    [label renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithArray:colorsArray];
    
    
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self filesNameArray:tableView] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text  = [[self filesNameArray:tableView] objectAtIndex:indexPath.row];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:EliteColor(0xDCB5FF)]];
    
    
    //
    CGRect frame = CGRectZero;
    frame.size.width  = CGRectGetHeight(cell.bounds);
    frame.size.height = CGRectGetHeight(cell.bounds);
    frame.origin.x    = CGRectGetWidth(cell.bounds) - CGRectGetHeight(cell.bounds);
    frame.origin.y    = 0;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Nothing
}

#pragma mark - UIButton Event
- (IBAction)buttonPressed:(id)sender
{
    if (NO) {
    } else if ([sender isEqual:self.preferenceBarButtonItem]) {
        [self showPreferenceViewController];            // 顯示偏好視窗
    } else if ([sender isEqual:self.encryptButton]) {
        [self codecFileProc:CodecModeEncrypt];          // 對檔案進行加密的動作
    } else if ([sender isEqual:self.decryptButton]) {
        [self codecFileProc:CodecModeDecrypt];          // 對檔案進行解密的動作
    } else if ([sender isEqual:self.refreshButton]) {
        if ([self.refreshButton.titleLabel.text isEqualToString:@"重新整理"]) {
            [self refreshWaitsingFilenamesArray];       // 重整檔案清單
        } else {
            [self.progressViewController appendProgressMessage:@"...失敗" warpLine:NO];
            [self.progressViewController appendProgressMessage:@"使用者中斷" warpLine:YES];
            [self disableCodecMode];
        }
    }
}

#pragma mark - Private
- (void)enableCodecMode
{
    isKeepCodec = YES;
    Codec.isCancel = NO;
    
    [self.encryptButton setEnabled:NO];
    [self.decryptButton setEnabled:NO];
    [self.encryptTableView setUserInteractionEnabled:NO];
    [self.decryptTableView setUserInteractionEnabled:NO];
    
    [self.refreshButton setTitle:@"停止" forState:UIControlStateNormal];
    
    // 根據不同的狀態設置不同的漸層顏色
    
    NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
    [colorsArray addObject:EliteColor(0xF00000)];
    [colorsArray addObject:EliteColor(0xA00000)];
    
    
    // 渲染漸層效果
    [self.refreshButton renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithArray:colorsArray];
    
    [self.progressViewController show];
    
    [self.errorsArray removeAllObjects];
}

- (void)disableCodecMode
{
    isKeepCodec = NO;
    Codec.isCancel = YES;
    
    [self.encryptButton setEnabled:YES];
    [self.decryptButton setEnabled:YES];
    [self.encryptTableView setUserInteractionEnabled:YES];
    [self.decryptTableView setUserInteractionEnabled:YES];
    
    [self.refreshButton setTitle:@"重新整理" forState:UIControlStateNormal];
    
    // 根據不同的狀態設置不同的漸層顏色
    
    NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
    [colorsArray addObject:EliteColor(0x00C000)];
    [colorsArray addObject:EliteColor(0x006000)];
    
    
    // 渲染漸層效果
    [self.refreshButton renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithArray:colorsArray];
    
    [self.progressViewController hidden];
}

- (NSMutableArray *)filesNameArray:(UITableView *)tableView
{
    if (NO) {
    } else if ([tableView isEqual:self.encryptTableView]) {
        return waitingEncodeFilesNameArray;
    } else if ([tableView isEqual:self.decryptTableView]) {
        return waitingDecodeFilesNameArray;
    }
    
    return nil;
}

- (void)resetTableViewEditingState
{
    [self.encryptTableView setEditing:NO animated:NO];
    [self.decryptTableView setEditing:NO animated:NO];
    [self.encryptTableView setEditing:YES animated:NO];
    [self.decryptTableView setEditing:YES animated:NO];
}

// 更新"待編碼"和"已編碼"數據陣列的內容
- (void)refreshWaitsingFilenamesArray
{
    waitingEncodeFilesNameArray = [self getFilenamesFromState:CodecModeEncrypt];
    waitingDecodeFilesNameArray = [self getFilenamesFromState:CodecModeDecrypt];
    
    [self.encryptTableView reloadData];
    [self.decryptTableView reloadData];
}

- (NSMutableArray *)getFilenamesFromState:(CodecMode)state
{
    NSArray *dataArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:DOCUMENTS_DIR error:nil];
    
    // 等待加密的檔名陣列
    NSMutableArray *waitingEncryptFilesArray = [[NSMutableArray alloc] init];
    
    // 等待解密的檔名陣列
    NSMutableArray *waitingDecryptFilesArray = [[NSMutableArray alloc] init];
    
    //
    for (NSInteger i = 0 ; i < [dataArray count] ; i++) {
        
        NSString *fileName = [dataArray objectAtIndex:i];
        
        NSArray  *separatedName = [fileName componentsSeparatedByString:@"."];
        
        if (NO) {
        } else if ([[separatedName lastObject] isEqualToString:SUFFIX_NAME_MP3]) {
            [waitingEncryptFilesArray addObject:fileName];
        } else if ([[separatedName lastObject] isEqualToString:SUFFIX_NAME_MP4]) {
            [waitingEncryptFilesArray addObject:fileName];
        } else if ([[separatedName lastObject] isEqualToString:SUFFIX_NAME_AES]) {
            [waitingDecryptFilesArray addObject:fileName];
        } else {
            NSLog(@"嚴重錯誤: 處理檔名時發現未處理的後輟名: %@", [separatedName lastObject]);
        }
    }
    
    return state == CodecModeEncrypt ? waitingEncryptFilesArray : waitingDecryptFilesArray;
}

- (BOOL)codecFileProc:(CodecMode)mode
{
    UITableView *tableView = mode == CodecModeEncrypt ? self.encryptTableView : self.decryptTableView;
    
    // 防呆: 避免使用者在未選擇任何檔案的情況下直接進行加密的動作
    if ([tableView indexPathsForSelectedRows].count <= 0) {
        NSString *title = [NSString stringWithFormat:@"請先在\"畫面%@側\"選擇要處理的檔案名稱", mode == CodecModeEncrypt ? @"左": @"右"];
        [self showAlertView:title message:nil delegate:nil];
        return NO;
    }
    
    //
    [self enableCodecMode];
    
    //
    switch (mode) {
        case CodecModeEncrypt:      return [self encryptFileProc];
        case CodecModeDecrypt:      return [self decryptFileProc];
        default:                    return NO;
    }
    
}

- (BOOL)encryptFileProc
{
    // 重置旗標
    isKeepCodec = YES;
    
    // 過程訊息
    [self.progressViewController setProgressMessage:@"開始"];
    
    // 取得所有被選取的 NSIndexPath
    NSArray *indexPathsArray = [self.encryptTableView indexPathsForSelectedRows];
    
    //
    NSArray *pathsArray = [self formatterFilePathFromIndexPathsArray:indexPathsArray mode:CodecModeEncrypt];
    
    //
    self.totalBytes = [self getTotalBytesFromPathsArray:pathsArray];
    
    // 顯示處理視窗
    [self.progressViewController show];
    
    // 以執行緒方式執行，避免主行程被阻塞。
    dispatch_queue_t createQueue = dispatch_queue_create("SerialQueue", nil);
    dispatch_async(createQueue, ^(){
        
        NSString   *sourcePath = nil;       // 來源檔案路徑
        NSString   *sourceName = nil;       // 來源檔案名稱
        NSString   *sourceSuffix = nil;     // 來源檔案後輟名
        NSUInteger  sourceBytes = 0;        // 來源檔案大小
        NSString   *targetName = nil;       // 目的檔案名稱
        NSString   *targetPath = nil;       // 目的檔案路徑
        
        // 對已選取的檔案逐一進行加密的動作
        for (NSArray *pathArray in pathsArray) {
        
            // 防呆: 當使用者選擇中斷執行時，取消後續加解密動作的進行。
            if (isKeepCodec != YES) {
                break;
            }
            
            // 重置過程變數
            [self resetProcessingParameters];
            
            // 取得來源與目的檔案的: 1.路徑 2.檔名 3.後輟名 4.大小
            [self getFilePathFromPathsArray:pathArray sourcePath:&sourcePath targetPath:&targetPath];
            [self getFileInfoFromPath:sourcePath name:&sourceName suffix:&sourceSuffix bytes:&sourceBytes];
            [self getFileInfoFromPath:targetPath name:&targetName suffix:nil bytes:nil];
            
            //  列印提示訊息
            [self printCodecProcessingLogWithFileName:sourceName bytes:sourceBytes mode:CodecModeEncrypt];
            
            // 防呆: 加解密前的防呆機制處理與錯誤訊息列印
            if ([self mistakeProofingMechanismProcessing:sourceBytes targetPath:targetPath]) {
                Preferences.stopCodingWhenOccursError ? ({break;}) : ({continue;});
            }
            
            // 進行加密的動作
            [Codec codingAtMode:CodecModeEncrypt suffix:sourceSuffix sourcePath:sourcePath targetPath:targetPath];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 過程訊息
            [self appendProgressMessage:@"結束"];
            
            // 解鎖用戶介面
            [self unlockUserInterface];
            
            // 錯誤處理機制
            if ([self.errorsArray count] > 0) {
                return [self showAlertView:[self.errorsArray firstObject] message:nil delegate:self]; // 顯示警告視窗
            }
            
            // 列印完成訊息
            if (isKeepCodec == YES) {
                [self showAlertView:@"加密完成" message:nil delegate:self];
            }
        });
    });

    return YES;
}

- (BOOL)decryptFileProc
{
    // 重置旗標
    isKeepCodec = YES;
    
    // 過程訊息
    [self.progressViewController setProgressMessage:@"開始"];
    
    // 取得所有被選取的 NSIndexPath
    NSArray *indexPathsArray = [self.decryptTableView indexPathsForSelectedRows];
    
    //
    NSArray *pathsArray = [self formatterFilePathFromIndexPathsArray:indexPathsArray mode:CodecModeDecrypt];
    
    //
    self.totalBytes = [self getTotalBytesFromPathsArray:pathsArray];
    
    // 以執行緒方式執行，避免主行程被阻塞。
    dispatch_queue_t createQueue = dispatch_queue_create("SerialQueue", nil);
    dispatch_async(createQueue, ^(){
        
        NSString   *sourcePath   = nil; // 來源檔案路徑
        NSString   *sourceName   = nil; // 來源檔案名稱
        NSUInteger  sourceBytes  = 0;   // 來源檔案大小
        NSString   *targetPath   = nil; // 目的檔案路徑
        NSString   *targetName   = nil; // 目的檔案名稱
        NSString   *targetSuffix = nil; // 目的檔案後輟名
        
        // 對已選取的檔案逐一進行加密的動作
        for (NSArray *pathArray in pathsArray) {
            
            // 防呆: 當使用者選擇中斷執行時，取消後續加解密的動作。
            if (isKeepCodec != YES) {
                break;
            }
            
            // 重置過程變數
            [self resetProcessingParameters];
            
            // 取得來源與目的檔案的: 1.路徑 2.檔名 3.後輟名 4.大小
            [self getFilePathFromPathsArray:pathArray sourcePath:&sourcePath targetPath:&targetPath];
            [self getFileInfoFromPath:sourcePath name:&sourceName suffix:nil bytes:&sourceBytes];
            [self getFileInfoFromPath:targetPath name:&targetName suffix:&targetSuffix bytes:nil];
            
            //  列印提示訊息
            [self printCodecProcessingLogWithFileName:sourceName bytes:sourceBytes mode:CodecModeDecrypt];
            
            // 防呆: 加解密前的防呆機制處理與錯誤訊息列印
            if ([self mistakeProofingMechanismProcessing:sourceBytes targetPath:targetPath]) {
                Preferences.stopCodingWhenOccursError ? ({break;}) : ({continue;});
            }
            
            // 進行加解密的動作
            [Codec codingAtMode:CodecModeDecrypt suffix:targetSuffix sourcePath:sourcePath targetPath:targetPath];
        }
        

        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 過程訊息
            [self appendProgressMessage:@"結束"];
            
            // 解鎖用戶介面
            [self unlockUserInterface];
            
            // 錯誤處理機制
            if ([self.errorsArray count] > 0) {
                return [self showAlertView:[self.errorsArray firstObject] message:nil delegate:self]; // 顯示警告視窗
            }
            
            // 列印完成訊息
            if (isKeepCodec == YES) {
                [self showAlertView:@"解密完成" message:nil delegate:self];
            }
            
        });
    });

    
    return YES;
}

- (NSArray *)formatterFilePathFromIndexPathsArray:(NSArray *)indexPathsArray mode:(CodecMode)mode
{
    //
    NSString *sourceName = nil; // 來源檔案名稱
    NSString *sourcePath = nil; // 來源檔案路徑
    NSString *targetName = nil; // 目的檔案名稱
    NSString *targetPath = nil; // 目的檔案路徑
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in indexPathsArray) {
        switch (mode) {
            case CodecModeEncrypt:
                sourceName = [waitingEncodeFilesNameArray objectAtIndex:indexPath.row];
                sourcePath = [NSString stringWithFormat:@"%@/%@", DOCUMENTS_DIR, sourceName];
                targetName = [sourceName stringByAppendingFormat:@".%@", SUFFIX_NAME_AES];
                targetPath = [NSString stringWithFormat:@"%@/%@", DOCUMENTS_DIR, targetName];
                break;
            case CodecModeDecrypt:
                sourceName = [waitingDecodeFilesNameArray objectAtIndex:indexPath.row];
                sourcePath = [NSString stringWithFormat:@"%@/%@", DOCUMENTS_DIR, sourceName];
                targetName = [self removeSuffixNameFromFileName:sourceName];
                targetPath = [NSString stringWithFormat:@"%@/%@", DOCUMENTS_DIR, targetName];
                break;
            case CodecModeUnknown:
                break;
        }
        
        //
        NSMutableArray *pathArray = [[NSMutableArray alloc] init];
        [pathArray addObject:sourcePath];
        [pathArray addObject:targetPath];
        
        //
        [dataArray addObject:pathArray];
    }
    
    return dataArray;
}

- (NSUInteger)getTotalBytesFromPathsArray:(NSArray *)pathsArray
{
    NSUInteger bytes = 0;
    
    for (NSArray *pathArray in pathsArray) {
        bytes += [self getFileBytesAtPath:[pathArray firstObject]];
    }
    
    return bytes;
}

- (NSString *)removeSuffixNameFromFileName:(NSString *)fileName
{
    NSArray *suffixNameArray = [fileName componentsSeparatedByString:@"."];
    
    NSString *targetFileName = [suffixNameArray firstObject];
    
    for (NSInteger i = 1 ; i < [suffixNameArray count] - 1 ; i++) {
        targetFileName = [targetFileName stringByAppendingFormat:@".%@", [suffixNameArray objectAtIndex:i]];
    }
    
    return targetFileName;
}

- (void)showAlertView:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"確定"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //
    [self disableCodecMode];
}

- (void)showProgressViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    CGRect frame = CGRectZero;
    frame.size.width = CGRectGetWidth(self.view.bounds);
    frame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetMinY(self.decryptButton.frame) + 20;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetHeight(self.view.bounds) - 50;
    
    self.progressViewController = [storyboard instantiateViewControllerWithIdentifier:@"ProgressViewController"];
    [self.progressViewController.view setFrame:frame];
    
    [self.view.window addSubview:self.progressViewController.view];
}

- (NSArray *)getSelectedFileName:(NSArray *)selectedRowsArray mode:(CodecMode)mode
{
    NSMutableArray *fileNamesArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *searchArray = (mode == CodecModeEncrypt ? waitingEncodeFilesNameArray : waitingDecodeFilesNameArray);
    
    // 取得所有的來源檔名與路徑
    for (NSIndexPath *indexPath in selectedRowsArray) {
        [fileNamesArray addObject:[searchArray objectAtIndex:indexPath.row]];
    }
    
    return fileNamesArray;
}

- (void)setTotalBytes:(NSUInteger)totalBytes
{
    _totalBytes = totalBytes;
    
    // 在更新總大小的同時重置當前已處理的 Bytes 數
    self.totalProcessingBytes = 0;
}

#pragma mark - Codec Delegate
- (void)codec:(CODEC *)codec didFinishedWithProgressSize:(NSUInteger)progressSize totalSize:(NSUInteger)totalSize;
{
    BOOL warpLine = NO;
    NSMutableString *string = [[NSMutableString alloc] init];
    
    // 統計
    self.totalProcessingBytes += progressSize;
    
    self.singleProcessingProgress += 100.0 * progressSize / totalSize;
    
    
    if (NO) {
    } else if (self.singlePrintProgress == 0 && self.singleProcessingProgress >= 100) {
        [string appendString:@"==> 開始...10%...20%...30%...40%...50%...60%...70%...80%...90%...完成"];
        warpLine = YES;
    } else if (self.singlePrintProgress == 0) {
        self.singlePrintProgress = 10;
        [string appendString:@"==> 開始" ];
        warpLine = YES;
    } else if (self.singleProcessingProgress >= 99.99999) {
        [string appendString:@"...完成"];
        warpLine = NO;
    } else {
        for (; self.singlePrintProgress < self.singleProcessingProgress ; self.singlePrintProgress += 10) {
            [string appendFormat:@"...%.0f%%", self.singlePrintProgress];
            warpLine = NO;
        }
    }
    
    // 以主行程處理畫面的更新動作
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        // 更新提示訊息
        [self.progressViewController appendProgressMessage:string warpLine:warpLine];
        
        // 更新進度百分比
        [self.progressViewController setProgress:100.0 * self.totalProcessingBytes / self.totalBytes];
    });
}

- (void)appendProgressMessage:(NSString *)message
{
    [self.progressViewController appendProgressMessage:message];
}

- (NSString *)getBytesString:(NSUInteger)bytes
{
    return [self getBytesString:bytes unit:YES];
}

- (NSString *)getBytesString:(NSUInteger)bytes unit:(BOOL)unit
{
#define KB      (1024.0)
#define MB      (1024.0 * KB)
#define GB      (1024.0 * MB)
#define TB      (1024.0 * GB)
    
    if (NO) {
    } else if (bytes < KB) {    return [NSString stringWithFormat:@"%zd%@", bytes, unit ? @" Bytes" : @""];
    } else if (bytes < MB) {    return [NSString stringWithFormat:@"%.2f%@", bytes / KB, unit ? @" KB" : @""];
    } else if (bytes < GB) {    return [NSString stringWithFormat:@"%.2f%@", bytes / MB, unit ? @" MB" : @""];
    } else if (bytes < TB) {    return [NSString stringWithFormat:@"%.2f%@", bytes / GB, unit ? @" GB" : @""];
    } else {                    return [NSString stringWithFormat:@"%.2f%@", bytes / TB, unit ? @" TB" : @""];
    }
}

// 重置過程變數
- (void)resetProcessingParameters
{
    self.singlePrintProgress = 0;
    self.singleProcessingProgress = 0;
}

// 取得檔案大小
- (NSUInteger)getFileBytesFromBytesArray:(NSMutableArray *)bytesArray
{
    NSUInteger bytes = [[bytesArray firstObject] longLongValue];
    
    [bytesArray removeObjectAtIndex:0];
    
    return bytes;
}

- (void)getFilePathFromPathsArray:(NSArray *)pathsArray sourcePath:(NSString **)sourcePath targetPath:(NSString **)targetPath
{
    if (sourcePath) {   *sourcePath = [pathsArray firstObject]; }
    if (targetPath) {   *targetPath = [pathsArray lastObject];  }
}

// 從檔案路徑取得檔名、路徑與大小
- (void)getFileInfoFromPath:(NSString *)path name:(NSString **)name suffix:(NSString **)suffix bytes:(NSUInteger *)bytes
{
    // 防呆
    if (path == nil) {
        return ;
    }
    
    if (name)         { *name   = [[path componentsSeparatedByString:@"/"] lastObject]; }
    if (suffix)       { *suffix = [[path componentsSeparatedByString:@"."] lastObject]; }
    if (bytes != nil) { *bytes  = [self getFileBytesAtPath:path];                       }
}

- (void)printCodecProcessingLogWithFileName:(NSString *)name bytes:(NSUInteger)bytes mode:(CodecMode)mode
{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendFormat:@"對 %@ ", name];
    [string appendFormat:@" [%@]", [self getBytesString:bytes unit:YES]];
    [string appendFormat:@" 進行%@", mode == CodecModeEncrypt ? @"加密" : @"解密"];
    
    [self printCodecProcessingLog:string];
}

// 加解密前的防呆機制與錯誤訊息處理
- (BOOL)mistakeProofingMechanismProcessing:(NSUInteger)sourceBytes targetPath:(NSString *)targetPath
{
    // 防呆: 檔案大小錯誤處理函式( 包含列印錯誤訊息 )
    if ([self fileSizeErrorProcessing:sourceBytes]) {
        [self printCodecProcessingLog:@"==> 失敗，檔案大小為 0！"];
        
        if (Preferences.stopCodingWhenOccursError) {
            [self addErrorReason:@"檔案大小有誤"];
        }
        return YES;
    }
    
    // 防呆: 系統可用空間不足處理函式( 包含列印錯誤訊息 )
    if ([self sysytemFreeSpaceInsufficientProcessing:sourceBytes]) {
        [self printCodecProcessingLog:@"==> 失敗，可用空間不足！"];
        
        if (Preferences.stopCodingWhenOccursError) {
            [self addErrorReason:@"系統空間不足"];
        }
        return YES;
    }
    
    // 防呆: 目標檔案已存在
    if ([self isFileExistAtPath:targetPath]) {
        
        if (Preferences.overwriteTargetFile) {
            return NO;
        }
        
        [self printCodecProcessingLog:@"==> 失敗，目標檔案已存在！"];
        if (Preferences.stopCodingWhenOccursError) {
            [self addErrorReason:@"目標檔案已存在"];
        }
        return YES;
    }
    
    return NO;
}

// 檔案大小錯誤處理函式( 包含列印錯誤訊息 )
- (BOOL)fileSizeErrorProcessing:(NSUInteger)fileBytes
{
    if (fileBytes <= 0) {
        return YES;
    }
    
    return NO;
}

// 系統可用空間不足處理函式( 包含列印錯誤訊息 )
- (BOOL)sysytemFreeSpaceInsufficientProcessing:(NSUInteger)needSpace
{
    NSUInteger systemFreeBytes = [self isSystemFreeSpaceInsufficient:needSpace];
    
    //
    if (needSpace < systemFreeBytes) {
        
        NSString *needBytesString = [self getBytesString:needSpace unit:YES];
        NSString *freeBytesString = [self getBytesString:systemFreeBytes unit:YES];
        
        NSString *string = [NSString stringWithFormat:@"==> 可用空間 %@，所需空間 %@", freeBytesString, needBytesString];
        
//        [self printCodecProcessingLog:string];
        
        return YES;
    }
    
    return NO;
}

- (void)printCodecProcessingLog:(NSString *)text
{
    // 以主執行緒處理
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressViewController appendProgressMessage:text];
    });
}

- (void)printCodecProcessingLog:(NSString *)text warpLine:(BOOL)warpLine
{
    // 以主執行緒處理
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressViewController appendProgressMessage:text warpLine:warpLine];
    });
}

// 檢查系統可用空間是否充足
- (BOOL)isSystemFreeSpaceInsufficient:(NSUInteger)needSpace
{
    return needSpace > [self getSystemFreeSize];
}

// 取得裝置容量與可用空間
- (NSUInteger)getSystemFreeSize
{
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] fileSystemAttributesAtPath:NSHomeDirectory()];
    
//    NSString *diskTotalSize = [systemAttributes objectForKey:@"NSFileSystemSize"];
    
    NSString *diskFreeSize = [systemAttributes objectForKey:@"NSFileSystemFreeSize"];
    
    return [diskFreeSize longLongValue];
}

// 取得檔案大小
- (NSUInteger)getFileBytesAtPath:(NSString *)path
{
    NSUInteger bytes = 0;
    
    FILE *fp = fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "a+");
    bytes = ftell(fp);
    fclose(fp);
    
    return bytes;
}

- (void)unlockUserInterface
{
    // 重置 UITableView 的編輯狀態
    [self resetTableViewEditingState];
        
    // 更新"待編碼"和"已編碼"數據陣列的內容
    [self refreshWaitsingFilenamesArray];
}

- (void)showPreferenceViewController
{
    // 從 Storyboard 中取得偏好視窗
    UIViewController *viewController = EliteViewController(@"Main", @"PreferenceViewController");
    if (!viewController) {return ;} // 防呆
    [viewController setModalPresentationStyle:UIModalPresentationPopover];
    [viewController setPreferredContentSize:CGSizeMake(300, 150)];
    
    // 建立 PopoverPresentationController
    UIPopoverPresentationController *popoverViewController = [viewController popoverPresentationController];
    [popoverViewController setPermittedArrowDirections:UIPopoverArrowDirectionUp]; // 箭頭方向
    [popoverViewController setBarButtonItem:self.preferenceBarButtonItem];
    [popoverViewController setDelegate:self];
    
    // 當偏好視窗出現時，在畫面底部的進度視窗不處理任何的事件
    [self.progressViewController.view setUserInteractionEnabled:NO];
    
    // 顯示偏好視窗
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - UIPopoverPresntationController Delegate
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    // 解鎖
    [self.progressViewController.view setUserInteractionEnabled:YES];
}

- (BOOL)isFileExistAtPath:(NSString *)path
{
    BOOL state = 0;
    
    FILE *fp = fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "r");
    state = fp ? YES : NO;
    fclose(fp);
    
    return state;
}

- (BOOL)addErrorReason:(NSString *)text
{
    if (!self.errorsArray) {
        self.errorsArray = [[NSMutableArray alloc] init];
    }
    
    [self.errorsArray addObject:text];
    
    return YES;
}

@end
