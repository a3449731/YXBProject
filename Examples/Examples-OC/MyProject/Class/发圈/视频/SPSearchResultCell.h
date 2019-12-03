//
//  SPSearchResultCell.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/24.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPSearchResultCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *originPriceLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *memberButton; // 会员
@property (nonatomic, strong) UIButton *seciurButton; // 秒杀
@property (nonatomic, strong) UIButton *saveButton;  // 省，（因为有背景图）
@property (nonatomic, strong) UIButton *saveMoneyButton; // 省了多少钱

@property (nonatomic, strong) UIView *lineView; // 划线

/// 搜索结果的布局
- (void)searchResultStyleLayout;

/// 收藏夹 商品cell
- (void)collectProductStyleLayout;


/// 发圈 推荐商品
- (void)circleProductStyleLayout;

@end

NS_ASSUME_NONNULL_END
