//
//  HomeScrollView.m
//  HealthManager
//
//  Created by hua on 15/7/6.
//  Copyright (c) 2015年 com.hua. All rights reserved.
//

#import "MHPageScrView.h"
#import "MHCommon.h"
#import "UIImageView+MH.h"

@interface MHPageScrView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *images;
@end

@implementation MHPageScrView

/**
 *  网络下载图片
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray*)imageUrls placeImage:(UIImage *)placeImage
{
    if (self = [super initWithFrame:frame]) {
        [self addScrollViewWithImages:imageUrls placeImage:placeImage isUrl:YES];
    }
    
    return self;
}

/**
 *  本地加载图片
 */
- (instancetype)initWithFrame:(CGRect)frame localImages:(NSArray*)images
{
    if (self = [super initWithFrame:frame]) {
        [self addScrollViewWithImages:images placeImage:nil isUrl:NO];
    }
    
    return self;
}

- (void)addScrollViewWithImages:(NSArray *)images placeImage:(UIImage *)placeImage isUrl:(BOOL)isUrl
{
    _images = images;
    
    [self setupScrollViewIsUrl:isUrl placeImage:(UIImage *)placeImage];
    
    CGFloat pageH = 80.0*fit_rate_w;
    [self setupPageControllerWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - pageH*1.4, KScreenW, pageH) currentPageIndicatorTintColor:MHColor_(246) pageIndicatorTintColor:[UIColor lightGrayColor]];
}

/**
 *  添加scrollView
 */
- (void)setupScrollViewIsUrl:(BOOL)isUrl placeImage:(UIImage *)placeImage
{
    // 1.创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, fit_rate_w*441.0)];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    // 2.一些固定的尺寸参数
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    // 3.添加图片到scrollView中
    for (int i = 0; i<_images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        // 设置图片
        if (isUrl) {
            [imageView downloadImage:_images[i] place:placeImage];
        } else {
            imageView.image = [UIImage imageNamed:_images[i]];
        }
        
        [self.scrollView addSubview:imageView];
    }
    
    // 4.设置内容尺寸
    CGFloat contentW = _images.count * self.scrollView.frame.size.width;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    
    // 5.隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 6.分页
    self.scrollView.pagingEnabled = YES;
}

/**
 *  默认添加的pageControl
 */
- (void)setupPageControllerWithFrame:(CGRect)pageFrame currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    // 1.创建pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageFrame];
    [self addSubview:self.pageControl];
    
    // 2.设置pageControl
    [self setupPageControllerWithFrame:pageFrame currentPageIndicatorTintColor:currentPageIndicatorTintColor pageIndicatorTintColor:pageIndicatorTintColor numberOgPages:_images.count];

    // 3.添加定时器
    [self addTimer];
}

/**
 *  默认设置的pageControl
 */
- (void)setupPageControllerWithFrame:(CGRect)pageFrame currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor numberOgPages:(NSInteger)numberOgPages
{
    // 1.设置pageControl
    self.pageControl.frame = pageFrame;
    
    // 2.设置pageControl的总页数
    self.pageControl.numberOfPages = _images.count;
    
    // 3.设置非选中页的圆点颜色
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    
    // 4.设置选中页的圆点颜色
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

/**
 *  自定义pageControl
 */
- (void)setupPageControlFrame:(CGRect)frame currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    [self setupPageControllerWithFrame:frame currentPageIndicatorTintColor:currentPageIndicatorTintColor pageIndicatorTintColor:pageIndicatorTintColor numberOgPages:_images.count];
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextImage
{
    // 1.设置pageControl的页码
    NSInteger page = 0;
    if (self.pageControl.currentPage == _images.count - 1) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self addTimer];
}

@end
