//
//  SPCommonCell.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPCommonCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commonLabel; // 评论内容
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *shareButton;   // 分享
@property (nonatomic, strong) UIButton *praiseButton; // 点赞
@property (nonatomic, strong) UIButton *detailButton; // 详情按钮


/// 商品评论的布局
- (void)shopCommonStyleLayout;

@end

NS_ASSUME_NONNULL_END
