//
//  AppParameter.m
//  Home-Inspection
//
//  Created by Skywind on 2015/7/6.
//  Copyright (c) 2015年 Lifelong-Study. All rights reserved.
//

#import "PreferenceConfig.h"

@implementation PreferenceConfig

+ (PreferenceConfig *)sharedInstance
{
    static PreferenceConfig *sharedInstance = nil;
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:nil] init];
    }
    
    return sharedInstance;
}


@end