//
//  MHToolbar.m
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import "MHToolbar.h"

@implementation MHToolbar

- (instancetype)initWithFrame:(CGRect)frame
                  contentType:(MHButtonContentType)contentType
                 contentStyle:(MHButtonContentStyle)contentStyle
              titleLabelScale:(CGFloat)titleLabelScale
                       border:(CGFloat)border
                    midBorder:(CGFloat)midBorder
                  titlesArray:(NSArray *)titlesArray
                  imagesArray:(NSArray *)imagesArray
{
    if (self = [super initWithFrame:frame]) {
        [self setupButtonsWithContentType:contentType contentStyle:contentStyle width:frame.size.width titleLabelScale:titleLabelScale border:border midBorder:midBorder titlesArray:titlesArray imagesArray:imagesArray];
    }
    
    return self;
}

- (void)setupButtonsWithContentType:(MHButtonContentType)contentType
                       contentStyle:(MHButtonContentStyle)contentStyle
                              width:(CGFloat)width
                    titleLabelScale:(CGFloat)titleLabelScale
                             border:(CGFloat)border
                          midBorder:(CGFloat)midBorder
                        titlesArray:(NSArray *)titlesArray
                        imagesArray:(NSArray *)imagesArray
{
    for (int i = 0; i < (titlesArray.count ? titlesArray.count : (imagesArray.count ? imagesArray.count : 0)); i++) {
        MHButton *btn = [[MHButton alloc] initWithContentType:contentType contentStyle:contentStyle titleLabelScale:titleLabelScale border:border midBorder:midBorder];
        btn.tag = i;
        btn.contentEdgeInsets = UIEdgeInsetsMake(kSpace, 0, kSpace, 0);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:(titlesArray.count ? titlesArray[i] : nil) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:width/KScreenW * 13.0f];
        [btn setImage:[UIImage imageNamed:(imagesArray.count ? imagesArray[i] : nil)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = MHColor_(164).CGColor;
        btn.layer.borderWidth = 0.3;
        [self addSubview:btn];
    }
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(toolbar:didClickButton:)]) {
        [self.delegate toolbar:self didClickButton:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIButton *btn in self.subviews) {
        btn.frame = CGRectMake(btn.tag*(self.bounds.size.width/self.subviews.count), 0, self.bounds.size.width/self.subviews.count, self.bounds.size.height);
    }
}

@end
