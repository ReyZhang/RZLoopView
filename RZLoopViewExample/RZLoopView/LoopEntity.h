//
//  LoopEntity.h
//  RZLoopViewExample
//
//  Created by Zhang Rey on 12/29/14.
//  Copyright (c) 2014 Zhang Rey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoopEntity : NSObject
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *title;
@property (nonatomic) BOOL isLocal;
@property (nonatomic,strong) UIImage *placeholderImage;

@end
