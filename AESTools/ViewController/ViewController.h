//
//  ViewController.h
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/7.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EliteButton_Style_001.h"
#import "EliteButton_Style_002.h"
#import "Codec.h"


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem        *preferenceBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView            *encryptTableView;
@property (weak, nonatomic) IBOutlet UITableView            *decryptTableView;
@property (weak, nonatomic) IBOutlet EliteButton_Style_001  *encryptButton;
@property (weak, nonatomic) IBOutlet EliteButton_Style_002  *refreshButton;
@property (weak, nonatomic) IBOutlet EliteButton_Style_001  *decryptButton;

- (IBAction)buttonPressed:(id)sender;

@end
