//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define EliteViewController(StoryboardName, ViewControllerIdentifier)   [UIViewController initWithStoryboardName:(StoryboardName) viewControllerIdentifier:(ViewControllerIdentifier)]


#define ALERT_MACRO(_1, _2, _3, NAME, ...) NAME
#define EliteAlert(...) ALERT_MACRO(__VA_ARGS__, __AlertMacro3, __AlertMacro2)(__VA_ARGS__)

#define __AlertMacro2(a, b)      [self alertView:(a) buttons:@[(b)]]
#define __AlertMacro3(a, b, c)   [self alertView:(a) message:(b) buttons:@[(c)]]


// 過場動畫
typedef NS_ENUM(NSUInteger, EliteAnimation) {
    EliteAnimationPush,
    EliteAnimationPresent,
    EliteAnimationEaseIn,
    EliteAnimationEaseOut
};

@interface UIViewController (EliteViewControllerCategory)

+ (id)initWithStoryboardName:(NSString *)name viewControllerIdentifier:(NSString *)identifier;

#pragma mark -
- (void)transferViewController:(UIViewController *)viewController method:(EliteAnimation)animation;
- (void)transferViewControllerWithIdentifier:(NSString *)identifier method:(EliteAnimation)animation;
- (void)transferStoryboard:(UIStoryboard *)storyboard identifier:(NSString *)identifier method:(EliteAnimation)animation;
- (void)transferStoryboard:(UIStoryboard *)storyboard viewController:(UIViewController *)viewController method:(EliteAnimation)animation;
- (void)transferStoryboardWithIdentifier:(NSString *)name identifier:(NSString *)identifier method:(EliteAnimation)animation;

#pragma mark -
- (void)alertView:(NSString *)title buttons:(NSArray *)buttons;
- (void)alertView:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons;

@end

