RZLoopView
==========

无缝滚动的广告图片展示控件。该控件中用到的图片可以是本地图片，也可以是网络图片，使用方便。多个图片资源可以实现自动滚动，而且图片上可以配文字描述，点击图片也可以响影点击动作，可以通过回调函数来处理一些点击后的逻辑。该控件不仅可以用做广告展示，也可以用在引导页面的展示。效果图，如下：
[![](https://raw.github.com/ReyZhang/RZLoopView/master/Screens/1.png)](https://raw.github.com/ReyZhang/RZLoopView/master/Screens/1.png)
[![](https://raw.github.com/ReyZhang/RZLoopView/master/Screens/2.png)](https://raw.github.com/ReyZhang/RZLoopView/master/Screens/2.png)
How to use
==========
不自动滚动

``` objective-c
NSMutableArray *tempArray=[[NSMutableArray alloc] init];
    //////加载本地图片
    [tempArray addPicWithName:@"g1.jpg" title:@""];
    [tempArray addPicWithName:@"g2.jpg" title:@""];
    [tempArray addPicWithName:@"g3.jpg" title:@""];
    [tempArray addPicWithName:@"g4.jpg" title:@""];
    [tempArray addPicWithName:@"g5.jpg" title:@""];
    
    RZLoopView *loopview =[[RZLoopView alloc] initWithPics:tempArray withAuto:NO];
    loopview.RZdelegate=self; //////设置控件的delegate
    loopview.frame=self.view.frame;
    [loopview upDate]; /////初始化或更新控件UI
    
    [self.view addSubview:loopview];
```
效果见图1

自动无缝滚动
``` objective-c
NSMutableArray *tempArray=[[NSMutableArray alloc] init];
    ////加载本地图片
    [tempArray addPicWithName:@"1.jpg" title:@"1"];
    [tempArray addPicWithName:@"2.jpg" title:@"2"];
    [tempArray addPicWithName:@"3.jpg" title:@"3"];
    [tempArray addPicWithName:@"4.jpg" title:@"4"];
    [tempArray addPicWithName:@"5.jpg" title:@"5"];
    ///////加载网络图片
    [tempArray addPicWithURL:@"http://img.159.net/theme/pic/2011/8/5/201185111410.jpg" title:@"network pic" placeHolder:nil];
    
    RZLoopView *loopview =[[RZLoopView alloc] initLoopWithPics:tempArray withAuto:YES];
    loopview.RZdelegate=self; //////设置控件的delegate
    loopview.frame=CGRectMake(0, 0, 320, 240);
    [loopview upDate];  /////初始化或更新控件UI

    [self.view addSubview:loopview];
```
代理方法
``` objective-c
- (void)loopView:(RZLoopView *) loopView didClick:(LoopEntity *)ent {
    /////当点击图片时被执行
}

- (void)loopView:(RZLoopView *) loopView currentPage:(int)page total:(NSUInteger)total {
    /////当图片滑动显示后被执行
}
```

Requirements
============
RZLoopView requires either iOS 5.0 and above.

License
============
RZLoopView is available under the MIT License. See the LICENSE file for more info.

ARC
============
RZLoopView uses ARC.

Contact
============
[Rey Zhang](http://github.com/ReyZhang) 

