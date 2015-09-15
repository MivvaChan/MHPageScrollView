//
//  UIImageView+MH.m
//  MHPageScrollView
//
//  Created by huazaiCee on 15/9/16.
//  Copyright (c) 2015年 huazaiCee. All rights reserved.
//

#import "UIImageView+MH.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (MH)

// 下载图片
- (void)downloadImage:(NSString *)url place:(UIImage *)place
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
@end
