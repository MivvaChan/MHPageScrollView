//
//  MHViewController.m
//  MHPageScrollView
//
//  Created by huazaiCee on 15/9/16.
//  Copyright (c) 2015年 huazaiCee. All rights reserved.
//

#import "MHViewController.h"
#import "MHPageScrView.h"
#import "MHCommon.h"
#import "MHToolbar.h"

#define kScrollViewH (fit_rate_w*441.0)

@interface MHViewController () <MHToolbarDelegate>
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) MHPageScrView *pageScrView1;
@property (nonatomic, strong) MHPageScrView *pageScrView2;
@end

@implementation MHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加标签栏
    MHToolbar *toolbar = [[MHToolbar alloc] initWithFrame:CGRectMake(0, 300, KScreenW, 35) contentType:MHButtonContentTypeOnlyTitleLabel contentStyle:MHButtonContentStyleDefault titleLabelScale:1.0f border:0 midBorder:0 titlesArray:@[@"本地加载图片", @"网络下载图片"] imagesArray:nil];
    toolbar.delegate = self;
    toolbar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:toolbar];
    
    // 2.初始化图片轮播器
    CGFloat h = kScrollViewH;
    self.pageScrView1 = [[MHPageScrView alloc] initWithFrame:CGRectMake(0, 50, KScreenW, h) imageUrls:@[@"http://a.hiphotos.baidu.com/image/pic/item/1f178a82b9014a90aeefd5dcaf773912b21beefa.jpg", @"http://pic30.nipic.com/20130624/7447430_170252095000_2.jpg", @"http://img.taopic.com/uploads/allimg/110819/1717-110Q9215S612.jpg"] placeImage:nil];
    self.pageScrView2 = [[MHPageScrView alloc] initWithFrame:CGRectMake(0, 50, KScreenW, h) localImages:@[@"index_banner1", @"index_banner2", @"index_banner3"]];
    
    // 3.添加轮播器
    [self toolbar:toolbar didClickButton:nil];
}

#pragma mark MHToolbarDelegate
- (void)toolbar:(MHToolbar *)toolbar didClickButton:(UIButton *)button
{
    // 1.控制按钮状态
    _selectedBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    button.backgroundColor = [UIColor grayColor];
    _selectedBtn = button;
    
    // 2.选择图片轮播器
    if (button.tag == 1) { // 添加scrollView(网络下载图片)
        
        [_pageScrView2 removeFromSuperview];
        [self.view addSubview:_pageScrView1];
        
        // 自定义分页指示器（如果不自定，则使用默认的）
        CGFloat w = 50;
        [self.pageScrView1 setupPageControlFrame:CGRectMake(KScreenW - w - 5, kScrollViewH - 10*1.4, w, 10) currentPageIndicatorTintColor:[UIColor redColor] pageIndicatorTintColor:[UIColor groupTableViewBackgroundColor]];
    
    } else { // 添加scrollView(本地加载图片)
        [_pageScrView1 removeFromSuperview];
        [self.view addSubview:_pageScrView2];
    }
}

@end
