//
//  ProgressViewController.h
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/10.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
#import "EliteButton_Style_001.h"
#import "EliteButton_Style_003.h"
#import "EliteLabel_Style_001.h"


@protocol ProgressViewControllerDelegate;


typedef NS_ENUM(NSUInteger, StretchState) {
    StretchStateUnknown,
    StretchStateClose,
    StretchStateOpen
};


@interface ProgressViewController : UIViewController

@property (weak,   nonatomic) IBOutlet EliteButton_Style_003    *stretchButton;
@property (weak,   nonatomic) IBOutlet YLProgressBar            *progressBar;
@property (weak,   nonatomic) IBOutlet UILabel                  *progressLabel;
@property (weak,   nonatomic) IBOutlet UITextView               *textView;

@property (strong, nonatomic) id<ProgressViewControllerDelegate> delegate;


@property (assign, nonatomic) CGFloat     progress;


@property (assign, nonatomic) StretchState stretchState;


- (IBAction)buttonPressed:(id)sender;


- (void)show;
- (void)hidden;

- (void)clearMessage;
- (void)setProgressMessage:(NSString *)message;
- (void)appendProgressMessage:(NSString *)message;
- (void)appendProgressMessage:(NSString *)message warpLine:(BOOL)warpLine;

@end


#pragma mark - Delegate
@protocol ProgressViewControllerDelegate <NSObject>

- (void)progressViewControllerDidCancel;

@end


