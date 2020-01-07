//
//  CTHEmptyCell.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHEmptyCell.h"

@implementation CTHEmptyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    QMUIButton *emptyButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    emptyButton.imagePosition = QMUIButtonImagePositionTop;
    emptyButton.spacingBetweenImageAndTitle = 10;
    emptyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [emptyButton setTitleColor:YXBColorGray_999 forState:(UIControlStateNormal)];
    [emptyButton setTitle:@"你的购物车空空如也" forState:(UIControlStateNormal)];
    [emptyButton setImage:[UIImage imageNamed:@"gwc_icon"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:emptyButton];
    [emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_centerY).mas_offset(20);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = YXBColorBlack;
    label.text = @"去挑几件好货吧";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyButton.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(0);
    }];
    
    QMUIButton *goButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    goButton.adjustsButtonWhenHighlighted = YES;
    goButton.backgroundColor = YXBColorRed_Medium;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    goButton.layer.cornerRadius = 12;
    [goButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [goButton setTitle:@"去逛逛" forState:(UIControlStateNormal)];
    [self.contentView addSubview:goButton];
    [goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    [goButton addTarget:self action:@selector(goAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)goAction:(UIButton *)button {
    ShowToast(@"去逛逛");
}

@end
