//
//  SPPDInfoCell.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDInfoCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "NSArray+YXBAdd.h"
#import "MZTimerLabel.h"
#import <DateTools/DateTools.h>
#import <YYText/YYText.h>
#import <QMUIImagePreviewViewController.h>
#import <UIView+QMUI.h>

@interface SPPDInfoCell() <SDCycleScrollViewDelegate,MZTimerLabelDelegate,QMUIImagePreviewViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSArray  *modelArray;

@property (nonatomic, strong) UILabel *nameLabel; // 商品名字
@property (nonatomic, strong) UILabel *priceLabel; // 价格
@property (nonatomic, strong) UILabel *otherPriceLabel; // 其他价（例如划线价）
@property (nonatomic, strong) UIView *lineView; // 灰色划线
@property (nonatomic, strong) UIButton *tipsButton; // 返现,
@property (nonatomic, strong) UILabel *adressLabel; // 产地
@property (nonatomic, strong) UILabel *expressLabel; // 快递费
@property (nonatomic, strong) QMUIButton *saleButton; // 月销 / 团购

@property (nonatomic, strong) UIImageView *seckillImageView; // 秒杀

@property (nonatomic, strong) UILabel *timeLabel; // 倒计时
@property (nonatomic, strong) MZTimerLabel *timerExample3;

@end

@implementation SPPDInfoCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YXBColorBG_white;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    [self.contentView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(scaleBase375(280));
    }];
    
    // 倒计时
    [self creatTimeLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.textColor = YXBColorRed_Medium;
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.centerY.mas_equalTo(self.timeLabel);
        make.width.priorityLow();
    }];
    
    self.otherPriceLabel = [[UILabel alloc] init];
    self.otherPriceLabel.font = [UIFont systemFontOfSize:10];
    self.otherPriceLabel.textColor = YXBColorGray_999;
    [self.contentView addSubview:self.otherPriceLabel];
    [self.otherPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
        make.width.priorityLow();
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.otherPriceLabel);
        make.centerX.mas_equalTo(self.otherPriceLabel);
        make.width.mas_equalTo(self.otherPriceLabel);
        make.height.mas_equalTo(1);
    }];
    
    self.tipsButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.tipsButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.tipsButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.tipsButton];
    [self.tipsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.otherPriceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.priceLabel);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = YXBColorBlack;
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(10);
    }];
    
    self.expressLabel = [[UILabel alloc] init];
    self.expressLabel.font = [UIFont systemFontOfSize:12];
    self.expressLabel.textColor = YXBColorGray_999;
    [self.contentView addSubview:self.expressLabel];
    [self.expressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(-15);
        make.width.priorityLow();
    }];
    
    self.saleButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.saleButton.imagePosition = QMUIButtonImagePositionLeft;
    self.saleButton.spacingBetweenImageAndTitle = 10;
    self.saleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.saleButton setTitleColor:YXBColorGray_999 forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.saleButton];
    [self.saleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.expressLabel);
    }];
    
    self.adressLabel = [[UILabel alloc] init];
    self.adressLabel.font = [UIFont systemFontOfSize:12];
    self.adressLabel.textColor = YXBColorGray_999;
    [self.contentView addSubview:self.adressLabel];
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(self.expressLabel);
    }];
    
    self.seckillImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.seckillImageView];
    [self.seckillImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.height.mas_equalTo(88);
    }];
}


#pragma mark -------------- 轮播 -------------------
- (SDCycleScrollView *)bannerView {
    if (_bannerView == nil) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageDotColor = [UIColor grayColor];
        //        _bannerView.autoScrollTimeInterval = 2;
        _bannerView.autoScroll = NO;
        _bannerView.currentPageDotColor = [UIColor whiteColor];
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bannerView.delegate = self;
    }
    return _bannerView;
}

/* 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    QMUIImagePreviewViewController *vc = [[QMUIImagePreviewViewController alloc] init];
    //    vc.presentingStyle = QMUIImagePreviewViewControllerTransitioningStyleZoom;
    vc.imagePreviewView.delegate = self;
    vc.imagePreviewView.currentImageIndex = index;
    [self.qmui_viewController presentViewController:vc animated:YES completion:nil];
}

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.modelArray.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    
    zoomImageView.reusedIdentifier = @(index);
    // 模拟异步加载的情况
    if (index == 2) {
        [zoomImageView showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([zoomImageView.reusedIdentifier isEqual:@(index)]) {
                [zoomImageView hideEmptyView];
                zoomImageView.image = [UIImage imageNamed:self.modelArray[index]];
            }
        });
    } else {
        zoomImageView.image = [UIImage imageNamed:self.modelArray[index]];
    }
}

/* 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    
    //    YXBLOG(@"滚动到第%ld张图片",index);
}


//// 不需要自定义轮播cell的请忽略以下两个的代理方法
//
//// ========== 轮播自定义cell ==========
//
///** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
//- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view;
//
///** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
//- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view;
//
///** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
//- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view;

#pragma mark -------------- 倒计时 -------------------
- (void)creatTimeLabel {
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = YXBColorBlack;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.bannerView.mas_bottom).mas_offset(25);
    }];
    self.timerExample3 = [[MZTimerLabel alloc] initWithLabel:self.timeLabel andTimerType:MZTimerLabelTypeTimer];
//    self.timerExample3.delegate = self;
    self.timerExample3.timeFormat = @"HH:mm:ss";
}

//-(NSString*)timerLabel:(MZTimerLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time {
//    NSString *hours = [NSString stringWithFormat:@" %02ld ",(long)(time / 3600)];
//    NSString *minutes = [NSString stringWithFormat:@" %02ld ",(long)(((NSInteger)time % 3600) / 60)];
//    NSString *seconds = [NSString stringWithFormat:@" %02ld ",(long)((NSInteger)time % 60)];
//    NSString *timeString = [NSString stringWithFormat:@"距结束 %@ : %@ : %@",hours, minutes, seconds];
//    return timeString;
//}

- (NSAttributedString*)timerLabel:(MZTimerLabel*)timerLabel customAttributedTextToDisplayAtTime:(NSTimeInterval)time {
    
    NSString *hours = [NSString stringWithFormat:@" %02ld ",(long)(time / 3600)];
    NSString *minutes = [NSString stringWithFormat:@" %02ld ",(long)(((NSInteger)time % 3600) / 60)];
    NSString *seconds = [NSString stringWithFormat:@" %02ld ",(long)((NSInteger)time % 60)];
    NSString *timeString = [NSString stringWithFormat:@"距结束 %@ : %@ : %@",hours, minutes, seconds];
    
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:timeString];
    att.yy_font = [UIFont systemFontOfSize:12];
    att.yy_color = UIColorFromHex(#666666);
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

// 普通的商品详情
- (void)cellForProduct:(id)model {
    
    self.timeLabel.hidden = YES;
    self.timerExample3.delegate = nil;
    self.seckillImageView.image = nil;
    
    //    NSArray *imageArray = [NSArray getPropertyArrayWithString:@"bannerImg" inTheArray:self.modelArray];
    NSArray *imageArray = @[@"sy_banner",@"sy_banner",@"sy_banner"];
    self.modelArray = imageArray;
    [self.bannerView setLocalizationImageNamesGroup:imageArray];
    //    _bannerView.frame = CGRectMake(0, 0, self.size.width, self.height);
    
    self.priceLabel.text = @"￥230";
    self.otherPriceLabel.text = @"￥122";
    self.lineView.backgroundColor = YXBColorGray_999;
    
    [self.tipsButton setTitle:@"   返消费积分23000  " forState:(UIControlStateNormal)];
    UIImage *image = [UIImage imageNamed:@"sy_pt_sjasfja"];
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:(image.size.width / 2) topCapHeight:(image.size.height / 2)];
    [self.tipsButton setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
    self.nameLabel.text = @"法国Dior迪奥进口哑光999口红女烈焰蓝金 唇膏047/787/766";
    self.expressLabel.text = @"快递：0.00";
    [self.saleButton setTitle:@"月销2133笔" forState:(UIControlStateNormal)];
    [self.saleButton setImage:nil forState:(UIControlStateNormal)];
    self.adressLabel.text = @"广东 广州";
}

// 秒杀商品详情
- (void)cellForSeckill:(id)model {
    //    NSArray *imageArray = [NSArray getPropertyArrayWithString:@"bannerImg" inTheArray:self.modelArray];
    NSArray *imageArray = @[@"sy_banner",@"sy_banner",@"sy_banner"];
    self.modelArray = imageArray;
    [self.bannerView setLocalizationImageNamesGroup:imageArray];
    //    _bannerView.frame = CGRectMake(0, 0, self.size.width, self.height);
    
    self.priceLabel.text = @"￥230";
    self.otherPriceLabel.text = @"秒杀价";
    self.lineView.backgroundColor = [UIColor clearColor];
    
    [self.tipsButton setTitle:@"   返消费积分23000  " forState:(UIControlStateNormal)];
    UIImage *image = [UIImage imageNamed:@"sy_pt_sjasfja"];
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:(image.size.width / 2) topCapHeight:(image.size.height / 2)];
    [self.tipsButton setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
    self.timerExample3.delegate = self;
    [self.timerExample3 reset];
    [self.timerExample3 setCountDownToDate:[NSDate dateWithString:@"2020-01-09 08:00:00" formatString:@"yyyy-MM-dd HH:mm:ss"]];
    [self.timerExample3 start];
    
    self.nameLabel.text = @"法国Dior迪奥进口哑光999口红女烈焰蓝金 唇膏047/787/766";
    self.expressLabel.text = @"快递：0.00";
    [self.saleButton setTitle:@"月销2133笔" forState:(UIControlStateNormal)];
    [self.saleButton setImage:nil forState:(UIControlStateNormal)];
    self.adressLabel.text = @"广东 广州";
    self.seckillImageView.image = [UIImage imageNamed:@"sy_xsms_biaoqian"];
}

// 团购商品详情
- (void)cellForTeamBuy:(id)model {
    
    self.timeLabel.hidden = YES;
    self.timerExample3.delegate = nil;
    self.seckillImageView.image = nil;
    
    //    NSArray *imageArray = [NSArray getPropertyArrayWithString:@"bannerImg" inTheArray:self.modelArray];
    NSArray *imageArray = @[@"sy_banner",@"sy_banner",@"sy_banner"];
    self.modelArray = imageArray;
    [self.bannerView setLocalizationImageNamesGroup:imageArray];
    //    _bannerView.frame = CGRectMake(0, 0, self.size.width, self.height);
    
    self.priceLabel.text = @"￥230";
    self.otherPriceLabel.text = @"￥133";
    self.lineView.backgroundColor = YXBColorGray_999;
    
    [self.tipsButton setTitle:@"   拼团价  " forState:(UIControlStateNormal)];
    UIImage *image = [UIImage imageNamed:@"sy_pt_sjasfja"];
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:(image.size.width / 2) topCapHeight:(image.size.height / 2)];
    [self.tipsButton setBackgroundImage:newImage forState:(UIControlStateNormal)];
    
    self.nameLabel.text = @"法国Dior迪奥进口哑光999口红女烈焰蓝金 唇膏047/787/766";
    self.expressLabel.text = @"快递：0.00";
    [self.saleButton setTitle:@"3人成团·已团2635件" forState:(UIControlStateNormal)];
    [self.saleButton setImage:[UIImage imageNamed:@"tuangou_icon1"] forState:(UIControlStateNormal)];
    [self.saleButton sizeToFit];
    self.adressLabel.text = @"广东 广州";
}

@end
