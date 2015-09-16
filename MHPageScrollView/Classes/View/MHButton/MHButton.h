//
//  MHButton.h
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSpace 3

typedef NS_ENUM(NSInteger, MHButtonContentType) {
    MHButtonContentTypeDefault,                         // 同时存在titleLabel和imageView
    MHButtonContentTypeOnlyTitleLabel,                  // 只有titleLabel
    MHButtonContentTypeOnlyImageView                    // 只有imageView
};

typedef NS_ENUM(NSInteger, MHButtonContentStyle) {
    MHButtonContentStyleDefault,                        // imageView在左边，titleLabel在右边
    MHButtonContentStyleValue1,                         // imageView在右边，titleLabel在左边
    MHButtonContentStyleValue2,                         // imageView在上边，titleLabel在下边
    MHButtonContentStyleValue3                          // imageView在下边，titleLabel在上边
};

@interface MHButton : UIButton
@property (nonatomic, assign) MHButtonContentType contentType;
@property (nonatomic, assign) MHButtonContentStyle contentStyle;

@property (nonatomic, assign) CGFloat titleLabelScale;  // titleLable相对imageView占整个内容视图的比例(例:如果titleLabel = 0.4,那么imageView的比例为0.6)
@property (nonatomic, assign) CGFloat border;           // 最左侧控件的x值或y值\按钮四周与控件的边界距离
@property (nonatomic, assign) CGFloat midBorder;        // titleLabel和imageView两个控件之间的间距

- (instancetype)initWithContentType:(MHButtonContentType)contentType          // 按钮的内容类型
                       contentStyle:(MHButtonContentStyle)contentStyle        // 按钮的内容布局样式
                    titleLabelScale:(CGFloat)titleLabelScale                  // 按钮上面titleLabel所占比例
                             border:(CGFloat)border                           // 按钮四周与内容控件的边界距离
                          midBorder:(CGFloat)midBorder;                       // 按钮内部titleLabel与imageView之间的间距

@end
