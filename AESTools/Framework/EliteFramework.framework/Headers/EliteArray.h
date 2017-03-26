//
//  EliteArray.h
//  EliteFramework
//
//  Created by Lifelong-Study on 2016/2/20.
//  Copyright © 2016年 Lifelong-Study. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (EliteArrayCategory)

- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;

@end


@interface NSMutableArray (EliteMutableArrayCategory)

- (NSMutableArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;

@end