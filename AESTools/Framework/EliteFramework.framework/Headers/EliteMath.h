//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ascii2int(a)    (a) - '0'

@interface EliteMath : NSObject

+ (NSInteger)convertASCIIByteToInteger:(char)byte;
+ (NSInteger)convertASCIIByteToInteger:(char)byte base:(NSInteger)base;

@end
