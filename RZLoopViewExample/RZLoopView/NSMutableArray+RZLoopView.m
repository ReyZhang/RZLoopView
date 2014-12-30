//
//  NSMutableArray+RZLoopView.m
//  RZLoopViewExample
//
//  Created by Zhang Rey on 12/29/14.
//  Copyright (c) 2014 Zhang Rey. All rights reserved.
//

#import "NSMutableArray+RZLoopView.h"
#import "LoopEntity.h"

@implementation NSMutableArray (RZLoopView)

-(void)addPicWithName:(NSString *)pic title:(NSString *)title {
    LoopEntity *entity = [LoopEntity new];
    entity.pic = pic;
    entity.title = title;
    entity.isLocal = YES;
    entity.placeholderImage = nil;
    
    [self addObject:entity];
}
-(void)addPicWithURL:(NSString *)pic title:(NSString *)title placeHolder:(UIImage *)placeholder {
    LoopEntity *entity = [LoopEntity new];
    entity.pic = pic;
    entity.title = title;
    entity.isLocal = NO;
    entity.placeholderImage = placeholder;
    
    [self addObject:entity];
}

@end
