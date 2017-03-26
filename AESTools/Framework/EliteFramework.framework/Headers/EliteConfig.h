//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

// 裝置類型
#define IS_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_APPLE_TV     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomTV)


// 除錯模式: 打印過程記錄
#if (DEBUG_ELITE_FRAMEWORK)
#   define EliteLog(fmt, ...)       NSLog((@"%s[Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define EliteLog(...)
#endif


//
#define CGRECT_MACRO(_1, _2, _3, _4, NAME, ...) NAME
#define EliteRect(...) CGRECT_MACRO(__VA_ARGS__, __RectMacro4, __RectMacro3, __RectMacro2, __RectMacro1)(__VA_ARGS__)

#define __RectMacro1(a)             CGRectMake(0, 0, a, a)
#define __RectMacro2(a, b)          CGRectMake(0, 0, a, b)
#define __RectMacro3(a, b, c)       CGRectMake(a, b, c, c)
#define __RectMacro4(a, b, c, d)    CGRectMake(a, b, c, d)


//
typedef NS_ENUM(NSUInteger, EliteDirection)
{
    EliteDirectionLeft,
    EliteDirectionRight,
    EliteDirectionTop,
    EliteDirectionBottom,
    
    EliteDirectionTopToBottom,
    EliteDirectionBottomToTop,
    EliteDirectionLeftToRight,  
    EliteDirectionRigthToLeft,
    
    EliteDirectionUpperLeftToLowerLeft,
    EliteDirectionLowerLeftToUpperLeft,
    EliteDirectionUpperRightToRight,
    EliteDirectionRigthToUpperRight
};