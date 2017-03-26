//
//  EliteSwitch.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/14.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "EliteSwitch.h"

@interface EliteSwitch ()
@property (strong, nonatomic) NSString *key;
@end

@implementation EliteSwitch

- (id)initWithKey:(NSString *)key
{
    if (self = [super init]) {
        self.key = key;
        
        self.on = [[[NSUserDefaults standardUserDefaults] objectForKey:self.key] boolValue];
        
        [self addTarget:self action:@selector(didChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)didChangedValue:(UISwitch *)switcher
{
    NSNumber *value = [NSNumber numberWithBool:[switcher isOn]];
    
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:self.key];
}

@end
