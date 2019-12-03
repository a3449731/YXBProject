//
//  YXBReusableView.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBHeaderView.h"

@implementation YXBHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.leftButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.leftButton];
    [self.leftButton addTarget:self action:@selector(tapLeftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rightButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.rightButton];
    [self.rightButton addTarget:self action:@selector(tapRightAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
}

- (void)tapLeftAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(reusableView:tapLeftButton:)]) {
        [self.delegate reusableView:self tapLeftButton:button];
    }
}

- (void)tapRightAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(reusableView:tapRightButton:)]) {
        [self.delegate reusableView:self tapRightButton:button];
    }
}


@end
