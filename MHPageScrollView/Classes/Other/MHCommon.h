//
//  MHCommon.h
//  MHPageScrollView
//
//  Created by huazaiCee on 15/9/16.
//  Copyright (c) 2015年 huazaiCee. All rights reserved.
//

#ifndef MHPageScrollView_MHCommon_h
#define MHPageScrollView_MHCommon_h

// 2.适配屏幕比例
#define fit_rate_w KScreenW / 1080.0
#define fit_rate_h KScreenH / 1920.0

// 设备宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 设备高度
#define KScreenH [UIScreen mainScreen].bounds.size.height

// 颜色

// r,g,b 不一样
#define MHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// r,g,b 一样
#define MHColor_(rgb) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]
// 随机色
#define MHRandomColor MHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif
