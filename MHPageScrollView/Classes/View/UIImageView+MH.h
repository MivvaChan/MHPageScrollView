//
//  UIImageView.h
//  MHPageScrollView
//
//  Created by huazaiCee on 15/9/16.
//  Copyright (c) 2015年 huazaiCee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MH)
/**
 *  下载图片
 */
- (void)downloadImage:(NSString *)url place:(UIImage *)place;
@end
