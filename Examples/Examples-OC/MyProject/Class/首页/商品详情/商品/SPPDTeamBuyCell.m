//
//  SPPDTeamBuyCell.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDTeamBuyCell.h"
#import "MZTimerLabel.h"
#import <DateTools/DateTools.h>
#import <YYText/YYText.h>

@interface SPPDTeamBuyCell () <MZTimerLabelDelegate>

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tipLabel; // 还差几人
@property (nonatomic, strong) UILabel *timeLabel; // 倒计时
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) MZTimerLabel *timerExample3;

@end

@implementation SPPDTeamBuyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YXBColorBG_white;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.layer.cornerRadius = 20;
    self.userImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    self.nameLabel.textColor = UIColorFromHex(#000000);
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.userImageView.mas_top);
    }];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.font = [UIFont systemFontOfSize:12];
    self.tipLabel.textColor = YXBColorGray_999;
    [self.contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).mas_offset(15);
        make.bottom.mas_equalTo(self.userImageView.mas_bottom);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.tipLabel);
    }];
    self.timerExample3 = [[MZTimerLabel alloc] initWithLabel:self.timeLabel andTimerType:MZTimerLabelTypeTimer];
    self.timerExample3.delegate = self;
    self.timerExample3.timeFormat = @"HH:mm:ss";
    
    self.joinButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.joinButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.joinButton setTitleColor:YXBColorRed_Medium forState:(UIControlStateNormal)];
    [self.joinButton setTitle:@"去拼团" forState:(UIControlStateNormal)];
    self.joinButton.layer.cornerRadius = 13;
    self.joinButton.layer.borderColor = YXBColorRed_Medium.CGColor;
    self.joinButton.layer.borderWidth = 1;
    [self.contentView addSubview:self.joinButton];
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(26);
    }];
    [self.joinButton addTarget:self action:@selector(joinAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)joinAction:(UIButton *)button {
    ShowToast(@"去拼团");
}

- (void)cellForModel:(id)model {
    self.userImageView.image = [UIImage imageNamed:@"bg1"];
    self.nameLabel.text = @"小鱼";
    self.tipLabel.text = @"还差1人,   剩余";
    
    [self.timerExample3 reset];
    [self.timerExample3 setCountDownToDate:[NSDate dateWithString:@"2020-01-08 20:00:00" formatString:@"yyyy-MM-dd HH:mm:ss"]];
    [self.timerExample3 start];
}

-(NSAttributedString*)timerLabel:(MZTimerLabel*)timerLabel customAttributedTextToDisplayAtTime:(NSTimeInterval)time {

    NSString *hours = [NSString stringWithFormat:@" %02ld ",(long)(time / 3600)];
    NSString *minutes = [NSString stringWithFormat:@" %02ld ",(long)(((NSInteger)time % 3600) / 60)];
    NSString *seconds = [NSString stringWithFormat:@" %02ld ",(long)((NSInteger)time % 60)];
    NSString *timeString = [NSString stringWithFormat:@"%@ : %@ : %@",hours, minutes, seconds];
    
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:timeString];
    att.yy_font = [UIFont systemFontOfSize:12];
    att.yy_color = YXBColorBlack;
    NSRange hourRange = [att.string rangeOfString:hours]; // 从头开始找
    NSRange secondRange = [att.string rangeOfString:seconds options:(NSBackwardsSearch)]; // 从末尾开始找
    // 从 小时 --秒 之间找.
    NSRange minuteRange = [att.string rangeOfString:minutes options:NSCaseInsensitiveSearch range:NSMakeRange(hourRange.location + hourRange.length, att.string.length - hourRange.length - secondRange.length)];
    [att yy_setFont:[UIFont systemFontOfSize:12] range:hourRange];
    [att yy_setColor:YXBColorWhite range:hourRange];
    [att yy_setBackgroundColor:YXBColorBlack range:hourRange];
    
    [att yy_setFont:[UIFont systemFontOfSize:12] range:minuteRange];
    [att yy_setColor:YXBColorWhite range:minuteRange];
    [att yy_setBackgroundColor:YXBColorBlack range:minuteRange];
    
    [att yy_setFont:[UIFont systemFontOfSize:12] range:secondRange];
    [att yy_setColor:YXBColorWhite range:secondRange];
    [att yy_setBackgroundColor:YXBColorRed_Medium range:secondRange];

    return att;
}

@end
