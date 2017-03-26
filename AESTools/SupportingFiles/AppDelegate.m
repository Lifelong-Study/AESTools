//
//  AppDelegate.m
//  mp3
//
//  Created by Lifelong-Study on 13-3-23.
//  Copyright (c) 2013年 Lifelong-Study. All rights reserved.
//

#import "AppDelegate.h"
@import EliteFramework;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSLog(@"Documents 路徑: %@", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]);
    
    //
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.height = 64;
    
    // 定義漸層顏色
    UIColor *firstColor  = EliteColor(0x600060);
    UIColor *secondColor = EliteColor(0x200020);
    
    // 設置漸層的範圍與由上至下的漸層效果；從文件中得知：[0,0] 代表左下，而 [1, 1] 代表右上。
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint   = CGPointMake(0.5, 1);
    gradientLayer.frame      = frame;
    gradientLayer.colors     = [NSArray arrayWithObjects:(id)[firstColor  CGColor],
                                (id)[secondColor CGColor], nil];
    
    
//    CALayer *layer = [[CALayer alloc] init];
//    layer.frame.size.width = [[UIScreen mainScreen] bounds].size.width;
//    layer.frame.size.height = 64;
    
    //
    UIImage *navigationBarImage = [UIImage imageWithLayer:gradientLayer];
    
    // 設置狀態列的風格( 會影響所有畫面 )
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    
    // 設置導覽列的背景影像( 會影響所有畫面 )
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];
    
    // 設置導覽列的背景色( 會影響所有畫面 )
    //    [[UIView appearance] setTintColor:[UIColor whiteColor]];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
