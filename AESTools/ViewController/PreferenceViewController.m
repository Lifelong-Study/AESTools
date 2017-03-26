//
//  PreferencesViewController.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/14.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "PreferenceViewController.h"
#import "EliteSwitch.h"
#import "PreferenceConfig.h"
@import EliteFramework;

@interface PreferenceViewController () <UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *keyArray;
}

@end



@implementation PreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    titleArray = @[@"覆寫目標檔案",
                   @"遇到錯誤立即停止"];
    keyArray   = @[@"OVERWRITE_TARGET_FILE",
                   @"STOP_CODING_WHEN_OCCURS_ERROR"];
    
    [self.view.layer setBorderWidth:2.0];
    [self.view.layer setBorderColor:EliteColor(0x600060).CGColor];
    [self.view.layer setCornerRadius:10.0];
    [self.view.layer setMasksToBounds:YES];
    
    // 準備漸層顏色
    NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
    [colorsArray addObject:EliteColor(0x600060)];
    [colorsArray addObject:EliteColor(0x200020)];
    
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel renderGradientEffectsWithDirection:EliteDirectionTopToBottom colorWithArray:colorsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)getUserDefault:(NSString *)key
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:key] boolValue];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[titleArray objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:17.0]];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    EliteSwitch *switcher = [[EliteSwitch alloc] initWithKey:[keyArray objectAtIndex:indexPath.row]];
    [switcher setTag:indexPath.row];
    [switcher addTarget:self action:@selector(eliteSwitchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [cell setAccessoryView:switcher];
    
    return cell;
}

- (void)eliteSwitchDidChangeValue:(EliteSwitch *)sender
{
    switch (sender.tag) {
        case 0:     Preferences.overwriteTargetFile       = sender.on;  break;
        case 1:     Preferences.stopCodingWhenOccursError = sender.on;  break;
        default:    break;
    }
}

@end
