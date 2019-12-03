//
//  MGiftCell.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGiftCell : YXBCell

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *originPriceLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *memberButton; // 会员
@property (nonatomic, strong) UIButton *seciurButton; // 秒杀
@property (nonatomic, strong) UIButton *saveButton;  // 省，（因为有背景图）
@property (nonatomic, strong) UIButton *saveMoneyButton; // 省了多少钱

@property (nonatomic, strong) UIView *lineView; // 划线

/// 大礼包布局
- (void)giftStyleLayout;

/// 分享专区布局
- (void)shareStyleLayout;

@end

NS_ASSUME_NONNULL_END
