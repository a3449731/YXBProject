//
//  MGiftCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MGiftCell.h"
//#import "HomeModel.h"

@implementation MGiftCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    
    self.priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    
    self.originPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.originPriceLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.memberButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.memberButton];
    
    self.seciurButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.seciurButton];
    
    self.saveButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.saveButton];
    
    self.saveMoneyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.saveMoneyButton];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
}

/// 大礼包布局
- (void)giftStyleLayout {

//    self.saveButton.hidden = YES;
//    self.saveMoneyButton.hidden = YES;
    
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = UIColorFromHex(#333333);
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.text = @"MAC魅可口红新色316 磨砂小辣椒牛血色";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(34);
    }];
    
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = UIColorFromHex(#F1B25E);
    self.priceLabel.text = @"￥120";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_top).mas_offset(-10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15);
    }];
    
    [self.memberButton setImage:[UIImage imageNamed:@"hyzx_vip"] forState:(UIControlStateNormal)];
    [self.memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.left.mas_equalTo(5);
        make.width.height.mas_equalTo(10);
    }];
    
    self.iconImageView.image = [UIImage imageNamed:@"sy_wntj_sp1"];
       [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.left.right.mas_equalTo(0);
           make.bottom.mas_equalTo(self.priceLabel.mas_top).mas_offset(-10);
       }];
}

/// 分享专区布局
- (void)shareStyleLayout {
//    self.saveButton.hidden = NO;
//    self.saveMoneyButton.hidden = NO;
//    
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"hyzx_bq_zq"] forState:(UIControlStateNormal)];
    [self.saveButton setTitle:@"赚" forState:(UIControlStateNormal)];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.saveMoneyButton setBackgroundImage:[UIImage imageNamed:@"hyzx_bq_zq"] forState:(UIControlStateNormal)];
    [self.saveMoneyButton setTitle:@"￥39" forState:(UIControlStateNormal)];
    [self.saveMoneyButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.saveMoneyButton.titleLabel.font = [UIFont systemFontOfSize:8];
    [self.saveMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.saveButton.mas_right).mas_offset(1);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];
    
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = UIColorFromHex(#333333);
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.text = @"MAC魅可口红新色316 磨砂小辣椒牛血色";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(34);
    }];
    
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = UIColorFromHex(#F1B25E);
    self.priceLabel.text = @"￥120";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_top).mas_offset(-10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15);
    }];
    
    [self.memberButton setImage:[UIImage imageNamed:@"hyzx_vip"] forState:(UIControlStateNormal)];
    [self.memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.left.mas_equalTo(5);
        make.width.height.mas_equalTo(10);
    }];
    
    self.iconImageView.image = [UIImage imageNamed:@"sy_wntj_sp1"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.priceLabel.mas_top).mas_offset(-10);
    }];
}


//- (void)cellForModel:(ProductModel *)model {
//    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
//    self.originPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.originalPrice];
//    self.nameLabel.text = model.goodsName;
//    NSString *savePrice = [NSString stringWithFormat:@"￥%.2f",[model.originalPrice floatValue] - [model.price floatValue]];
//    [self.saveMoneyButton setTitle:savePrice forState:(UIControlStateNormal)];
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:nil];
//}

@end
