//
//  RZLoopView.m
//
//  Created by Zhang Rey on 7/1/14.

//

#import "RZLoopView.h"
#import "LoopEntity.h"


@implementation RZLoopView


-(id)initLoopWithPics:(NSArray *)pics withAuto:(BOOL)isAuto {
    if (self=[super init]) {
        [self setSelf];
        self.pics=pics;
        _isAuto=isAuto;
        _isLoop=YES;
    }
    return self;
}

-(id)initWithPics:(NSArray *)pics withAuto:(BOOL)isAuto {
    if (self=[super init]) {
        [self setSelf];
        self.pics=pics;
        _isAuto=isAuto;
        _isLoop=NO;
        self.bounces=NO;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isAuto=NO;
        self.frame = frame;
        [self setSelf];
    }
    return self;
}
-(void)setSelf{
    self.pagingEnabled = YES;
    self.scrollEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setSelf];
    
    // Drawing code
}
-(void)upDate{
    NSMutableArray * tempImageArray = [[NSMutableArray alloc]init];
    
    if (_isLoop) {
        [tempImageArray addObject:[self.pics lastObject]];
        for (id obj in self.pics) {
            [tempImageArray addObject:obj];
        }
        [tempImageArray addObject:[self.pics objectAtIndex:0]];
        
        self.pics = Nil;
        self.pics = tempImageArray;
    }
   

    int i = 0;
    for (LoopEntity *ent in self.pics) {
        pic= Nil;
        pic = [UIButton buttonWithType:UIButtonTypeCustom];
        pic.imageView.contentMode = UIViewContentModeTop;
        [pic setFrame:CGRectMake(i*self.frame.size.width,0, self.frame.size.width, self.frame.size.height)];
        UIImageView * tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.height)];
        tempImage.contentMode = UIViewContentModeScaleAspectFill;
        [tempImage setClipsToBounds:YES];
        if (ent.isLocal) {
            [tempImage setImage:[UIImage imageNamed:ent.pic]];
        }else{
            if (ent.placeholderImage) {
                [tempImage setImage:ent.placeholderImage];
            }
            
            NSString *picURL = [ent.pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            /////异步请求web image
            [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:picURL]]
                                               queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                                   if (!error && responseCode == 200) {
                                                       tempImage.image = Nil;
                                                       UIImage *_img = [[UIImage alloc] initWithData:data];
                                                       
                                                       
                                                       //////更新主线程UI
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [tempImage setImage:_img];
                                                       });
                                                       
                                                   }else{
                                                       NSLog(@"load network pic error:%@",error);
                                                       if (ent.placeholderImage) {
                                                           [tempImage setImage:ent.placeholderImage];
                                                       }
                                                   }
                                               }];
        }
        [pic addSubview:tempImage];
        [pic setBackgroundColor:[UIColor grayColor]];
        pic.tag = i;
        [pic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pic];
        
        NSString *strTitle=ent.title;
        if (![strTitle isEqualToString:@""]) {
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(i*self.frame.size.width, self.frame.size.height-30, self.frame.size.width,30)];
            [title setBackgroundColor:[UIColor blackColor]];
            //        [title sette
            [title setAlpha:.7f];
            [title setText:[NSString stringWithFormat:@" %@",ent.title]];
            [title setTextColor:[UIColor whiteColor]];
            [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [self addSubview:title];

        }
        i ++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width*[self.pics count], self.frame.size.height)];
    if (_isLoop)
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];

    
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
    if (_isAuto) {
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
    }
}
-(void)click:(id)sender{
    if (_RZdelegate!=nil && [_RZdelegate respondsToSelector:@selector(loopView:didClick:)])
        [_RZdelegate loopView:self didClick:(LoopEntity *)[self.pics objectAtIndex:[sender tag]]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat Width=self.frame.size.width;
    
    if (_isLoop) {
        if (scrollView.contentOffset.x == self.frame.size.width) {
            flag = YES;
        }
        if (flag) {
            if (scrollView.contentOffset.x <= 0) {
                [self setContentOffset:CGPointMake(Width*([self.pics count]-2), 0) animated:NO];
            }else if (scrollView.contentOffset.x >= Width*([self.pics count]-1)) {
                [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
            }
        }

    }
    _currentPage = scrollView.contentOffset.x/self.frame.size.width-(_isLoop ? 1 : 0 );
    if (_RZdelegate !=nil && [_RZdelegate respondsToSelector:@selector(loopView:currentPage:total:)])
        [_RZdelegate loopView:self currentPage:_currentPage total: _isLoop ? [self.pics count]-2 : self.pics.count];
    
    if (_isLoop)
        scrollTopicFlag = _currentPage+2==2?2:_currentPage+2;
}
-(void)scrollTopic{
    [self setContentOffset:CGPointMake(self.frame.size.width*scrollTopicFlag, 0) animated:YES];
    
    if (scrollTopicFlag > [self.pics count] - (_isLoop ? 0 : 2)) {
        scrollTopicFlag = (_isLoop ? 1 : 0);
    }else {
        scrollTopicFlag++;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_isAuto)
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    
}
-(void)releaseTimer{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
}
@end
