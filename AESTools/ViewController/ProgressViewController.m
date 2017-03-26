//
//  ProgressViewController.m
//  AESTools
//
//  Created by Lifelong-Study on 2016/1/10.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import "ProgressViewController.h"
@import EliteFramework;

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface ProgressViewController () <UITextViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSString          *logTitle;
@property (strong, nonatomic) NSDateFormatter   *dateFormatter;
@property ( nonatomic) CGPoint           point;
@property ( nonatomic) CGRect           viewFrame;
//@property ( nonatomic) CGFloat           ery;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"[yyyy-MM-dd HH:mm:ss.SSS]"];
    
    
    NSArray *tintColors = @[EliteColor(0x00C000), EliteColor(0x006000)];
    

    self.progressBar.progress           = 0;
    self.progressBar.progressTintColors = tintColors;
    self.progressBar.stripesOrientation = YLProgressBarStripesOrientationRight;
    
    
    self.view.layer.cornerRadius  = 20;
    self.view.layer.masksToBounds = YES;
    
    //
    self.stretchState = StretchStateClose;
    
    
    [self.textView setFont:[UIFont fontWithName:@"Arial" size:17]];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAnim:)];
    [self.view addGestureRecognizer:panGesture];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
////    self.longPress.minimumPressDuration = .001;
//    [self.view addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.ery = self.view.frame.origin.y;
    self.viewFrame = self.view.frame;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self.progressBar setProgress:0.01 * progress];
    
    progress < 100.0 ?
        [self.progressLabel setText:[NSString stringWithFormat:@"%.2f%%", progress]] :
        [self.progressLabel setText:[NSString stringWithFormat:@"%.0f%%", progress]] ;
}

- (IBAction)buttonPressed:(id)sender
{
    if (NO) {
    } else if ([sender isEqual:self.stretchButton]) {
        self.stretchState == StretchStateClose ? [self show] : [self hidden];
    }
}

- (void)show
{
    self.stretchState = StretchStateOpen;
    
    CGFloat y = CGRectGetHeight([[UIScreen mainScreen] bounds]) - CGRectGetHeight(self.view.bounds) + 20;
    
    [self animateViewWithY:y];
}

- (void)hidden
{
    self.stretchState = StretchStateClose;
    
    CGFloat y = CGRectGetHeight([[UIScreen mainScreen] bounds]) - CGRectGetHeight(self.stretchButton.bounds);
    
    [self animateViewWithY:y];
}

- (void)animateViewWithY:(CGFloat)y
{
    CGRect frame = self.view.frame;
    
    frame.origin.y = y;
    
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:0.4 animations:^{
        [self.view setFrame:frame];
        
        switch (self.stretchState) {
            case StretchStateClose:
                self.stretchButton.imageView.transform = CGAffineTransformMakeRotation(360 * M_PI / 180.0);
                break;
            case StretchStateOpen:
                self.stretchButton.imageView.transform = CGAffineTransformMakeRotation(180 * M_PI / 180.0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)clearMessage
{
    [self.textView setText:@""];
}

- (void)setProgressMessage:(NSString *)message
{
    [self clearMessage];
    [self appendProgressMessage:message];
}

//- (void)appendProgressFormat:(NSString *)message, ss:(NSString *)s
//{
//    [self appendProgressMessage:message warpLine:YES];
//}

- (void)appendProgressMessage:(NSString *)message
{
    [self appendProgressMessage:message warpLine:YES];
}

- (void)appendProgressMessage:(NSString *)message warpLine:(BOOL)warpLine
{
    NSString *formatterMessage = nil;
    
    // 防呆
    if (message == nil) {
        return ;
    }
    
    
    if (self.textView.text.length <= 0) {
        formatterMessage = [NSString stringWithFormat:@"%@ %@", self.logTitle, message];
    } else if (warpLine != YES) {
        formatterMessage = [NSString stringWithFormat:@"%@%@", self.textView.text, message];
    } else {
        formatterMessage = [NSString stringWithFormat:@"%@\n%@ %@", self.textView.text, self.logTitle, message];
    }
    
    //
    [self.textView setText:formatterMessage];
    
    //
    [self.textView scrollRangeToVisible:NSMakeRange([self.textView.text length], 0)];
}

- (NSString *)logTitle
{
    return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (void)panAnim:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    CGFloat screenHieght = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat viewHeight   = CGRectGetHeight(self.view.bounds) - 20;
    CGFloat buttonHeight = CGRectGetHeight(self.stretchButton.bounds);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.point = [gestureRecognizer locationInView:self.view.window];
            self.viewFrame = self.view.frame;
            break;
        case UIGestureRecognizerStateChanged: {
//        default: {
//            UIPanGestureRecognizer *touch = gestureRecognizer;
            
            
            CGPoint point = [gestureRecognizer locationInView:self.view.window];

            CGRect frame = self.viewFrame;
            

            CGFloat new = frame.origin.y - (self.point.y - point.y);
            
            CGFloat radian = 0;
            
            if (NO) {
                
            } else if (new < screenHieght - viewHeight)   {
                new = screenHieght - viewHeight;
                radian = 180;
            } else if (new > screenHieght - buttonHeight) {
                new = screenHieght - buttonHeight;
                radian = 360;
            } else if (new >= screenHieght - viewHeight && new <= screenHieght - buttonHeight ){
                //
                
                CGFloat e = viewHeight - buttonHeight;
                
                if (self.point.y - point.y > 0) {
                    radian = (new - CGRectGetMinY(self.viewFrame)) / e * 180;
                } else {
                    radian = (new - CGRectGetMinY(self.viewFrame)) / e * 360;
                }
                
//                NSLog(@"ABS(s) * (M_PI / 180) = %f", ABS(radian) * (M_PI / 360));
                
                
            } else {
                NSLog(@"new = %f", new);
            }
            
            
            frame.origin.y = new;
            [self.view setFrame:frame];
//            [self.stretchButton.imageView setTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(ABS(31)))];
//            [self.stretchButton.imageView setTransform:CGAffineTransformRotate(CGAffineTransformIdentity,radian)];
            
        }  break;
        case UIGestureRecognizerStateEnded: {
            CGRect frame = self.view.frame;
            
            CGPoint point = [gestureRecognizer locationInView:self.view.window];

            if (frame.origin.y + frame.size.height < screenHieght) {
                
                [self show];
            } else if (frame.origin.y + frame.size.height > screenHieght) {
                
                // 向上
                if (self.point.y - point.y > 0) {
                    if (frame.origin.y + frame.size.height - screenHieght > 0.75 * frame.size.height) {
                        [self hidden];
                    } else {
                        [self show];
                    }
                } else {
                    if (frame.origin.y + frame.size.height - screenHieght > 0.25 * frame.size.height) {
                        [self hidden];
                    } else {
                        [self show];
                    }
                }
            }
            
        } break;
            
        default:
            break;
    
            
    }
}

@end
