//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EliteConfig.h"

@interface UIImage (EliteImageCategory)

//!
+ (nonnull UIImage *)imageNamed:(nonnull NSString *)name scale:(CGFloat)scale;

+ (nonnull UIImage *)imageWithView:(nonnull UIView *)view;
+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color;
+ (nonnull UIImage *)imageWithLayer:(nonnull CALayer *)layer;

- (nonnull UIImage *)scaleToSize:(CGSize)size;

//! 
- (nonnull UIImage *)scaleToMultiplier:(CGFloat)multiplier;

// 影像壓縮
// maxWidth : 影像的最大寬度
// maxHeight: 影像的最大高度
// quality  : 影像品質的壓縮比( 0.0 ~ 1.0 )
- (nonnull UIImage *)imageCompressWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight quality:(CGFloat)quality;


- (nonnull UIImage *)clearColor:(nonnull UIColor *)color;
- (nonnull UIImage *)changeColor:(nonnull UIColor *)fromColor toColor:(nonnull UIColor *)toColor;
//- (UIImage *)rotate:(UIImage *)src orientation:(UIImageOrientation)orientation;



// 調整影像尺寸
//- (UIImage *)scaledToSize:(CGSize)size;

// 影像剪裁
- (nonnull UIImage *)trimImageWithMask:(CGRect)maskFrame;


@end
