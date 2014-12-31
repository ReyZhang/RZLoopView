//
//  ViewController.m
//  RZLoopViewExample
//
//  Created by Zhang Rey on 12/29/14.
//  Copyright (c) 2014 Zhang Rey. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+RZLoopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    NSMutableArray *tempArray=[[NSMutableArray alloc] init];
    [tempArray addPicWithName:@"1.jpg" title:@"1"];
    [tempArray addPicWithName:@"2.jpg" title:@"2"];
    [tempArray addPicWithName:@"3.jpg" title:@"3"];
    [tempArray addPicWithName:@"4.jpg" title:@"4"];
    [tempArray addPicWithName:@"5.jpg" title:@"5"];
    ///////加载网络图片
    [tempArray addPicWithURL:@"http://img.159.net/theme/pic/2011/8/5/201185111410.jpg" title:@"network pic" placeHolder:nil];
    
    RZLoopView *loopview =[[RZLoopView alloc] initLoopWithPics:tempArray withAuto:YES];
    loopview.RZdelegate=self;
    loopview.frame=CGRectMake(0, 0, bounds.size.width, 240);
    [loopview upDate];
    
    [self.view addSubview:loopview];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor =  [UIColor redColor].CGColor;
    btn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
    btn.layer.cornerRadius = 10.0;
    btn.layer.borderWidth = 1.0;
    [btn setTitle:@"回退到引导视图" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoGuid:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setFrame:CGRectMake((self.view.frame.size.width - 150)/2, CGRectGetMaxY(self.view.frame)-150, 150, 50)];
    [self.view insertSubview:btn aboveSubview:loopview];

    
}


-(void)gotoGuid:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:JumpView object:@(0)];
}


- (void)loopView:(RZLoopView *) loopView didClick:(LoopEntity *)ent {
    
}

- (void)loopView:(RZLoopView *) loopView currentPage:(int)page total:(NSUInteger)total {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
