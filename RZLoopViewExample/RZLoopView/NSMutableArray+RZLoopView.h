//
//  NSMutableArray+RZLoopView.h
//  RZLoopViewExample
//
//  Created by Zhang Rey on 12/29/14.
//  Copyright (c) 2014 Zhang Rey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableArray (RZLoopView)

-(void)addPicWithName:(NSString *)pic title:(NSString *)title;
-(void)addPicWithURL:(NSString *)pic title:(NSString *)title placeHolder:(UIImage *)placeholder;
@end
