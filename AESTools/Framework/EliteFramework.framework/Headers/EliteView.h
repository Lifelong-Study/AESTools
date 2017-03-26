//
//  EliteViewManager.h
//  EliteFramework
//
//  Created by Lifelong-Study on 2016/2/22.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EliteConfig.h"

#define Elite       [EliteViewManager sharedInstance]

@interface EliteViewManager : NSObject

- (void)showAlertView:(NSString *)title buttonTitle:(NSString *)buttonTitle;
- (void)showAlertView:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;

+ (EliteViewManager *)sharedInstance;

@end



@interface UIView (EliteViewCategory)

// 設置漸層效果
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colowWithCGColorsArray:(id)colowWithCGColorsArray;
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithUIColor:(UIColor *)colors, ...;
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithCGColor:(id)colors, ...;
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithArray:(NSArray *)array;

- (void)setBorderColor:(UIColor *)color;
- (void)setBorderWidth:(CGFloat)width;

- (void)addConstraintAttributeCenterX:(UIView *)superview;
- (void)addConstraintAttributeCenterY:(UIView *)superview;

@end