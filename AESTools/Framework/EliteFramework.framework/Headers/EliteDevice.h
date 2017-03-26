//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

//
#define CurrentMachine              [UIDevice currentDevice]
#define CurrentMachineOrientation   [UIDevice currentDevice].orientation

//
#define isPortrait      (CurrentMachine.orientation == UIDeviceOrientationPortrait           || \
                         CurrentMachine.orientation == UIDeviceOrientationPortraitUpsideDown )
#define isLandscape     (CurrentMachine.orientation == UIDeviceOrientationLandscapeLeft      || \
                         CurrentMachine.orientation == UIDeviceOrientationLandscapeRight     )


typedef NS_ENUM(NSUInteger, EliteMachineName) {
    AppleUnknown,
    iOSSimulator,
    iPhone_1,
    iPhone_3G,
    iPhone_3GS,
    iPhone_4,
    iPhone_4S,
    iPhone_5,
    iPhone_5C,
    iPhone_5S,
    iPhone_6,
    iPhone_6_Plus,
    iPhone_6S,
    iPhone_6S_Plus,
    
    iPad_1,
    iPad_2,
    iPad_3,
    iPad_4,
    iPad_Air_1,
    iPad_Air_2,
    iPad_mini_1,
    iPad_mini_2,
    iPad_mini_3,
    iPad_mini_4,
    iPad_Pro,
    
    iPod_Touch_1,
    iPod_Touch_2,
    iPod_Touch_3,
    iPod_Touch_4,
    iPod_Touch_5,
    iPod_Touch_6
};

typedef NS_ENUM(NSUInteger, EliteMachineType) {
    MachineTypeUnknown,
    MachineTypeiPhone,
    MachineTypeiPad,
    MachineTypeiPod,
    MachineTypeTV,
    MachineTypeWatch
};

@interface UIDevice (EliteDeviceCategory)


//@property (assign, nonatomic) EliteMachineType type;

- (NSString *)machineString;
- (EliteMachineName)machineName;


@end


