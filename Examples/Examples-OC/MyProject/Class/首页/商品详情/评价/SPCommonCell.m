//
//  SPCommonCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPCommonCell.h"

@interface SPCommonCell ()


@end

@implementation SPCommonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.userImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.userImageView];
    
    self.userLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.userLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    self.commonLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.commonLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:self.collectionView];
    
    self.bottomView = [[UIView alloc] init];
    [self.contentView addSubview:self.bottomView];
    
    self.shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomView addSubview:self.shareButton];
    
    self.praiseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomView addSubview:self.praiseButton];
    
    self.detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomView addSubview:self.detailButton];
}

- (void)shopCommonStyleLayout {
    self.userImageView.image = [UIImage imageNamed:@"sy_spxq_tx"];
    self.userImageView.layer.cornerRadius = 12.5;
    self.userImageView.layer.masksToBounds = YES;
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.width.height.mas_equalTo(25);
    }];
    
    self.userLabel.font = [UIFont systemFontOfSize:12];
    self.userLabel.textColor = UIColorFromHex(#333333);
    self.userLabel.text = @"大***咻";
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).mas_offset(5);
        make.top.mas_equalTo(self.userImageView.mas_top);
    }];
    
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = UIColorFromHex(#999999);
    self.timeLabel.text = @"2019-07-23 10:38:57";
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).mas_equalTo(5);
        make.bottom.mas_equalTo(self.userImageView.mas_bottom);
    }];
    
    self.commonLabel.font = [UIFont systemFontOfSize:12];
    self.commonLabel.textColor = UIColorFromHex(333333);
    self.commonLabel.numberOfLines = 0;
    self.commonLabel.text = @"总体效果还是不错的，确实超级水润，外壳内里颜值都很高，挺适合干燥的夏天，真的是太美丽了，感觉12个色都值得拥有。爱不释手，颜色";
    [self.commonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.userImageView.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-16);
    }];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
        make.top.mas_equalTo(self.commonLabel.mas_bottom).mas_offset(10);
    }];
}



@end
