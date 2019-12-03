//
//  YXBButtonCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBButtonCell.h"

@implementation YXBButtonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.button = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
