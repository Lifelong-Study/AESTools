//
//  EliteLayoutConstraint.h
//  EliteFramework
//
//  Created by Lifelong-Study on 2016/3/22.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (EliteLayoutConstraint)

//
+ (instancetype _Nonnull)constraintWithItem:(nonnull UIView *)subview attribute:(NSLayoutAttribute)attribute;

//
+ (instancetype _Nonnull)constraintWithItem:(nonnull UIView *)subview attribute:(NSLayoutAttribute)attribute offset:(CGFloat)offset;

//
+ (instancetype _Nonnull)constraintWithItem:(nonnull UIView *)subview width:(CGFloat)width;

//
+ (instancetype _Nonnull)constraintWithItem:(nonnull UIView *)subview height:(CGFloat)height;

//
+ (instancetype _Nonnull)constraintEqualWidthWithItem:(nonnull UIView *)view1 toItem:(nonnull UIView *)view2;

//
+ (instancetype _Nonnull)constraintEqualHeightWithItem:(nonnull UIView *)view1 toItem:(nonnull UIView *)view2;

//
+ (instancetype _Nonnull)constraintEqualCenterXWithItem:(nonnull UIView *)view1 toItem:(nonnull UIView *)view2;

//
+ (instancetype _Nonnull)constraintEqualCenterYWithItem:(nonnull UIView *)view1 toItem:(nonnull UIView *)view2;
    
/*! Creates constraints described by an ASCII art-like visual format string. */
+ (NSArray<__kindof NSLayoutConstraint *> * _Nonnull)constraintsWithVisualFormat:(nonnull NSString *)format views:(NSDictionary<NSString *, id> * _Nonnull)views;

@end
