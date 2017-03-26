//
//  EliteLayer.h
//  EliteFramework
//
//  Created by Lifelong-Study on 2016/1/9.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EliteConfig.h"

@interface CALayer (EliteLayerCategory)

//! 渲染漸層效果
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithCGColorsArray:(NSArray *)colowWithCGColorsArray;

//! 渲染漸層效果
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithUIColor:(UIColor *)colors, ...;

//!
- (void)renderGradientEffectsWithDirection:(EliteDirection)direction colorWithCGColor:(id)colors, ...;

@end
