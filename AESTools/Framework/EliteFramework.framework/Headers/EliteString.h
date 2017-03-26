//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (EliteStringCategory)

+ (NSString *)binStringWithData:(NSData *)data interval:(char)interval;
+ (NSString *)hexStringWithData:(NSData *)data interval:(char)interval;

- (NSString *)convertToMD5String;

+ (NSString *)convertToASCIIStringWithInteger:(NSInteger)value;


@end
