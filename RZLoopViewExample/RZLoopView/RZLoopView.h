//
//  RZLoopView.h
//
//  Created by Zhang Rey on 7/1/14.

//

#import <UIKit/UIKit.h>
@class RZLoopView;
@class LoopEntity;

@protocol RZLooViewDelegate<NSObject>
@optional
- (void)loopView:(RZLoopView *) loopView didClick:(LoopEntity *)ent;
@optional
- (void)loopView:(RZLoopView *) loopView currentPage:(int)page total:(NSUInteger)total;
@end

/**
 * 水平自动无缝循环滚动scrollview，广告效果
 * 一个scrollview，3个子imageview，一个图片数组images，滑动后更换3个imageview的图片。
 */

@interface RZLoopView : UIScrollView<UIScrollViewDelegate>{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;

    CGSize imageSize;
    UIImage *image;
    BOOL _isAuto;
    BOOL _isLoop;
}



@property(nonatomic,strong) NSArray * pics;
@property (nonatomic)   int currentPage;
@property(nonatomic)id<RZLooViewDelegate> RZdelegate;


-(id)initLoopWithPics:(NSArray *)pics withAuto:(BOOL)isAuto;
-(id)initWithPics:(NSArray *)pics withAuto:(BOOL)isAuto;

-(void)releaseTimer;
-(void)upDate;
@end
