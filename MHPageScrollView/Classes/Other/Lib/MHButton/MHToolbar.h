//
//  MHToolbar.h
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

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

#import <UIKit/UIKit.h>
#import "MHButton.h"
@class MHToolbar;

@protocol MHToolbarDelegate <NSObject>

- (void)toolbar:(MHToolbar *)toolbar didClickButton:(UIButton *)button;

@end

@interface MHToolbar : UIView
@property (nonatomic, weak) id<MHToolbarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame                            // toolbar的frame
                  contentType:(MHButtonContentType)contentType         // 按钮的内容类型
                 contentStyle:(MHButtonContentStyle)contentStyle       // 按钮的内容布局样式
              titleLabelScale:(CGFloat)titleLabelScale                 // 按钮上面titleLabel所占比例
                       border:(CGFloat)border                          // 按钮四周与内容控件的边界距离
                    midBorder:(CGFloat)midBorder                       // 按钮内部titleLabel与imageView之间的间距
                  titlesArray:(NSArray *)titlesArray                   // toolbar上面按钮的文字
                  imagesArray:(NSArray *)imagesArray;                  // toolbar上面按钮的图片
@end
