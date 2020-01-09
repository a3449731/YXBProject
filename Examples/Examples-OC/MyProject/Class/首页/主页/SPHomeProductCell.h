//
//  SPHomeProductCell.h
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPHomeProductCell : YXBCell

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

/// 首页 秒杀商品 布局
- (void)layoutWithHomeSecikill;

/// 首页 量贩团 布局
- (void)layoutWithHomeTeamBuy;

/// 首页 推荐 布局
- (void)layoutWithHomeRecomend;

/// 商品详情 --- 店铺商品 布局
- (void)layoutWithDetailStoreProduct;

@end

NS_ASSUME_NONNULL_END
