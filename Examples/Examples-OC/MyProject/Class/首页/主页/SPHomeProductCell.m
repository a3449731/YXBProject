//
//  SPHomeProductCell.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeProductCell.h"

@interface SPHomeProductCell ()


@end

@implementation SPHomeProductCell

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
    
    self.savePriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.savePriceLabel];
    
    self.robLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.robLabel];
    
    self.percentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.percentLabel];
    
    self.percentProgress = [[UIProgressView alloc] init];
    [self.contentView addSubview:self.percentProgress];
    
    self.saleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.saleLabel];
    
    self.adressLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.adressLabel];
    
    self.randomImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.randomImageView];
    
    self.tipButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.tipButton];
}

/// 首页 秒杀商品 布局
- (void)layoutWithHomeSecikill {
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
         //设置宽高比例
        make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
        //设置优先级
        make.width.height.mas_equalTo(self.contentView).priorityLow();
        make.width.height.lessThanOrEqualTo(self.contentView);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = YXBColorBlack;
    self.nameLabel.numberOfLines = 2;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.productImageView).mas_offset(5);
    }];
    
    self.priceLabel.font = [UIFont boldSystemFontOfSize:17];
    self.priceLabel.textColor = YXBColorRed_Medium;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.centerY.mas_equalTo(self.productImageView);
        make.width.priorityLow();
    }];
    
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.priceLabel);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    self.percentLabel.font = [UIFont systemFontOfSize:10];
    self.percentLabel.textColor = YXBColorGray_999;
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.nameLabel);
       make.bottom.mas_equalTo(self.productImageView).mas_offset(-20);
       make.width.priorityLow();
    }];
    
    self.percentProgress.tintColor = YXBColorGray_CCC;
    self.percentProgress.progressTintColor = YXBColorRed_Medium;
    [self.percentProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.percentLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.percentLabel);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(4);
    }];
    
    [self.randomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.percentLabel.mas_bottom);
        make.right.mas_equalTo(-50);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(26);
    }];
    
    self.robLabel.font = [UIFont systemFontOfSize:12];
    self.robLabel.textColor = YXBColorWhite;
    self.robLabel.textAlignment = NSTextAlignmentCenter;
    self.robLabel.backgroundColor = YXBColorRed_Medium;
    [self.robLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.randomImageView.mas_right);
        make.top.bottom.mas_equalTo(self.randomImageView);
        make.width.mas_equalTo(26);
    }];
    
    self.savePriceLabel.font = [UIFont systemFontOfSize:12];
    self.savePriceLabel.textColor = YXBColorWhite;
    self.savePriceLabel.textAlignment = NSTextAlignmentCenter;
    self.savePriceLabel.backgroundColor = YXBColorRed_Medium;
    self.savePriceLabel.adjustsFontSizeToFitWidth = YES;
    [self.savePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.randomImageView.mas_left);
        make.top.bottom.mas_equalTo(self.randomImageView);
        make.width.mas_equalTo(53);
    }];
}

/// 首页 量贩团 布局
- (void)layoutWithHomeTeamBuy {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
         //设置宽高比例
        make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
        //设置优先级
        make.width.height.mas_equalTo(self.contentView).priorityLow();
        make.width.height.lessThanOrEqualTo(self.contentView);
    }];
    
    self.otherPriceLabel.font = [UIFont systemFontOfSize:12];
    self.otherPriceLabel.textColor = YXBColorRed;
    [self.otherPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.productImageView.mas_bottom).mas_offset(10);
        make.width.priorityLow();
    }];
    
    self.priceLabel.font = [UIFont boldSystemFontOfSize:15];
    self.priceLabel.textColor = YXBColorRed;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.otherPriceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.otherPriceLabel.mas_bottom);
        make.right.mas_equalTo(0);
    }];

    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = YXBColorBlack;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(5);
    }];
}

/// 首页 推荐 布局
- (void)layoutWithHomeRecomend {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
         //设置宽高比例
        make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
        //设置优先级
        make.width.height.mas_equalTo(self.contentView).priorityLow();
        make.width.height.lessThanOrEqualTo(self.contentView);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textColor = YXBColorBlack;
    self.nameLabel.numberOfLines = 2;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.productImageView.mas_bottom).mas_offset(10);
    }];
    
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(16);
    }];
    
    self.adressLabel.font = [UIFont systemFontOfSize:12];
    self.adressLabel.textColor = YXBColorGray_999;
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.tipButton);
        make.width.priorityLow();
    }];
    
    self.saleLabel.font = [UIFont systemFontOfSize:12];
    self.saleLabel.textColor = YXBColorGray_999;
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.adressLabel.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self.tipButton);
    }];
    
    self.priceLabel.font = [UIFont boldSystemFontOfSize:18];
    self.priceLabel.textColor = YXBColorRed;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(self.tipButton.mas_top).mas_offset(-15);
        make.width.priorityLow();
    }];
    
    self.otherPriceLabel.font = [UIFont systemFontOfSize:10];
    self.otherPriceLabel.textColor = YXBColorGray_999;
    [self.otherPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.priceLabel);
    }];
}

/// 商品详情 --- 店铺商品 布局
- (void)layoutWithDetailStoreProduct {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
         //设置宽高比例
        make.width.mas_equalTo(self.productImageView.mas_height).multipliedBy(1);
        //设置优先级
        make.width.height.mas_equalTo(self.contentView).priorityLow();
        make.width.height.lessThanOrEqualTo(self.contentView);
    }];
    
    self.priceLabel.font = [UIFont boldSystemFontOfSize:15];
    self.priceLabel.textColor = YXBColorRed;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.productImageView.mas_bottom).mas_offset(10);
        make.width.priorityLow();
    }];
    
    self.otherPriceLabel.font = [UIFont systemFontOfSize:10];
    self.otherPriceLabel.textColor = YXBColorGray_999;
    [self.otherPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
        make.right.mas_equalTo(0);
    }];
    
    self.savePriceLabel.backgroundColor = YXBColorGray_999;
    [self.savePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.left.mas_equalTo(self.otherPriceLabel);
        make.centerY.mas_equalTo(self.otherPriceLabel);
        make.height.mas_equalTo(1);
    }];
  
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = YXBColorBlack;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(5);
    }];
}


@end
