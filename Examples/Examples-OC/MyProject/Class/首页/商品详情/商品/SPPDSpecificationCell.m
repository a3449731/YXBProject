//
//  SPPDSpecificationCell.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDSpecificationCell.h"

@interface SPPDSpecificationCell ()

@property (nonatomic, strong) UILabel *specificationLabel; // 规格

@end

@implementation SPPDSpecificationCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YXBColorBG_white;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    UILabel *modeLabel = [[UILabel alloc] init];
    modeLabel.font = [UIFont systemFontOfSize:12];
    modeLabel.textColor = YXBColorGray_999;
    modeLabel.text = @"规格";
    [self.contentView addSubview:modeLabel];
    [modeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    
    self.specificationLabel = [[UILabel alloc] init];
    self.specificationLabel.font = [UIFont systemFontOfSize:12];
    self.specificationLabel.textColor = YXBColorBlack;
    [self.contentView addSubview:self.specificationLabel];
    [self.specificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(modeLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(0);
    }];
    
    QMUIButton *accrowButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    accrowButton.tintColor = YXBColorBlack;
    accrowButton.adjustsImageTintColorAutomatically = YES;
    [accrowButton setImage:[UIImage imageNamed:@"grzx_jiantou"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:accrowButton];
    [accrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
    }];
    
}

- (void)cellForModel:(id)model {
    self.specificationLabel.text = @"选择尺寸颜色";
}

@end
