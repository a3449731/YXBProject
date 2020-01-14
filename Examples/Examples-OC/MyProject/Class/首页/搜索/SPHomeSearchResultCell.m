//
//  SPHomeSearchResultCell.m
//  OCDemoProject
//
//  Created by 杨 on 14/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeSearchResultCell.h"
//#import "SPProductModel.h"

@interface SPHomeSearchResultCell ()

@property (nonatomic, strong) UIImageView *productImageView; // 商品图片
@property (nonatomic, strong) UILabel *nameLabel; // 商品名字
@property (nonatomic, strong) UILabel *priceLabel; // 价格
@property (nonatomic, strong) UILabel *otherPriceLabel; // 其他价（例如划线价）
@property (nonatomic, strong) UILabel *savePriceLabel; // 省1元
@property (nonatomic, strong) UILabel *robLabel; // 抢
@property (nonatomic, strong) UILabel *percentLabel; // 进度
@property (nonatomic, strong) UIProgressView *percentProgress; // 进度条
@property (nonatomic, strong) UILabel *saleLabel; // 销量
@property (nonatomic, strong) UILabel *adressLabel; // 产地

@property (nonatomic, strong) UIImageView *randomImageView; // 随便哪用往哪补的图
@property (nonatomic, strong) UIButton *tipButton; // 用来放图的（秒杀价, 包邮，等等）

@end

@implementation SPHomeSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = YXBColorBG_white;
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
    
    self.productImageView = [[UIImageView alloc] init];
    [view addSubview:self.productImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    [view addSubview:self.nameLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    [view addSubview:self.priceLabel];
    
    self.otherPriceLabel = [[UILabel alloc] init];
    [view addSubview:self.otherPriceLabel];
    
    self.savePriceLabel = [[UILabel alloc] init];
    [view addSubview:self.savePriceLabel];
    
    self.robLabel = [[UILabel alloc] init];
    [view addSubview:self.robLabel];
    
    self.percentLabel = [[UILabel alloc] init];
    [view addSubview:self.percentLabel];
    
    self.percentProgress = [[UIProgressView alloc] init];
    [view addSubview:self.percentProgress];
    
    self.saleLabel = [[UILabel alloc] init];
    [view addSubview:self.saleLabel];
    
    self.adressLabel = [[UILabel alloc] init];
    [view addSubview:self.adressLabel];
    
    self.randomImageView = [[UIImageView alloc] init];
    [view addSubview:self.randomImageView];
    
    self.tipButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [view addSubview:self.tipButton];
}

/// 搜索 商品 布局
- (void)layoutWithSearchProduct {
    
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
    
    self.nameLabel.font = [UIFont systemFontOfSize:13];
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
    
    self.otherPriceLabel.font = [UIFont systemFontOfSize:10];
    self.otherPriceLabel.textColor = YXBColorGray_999;
    [self.otherPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
        make.right.mas_equalTo(0);
    }];
    
    self.adressLabel.font = [UIFont systemFontOfSize:10];
    self.adressLabel.textColor = YXBColorGray_999;
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.productImageView);
        make.right.mas_equalTo(-10);
    }];
    
    self.saleLabel.font = [UIFont systemFontOfSize:12];
    self.saleLabel.textColor = YXBColorGray_999;
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.adressLabel.mas_top).mas_offset(-5);
        
    }];
    
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.saleLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.saleLabel);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
}

- (void)cellForModel:(id)model {
//
//    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg]];
//    self.nameLabel.text = model.goodsName;
//    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goodsPrice];
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.goodsCost]];
//    [att addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, att.string.length)];
//    self.otherPriceLabel.attributedText = att;
//
//    // 运费
//    if ([model.goodsFreight integerValue] > 0) {
//        [self.tipButton setImage:nil forState:(UIControlStateNormal)];
//    } else {
//        [self.tipButton setImage:[UIImage imageNamed:@"sy_hot_Label"] forState:(UIControlStateNormal)];
//    }
//    self.saleLabel.text = [NSString stringWithFormat:@"已售%@件",model.goodsSale];
//    self.adressLabel.text = model.shopName;
    
        self.productImageView.image = [UIImage imageNamed:@"sy_hot_goods2"];
        self.nameLabel.text = @"2019秋冬新款纯羊绒衫女 半高领加厚毛衣宽松纯...";
        self.priceLabel.text = @"￥59.9";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"￥19.9"];
        [att addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, att.string.length)];
    //    [att setYy_strikethroughStyle:(NSUnderlineStyleSingle)];
        self.otherPriceLabel.attributedText = att;
        [self.tipButton setImage:[UIImage imageNamed:@"sy_hot_Label"] forState:(UIControlStateNormal)];
        self.saleLabel.text = @"已售100件";
        self.adressLabel.text = @"广州";
}

@end
