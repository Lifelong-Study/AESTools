//
//  EliteButton_Style_001.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/7.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "EliteLabel_Style_001.h"
@import EliteFramework;

IB_DESIGNABLE
@implementation EliteLabel_Style_001: UILabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self applyEffect];
    }
    
    return self;
}

- (void)prepareForInterfaceBuilder
{
    [self applyEffect];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    if (layer == self.layer) {
        [self applyEffect];
    }
}

- (void)applyEffect
{
    // 設置字型與大小
    self.font = [UIFont systemFontOfSize:20.0];
    
    // 設置文字顏色
    [self setTextColor:EliteColor(WHITE_COLOR)];
    
    // 準備漸層顏色
    [self renderGradientEffects];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self renderGradientEffects];
}

- (void)renderGradientEffects
{
    // 根據不同的狀態渲染不同的漸層顏色
    self.enabled ?
        [self renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithUIColor:EliteColor(0x00C000), EliteColor(0x006000), nil] :
        [self renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithUIColor:EliteColor(0xC0C0C0), EliteColor(0x606060), nil] ;
}

@end
