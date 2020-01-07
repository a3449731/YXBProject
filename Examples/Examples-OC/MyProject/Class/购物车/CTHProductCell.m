//
//  CTHProductCell.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHProductCell.h"

@interface CTHProductCell () <PPNumberButtonDelegate>


@end

@implementation CTHProductCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    self.productImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.productImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    
    self.otherPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.otherPriceLabel];
    
    self.modeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.modeLabel];
    
    self.numberButton = [[PPNumberButton alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.numberButton];
    
    self.chooseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.chooseButton];
    [self.chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

/// 购物车商品 布局
- (void)layoutWithCartProduct {
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chooseButton.mas_right).mas_offset(10);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        //设置宽高比例
        make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
        //设置优先级
        make.width.height.mas_equalTo(self.contentView).priorityLow();
        make.width.height.lessThanOrEqualTo(self.contentView);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = YXBColorBlack;
    self.nameLabel.numberOfLines = 2;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.productImageView).mas_offset(5);
    }];
    
    self.modeLabel.font = [UIFont systemFontOfSize:12];
    self.modeLabel.textColor = YXBColorGray_999;
    [self.modeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(8);
    }];
    
    self.priceLabel.font = [UIFont boldSystemFontOfSize:12];
    self.priceLabel.textColor = YXBColorRed_Medium;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.productImageView.mas_bottom).mas_offset(-10);
        make.width.priorityLow();
    }];
    
    self.numberButton.increaseTitle = @"+";
    self.numberButton.decreaseTitle = @"-";
    self.numberButton.borderColor = YXBColorGray_999;
//    UIImage *image = UIImageWithColor(UIColorFromHex(#F6F6F6));
//    self.numberButton.increaseImage = image;
//    self.numberButton.decreaseImage = image;
    self.numberButton.buttonTitleFont = 15;
    self.numberButton.currentNumber = 1;
    self.numberButton.minValue = 1;
    self.numberButton.editing = NO;
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    self.numberButton.delegate = self;
}

- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    if ([self.delegate respondsToSelector:@selector(CTHProductCell:model:numberButton:increaseStatus:)]) {
        [self.delegate CTHProductCell:self model:self.model numberButton:self.numberButton increaseStatus:increaseStatus];
    }
}

- (void)chooseAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(CTHProductCell:chooseProduct:)]) {
        [self.delegate CTHProductCell:self chooseProduct:self.model];
    }
}

@end
