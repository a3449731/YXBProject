//
//  SPSearchResultCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/24.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPSearchResultCell.h"

@interface SPSearchResultCell ()


@end

@implementation SPSearchResultCell

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

- (void)searchResultStyleLayout {
    self.iconImageView.image = [UIImage imageNamed:@"sy_wntj_sp1"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.mas_width);
    }];
    
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"sy_wntj_biaoqian"] forState:(UIControlStateNormal)];
    [self.saveButton setTitle:@"省" forState:(UIControlStateNormal)];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.saveMoneyButton setBackgroundImage:[UIImage imageNamed:@"sy_wntj_biaoqian1"] forState:(UIControlStateNormal)];
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
    }];
    
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = UIColorFromHex(#FE154A);
    self.priceLabel.text = @"￥120";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_top).mas_offset(-10);
        make.width.priorityLow();
        make.left.mas_equalTo(20);
        make.top.mas_greaterThanOrEqualTo(self.iconImageView.mas_bottom).mas_offset(10);
    }];
    
    [self.memberButton setImage:[UIImage imageNamed:@"sy_dh_icon5"] forState:(UIControlStateNormal)];
    [self.memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.left.mas_equalTo(5);
        make.width.height.mas_equalTo(10);
    }];
    
    self.originPriceLabel.font = [UIFont systemFontOfSize:10];
    self.originPriceLabel.textColor = UIColorFromHex(#999999);
    self.originPriceLabel.text = @"￥168";
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
//        make.right.mas_equalTo(-5);
    }];
    
    self.lineView.backgroundColor = UIColorFromHex(#999999);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.right.mas_equalTo(self.originPriceLabel);
        make.height.mas_equalTo(1);
    }];
}


- (void)collectProductStyleLayout {
    self.iconImageView.image = [UIImage imageNamed:@"sy_wntj_sp1"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(75);
    }];
    
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"sy_wntj_biaoqian"] forState:(UIControlStateNormal)];
    [self.saveButton setTitle:@"省" forState:(UIControlStateNormal)];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.saveMoneyButton setBackgroundImage:[UIImage imageNamed:@"sy_wntj_biaoqian1"] forState:(UIControlStateNormal)];
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
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.iconImageView);
        make.right.mas_equalTo(-5);
    }];
    
    [self.memberButton setImage:[UIImage imageNamed:@"sy_dh_icon5"] forState:(UIControlStateNormal)];
    [self.memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(-15);
        make.width.height.mas_equalTo(10);
    }];
    
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = UIColorFromHex(#FE154A);
    self.priceLabel.text = @"￥120";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.memberButton);
        make.left.mas_equalTo(self.memberButton.mas_right).mas_offset(3);
    }];
    
    self.lineView.backgroundColor = UIColorFromHex(#999999);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.right.mas_equalTo(self.originPriceLabel);
        make.height.mas_equalTo(1);
    }];
    
    // 借用 变成购物袋按钮
    self.seciurButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.seciurButton setTitleColor:UIColorFromHex(#FE2361) forState:(UIControlStateNormal)];
    self.seciurButton.layer.cornerRadius = 12.5;
    self.seciurButton.layer.borderWidth = 1;
    self.seciurButton.layer.borderColor = UIColorFromHex(#FE2361).CGColor;
    [self.seciurButton setTitle:@"✚ 购物袋" forState:(UIControlStateNormal)];
    [self.seciurButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.memberButton);
        make.right.mas_equalTo(-25);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
}

- (void)circleProductStyleLayout {
    self.iconImageView.image = [UIImage imageNamed:@"sy_wntj_sp1"];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(self.contentView.mas_height).mas_offset(-24);
    }];
 
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = UIColorFromHex(#333333);
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.text = @"MAC魅可口红新色316 磨砂小辣椒牛血色";
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.iconImageView);
        make.right.mas_equalTo(-5);
    }];
    
    
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = UIColorFromHex(#FE154A);
    self.priceLabel.text = @"￥120";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(-15);
    }];
    
    self.originPriceLabel.font = [UIFont systemFontOfSize:10];
    self.originPriceLabel.textColor = UIColorFromHex(#999999);
    self.originPriceLabel.text = @"￥168";
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
//        make.right.mas_equalTo(self.seciurButton.mas_left).mas_offset(-20);
    }];
    
    self.lineView.backgroundColor = UIColorFromHex(#999999);
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.right.mas_equalTo(self.originPriceLabel);
        make.height.mas_equalTo(1);
    }];
    
    // 借用 变成购物袋按钮
    self.seciurButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.seciurButton setTitleColor:UIColorFromHex(#FE2361) forState:(UIControlStateNormal)];
    self.seciurButton.layer.cornerRadius = 12.5;
    self.seciurButton.layer.borderWidth = 1;
    self.seciurButton.layer.borderColor = UIColorFromHex(#FE2361).CGColor;
    [self.seciurButton setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [self.seciurButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.right.mas_equalTo(-25);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
}

@end
