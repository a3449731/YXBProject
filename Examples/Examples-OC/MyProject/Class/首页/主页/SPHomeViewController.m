//
//  SPHomeViewController.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/9.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "SPHomeViewController.h"
#import <IGListKit/IGListKit.h>
#import <MJRefresh/MJRefresh.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "SPBannerSectionController.h"
#import "SPHomeButtonSection.h"
#import "SPHomeNotificSection.h"
#import "SPHomePictureSection.h"
#import "SPHomeSecKillSection.h"
#import "SPHomeTeamSection.h"
#import "SPRecomendSection.h"

@interface SPHomeViewController () <IGListAdapterDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *navBgView; // 自定义的导航栏view
@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SPHomeViewController

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(@"联云宝");

- (void)setupUI {
    [self setupNavigationItem];
    [self creatCollectionView];
    [self creatNavagationView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    
}

#pragma mark ------------ 自定义导航栏 ------------------
- (void)creatNavagationView {
    
    self.navBgView = [[UIView alloc] init];
    [self.view addSubview:self.navBgView];
    [self.navBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarAndNavigationBarHeight);
    }];
    
    UIView *view = [[UIView alloc] init];
    [self.navBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"sy_Scancode"] forState:(UIControlStateNormal)];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.width.height.mas_equalTo(18);
    }];
    [button addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *titleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [titleButton setImage:[UIImage imageNamed:@"sy_top_name"] forState:(UIControlStateNormal)];
    [view addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setImage:[UIImage imageNamed:@"sy_news"] forState:(UIControlStateNormal)];
    [view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-12);
        make.width.height.mas_equalTo(18);
    }];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 左边action
- (void)leftAction:(UIButton *)button {
    ShowToast(@"点左边");
}

// 右边action
- (void)rightAction:(UIButton *)button {
    ShowToast(@"点右边")
}

#pragma mark ------------- 监听滑动 -----------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + kStatusBarAndNavigationBarHeight;
    if (offsetY > 80) {
        self.navBgView.backgroundColor = RGBAColorWithHEXString(@"#000000", 1);
    } else {
        CGFloat alpha = offsetY / kStatusBarAndNavigationBarHeight;
        self.navBgView.backgroundColor = RGBAColorWithHEXString(@"#000000", alpha);
    }
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(kStatusBarAndNavigationBarHeight, 0, 0, 0);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//    }];
//    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//    }];
//    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
    self.adapter.scrollViewDelegate = self;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isEqual:@"1"]) {
        return [SPBannerSectionController new];
    }
    if ([object isEqual:@"2"]) {
        return [SPHomeButtonSection new];
    }
    if ([object isEqual:@"3"]) {
        return [SPHomeNotificSection new];
    }
    if ([object isEqual:@"4"]) {
        return [SPHomePictureSection new];
    }
    if ([object isEqual:@"5"]) {
        return [SPHomeSecKillSection new];
    }
    if ([object isEqual:@"6"]) {
        return [SPHomeTeamSection new];
    }
    if ([object isEqual:@"7"]) {
        return [SPRecomendSection new];
    }
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
