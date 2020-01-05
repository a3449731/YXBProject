//
//  BannerCell.m
//  BusProject
//
//  Created by 杨 on 2018/5/9.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "SPBannerCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "NSArray+YXBAdd.h"
#import <UIColor+QMUI.h>
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface SPBannerCell() <SDCycleScrollViewDelegate>

@property (nonatomic , strong) HMSegmentedControl *segmentControl;
@property (nonatomic , strong) SDCycleScrollView *bannerView;
@property (nonatomic , strong) NSArray  *modelArray;
@property (nonatomic , strong) UIView *bgView;

@end

@implementation SPBannerCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = YXBColorRed;
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-scaleBase375(70));
            make.top.mas_equalTo(-1000);
        }];
        
        UILabel *allLabel = [[UILabel alloc] init];
        allLabel.font = [UIFont boldSystemFontOfSize:19];
        allLabel.textColor = YXBColorWhite;
        allLabel.text = @"全部";
        [self.contentView addSubview:allLabel];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        [self creatSegment];
        
        [self.contentView addSubview:self.bannerView];
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(scaleBase375(140));
        }];
    }
    return self;
}

#pragma mark ------------ 标签 --------------
- (void)creatSegment {
    self.segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"女装服饰",@"家居百货",@"美妆护肤", @"母婴用品",@"食品零食",@"数码产品",@"潮流箱包",@"运动健康"]];
    self.segmentControl.backgroundColor = [UIColor clearColor];
    // 未选中的字体,颜色
    NSDictionary *normalDic =  @{NSForegroundColorAttributeName : YXBColorWhite,
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    self.segmentControl.titleTextAttributes = normalDic;
    // 选择状态的字体，颜色
    NSDictionary *selectDic = @{NSForegroundColorAttributeName : YXBColorWhite,
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = selectDic;
    // 下划线的位置
//    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorColor = [UIColor clearColor];
//    self.segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -20);
    
    // 内缩
//    self.segmentControl.segmentEdgeInset = UIEdgeInsetsMake(2, 0, 2, 0);
    
    // 分割线位置
//    self.segmentControl.borderType = HMSegmentedControlBorderTypeBottom;
//    self.segmentControl.borderColor = YXBColorBG_gray;
    
    [self.contentView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(62);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(50);
    }];
    [self.segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:(UIControlEventValueChanged)];
}

// 标签的点击方法。
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
}

#pragma mark -------------- 轮播 -------------------
- (SDCycleScrollView *)bannerView {
    if (_bannerView == nil) {

        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageDotColor = [UIColor grayColor];
        _bannerView.autoScrollTimeInterval = 2;
        _bannerView.currentPageDotColor = [UIColor whiteColor];
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bannerView.delegate = self;
    }
    return _bannerView;
}

/* 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ShowToast(@"点击第%ld张轮播图");
//    YXBLOG(@"点击第%ld张图片",index);

}

/* 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    self.bgView.backgroundColor = [UIColor qmui_randomColor];
    
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

- (void)cellForModel:(id)model {
    self.modelArray = model;
//    NSArray *imageArray = [NSArray getPropertyArrayWithString:@"bannerImg" inTheArray:self.modelArray];
    NSArray *imageArray = @[@"sy_banner",@"sy_banner",@"sy_banner"];
    [self.bannerView setLocalizationImageNamesGroup:imageArray];
//    _bannerView.frame = CGRectMake(0, 0, self.size.width, self.height);
}

@end
