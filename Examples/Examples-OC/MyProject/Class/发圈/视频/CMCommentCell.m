//
//  CMCommentCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMCommentCell.h"
#import "CMCommentModel.h"

@interface CMCommentCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *likeButton;

@end


@implementation CMCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self creatUI];
//    }
//    return self;
//}

- (void)creatUI {
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentLabel];
    
    self.likeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.likeButton];
    
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.cornerRadius = 12.5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(25);
    }];
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.nameLabel.textColor = UIColorFromHex(#333333);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.right.mas_equalTo(-30);
    }];
    
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = UIColorFromHex(#999999);
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(-30);
    }];
    
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = UIColorFromHex(#333333);
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)cellWithModel:(CMCommentModel *)model {
    self.nameLabel.text = model.userName;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userHead] placeholderImage:nil];
    self.timeLabel.text = model.create_time;
    self.contentLabel.text = model.context;
}

@end
