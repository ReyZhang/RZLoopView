//
//  GuidViewController.m
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import "GuidViewController.h"
#import "AppDelegate.h"
#import "RZLoopView.h"
#import "NSMutableArray+RZLoopView.h"

@interface GuidViewController ()

@end

@implementation GuidViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect bounds=[UIScreen mainScreen].bounds;
    self.view.frame=bounds;
 
    NSMutableArray *tempArray=[[NSMutableArray alloc] init];
    [tempArray addPicWithName:@"g1.jpg" title:@""];
    [tempArray addPicWithName:@"g2.jpg" title:@""];
    [tempArray addPicWithName:@"g3.jpg" title:@""];
    [tempArray addPicWithName:@"g4.jpg" title:@""];
    [tempArray addPicWithName:@"g5.jpg" title:@""];
    
    RZLoopView *loopview =[[RZLoopView alloc] initWithPics:tempArray withAuto:NO];
    loopview.RZdelegate=self;
    loopview.frame=self.view.frame;
    [loopview upDate];
    
    [self.view addSubview:loopview];
    
    
}


-(void)removeGuidView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:JumpView object:@(1) userInfo:nil];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.transform=CGAffineTransformMakeScale(2, 2);
        self.view.alpha=0;
    } completion:^(BOOL finished) {

    }];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loopView:(RZLoopView *)loopView currentPage:(int)page total:(NSUInteger)total {
    NSLog(@"page is:%d  total:%d",page,total);
    
    if (loopView.currentPage == total -1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor =  [UIColor redColor].CGColor;
        btn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
        btn.layer.cornerRadius = 10.0;
        btn.layer.borderWidth = 1.0;
        [btn setTitle:@"进入应用" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoApp:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setFrame:CGRectMake((self.view.frame.size.width - 150)/2, CGRectGetMaxY(self.view.frame)-150, 150, 50)];
        [self.view insertSubview:btn aboveSubview:loopView];
    }
    
}

-(void)gotoApp:(id)sender {
    [self removeGuidView:nil];
}


-(void)loopView:(RZLoopView *)loopView didClick:(LoopEntity *)ent {
    
//    NSLog(@"current index:%d",loopView.currentPage);
//    if (loopView.currentPage==loopView.pics.count -1)
//        [self removeGuidView:nil];
}


@end
