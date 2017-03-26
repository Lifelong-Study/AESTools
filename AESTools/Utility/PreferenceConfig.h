//
//  ViewController.h
//  HuangHsiangCalibrate
//
//  Created by Lifelong-Study on 2015/6/23.
//  Copyright (c) 2015年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Preferences     [PreferenceConfig sharedInstance]

@interface PreferenceConfig : NSObject

@property BOOL      overwriteTargetFile;        // 覆寫目標檔案
@property BOOL      stopCodingWhenOccursError;  // 當錯誤發生時停止進行加解密


+ (PreferenceConfig *)sharedInstance;

@end

