//
//  SPProductDetailViewController.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPProductDetailViewController.h"
#import <UIView+QMUI.h>
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <CALayer+QMUI.h>
#import "SPPDetailView.h"
#import "SPPCommonView.h"
#import "SPPDWebView.h"

@interface SPProductDetailViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *navBarView; // 自定义的导航栏view
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *bottomView; // 底部
@property (nonatomic, strong) QMUIButton *collectButton; // 收藏

@end

@implementation SPProductDetailViewController

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self creatNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(@"");

- (void)setupUI {
    self.view.backgroundColor = YXBColorBG_white;
    [self creatNavagationView];
    [self creatSegement];
    [self creatDetaiView];
    [self creatCommentView];
    [self creatWebView];
    [self creatBottomView];
}

- (void)setupTool {
    
}

- (void)setupData {
    
}

#pragma mark ------------ 自定义导航栏 ------------------
- (void)creatNavagationView {
    
    UIView *view = [[UIView alloc] init];
    view.qmui_borderLocation = QMUIViewBorderLocationInside;
    view.qmui_borderPosition = QMUIViewBorderPositionBottom;
    view.qmui_borderColor = UIColorFromHex(#F4F4F4);
    view.qmui_borderWidth = 1;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarAndNavigationBarHeight);
    }];
    
    self.navBarView = [[UIView alloc] init];
    [view addSubview:self.navBarView];
    [self.navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"sy_fanhui"] forState:(UIControlStateNormal)];
    [self.navBarView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.width.height.mas_equalTo(18);
    }];
    [button addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 左边action
- (void)leftAction:(UIButton *)button {
    [self backToPreviousViewController];
}

#pragma mark --------------- 标签 --------------
- (void)creatSegement {

    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"商品", @"评价",@"详情"]];
    self.segmentedControl4.backgroundColor = [UIColor clearColor];
    // 未选中的字体,颜色
    NSDictionary *normalDic =  @{NSForegroundColorAttributeName : YXBColorBlack,
                                 NSFontAttributeName : [UIFont systemFontOfSize:14]};
    self.segmentedControl4.titleTextAttributes = normalDic;
    // 选择状态的字体，颜色
    NSDictionary *selectDic = @{NSForegroundColorAttributeName : YXBColorBlack,
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:17]};
    self.segmentedControl4.selectedTitleTextAttributes = selectDic;
    // 下划线的位置
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.selectionIndicatorHeight = 2;
    self.segmentedControl4.selectionIndicatorColor = YXBColorRed_Medium;
    self.segmentedControl4.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, -1, 0);
    
    // 内缩
    //    self.segmentedControl4.segmentEdgeInset = UIEdgeInsetsMake(2, 0, 2, 0);
    
    // 分割线位置
//        self.segmentedControl4.borderType = HMSegmentedControlBorderTypeBottom;
//        self.segmentedControl4.borderColor = YXBColorBG_gray;
    
    [self.navBarView addSubview:self.segmentedControl4];
    [self.segmentedControl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.right.mas_equalTo(-50);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self creatSegementChangeBlock];
    

    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarAndNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49 - kSafeAreaBottomMargin);
    }];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.height.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth * 3);
    }];
}

#pragma mark -------------- 点击标签 ---------------------
- (void)creatSegementChangeBlock {
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * index, 0, kScreenWidth, 200) animated:YES];
    }];
}

#pragma mark ------------- 发生滑动 ----------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}

#pragma mark ------------ 商品信息 -------------------
- (void)creatDetaiView {
    SPPDetailView *detaiView = [[SPPDetailView alloc] init];
    [self.contentView addSubview:detaiView];
    // 为了能让view取到所在viewcontoller，必须在addsuview后再创建各种布局
    [detaiView creatAll];
    [detaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark ------------ 评价 -------------------
- (void)creatCommentView {
    SPPCommonView *commonView = [[SPPCommonView alloc] init];
    [self.contentView addSubview:commonView];
    // 为了能让view取到所在viewcontoller，必须在addsuview后再创建各种布局
    [commonView creatAll];
    [commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(kScreenWidth);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark ------------ 图文详情 -------------------
- (void)creatWebView {
    SPPDWebView *webView = [[SPPDWebView alloc] init];
    [self.contentView addSubview:webView];
    // 为了能让view取到所在viewcontoller，必须在addsuview后再创建各种布局
    [webView creatAll];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(kScreenWidth * 2);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark -------------- 底部按钮 --------------------
- (void)creatBottomView {
    self.bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kSafeAreaBottomMargin);
        make.height.mas_equalTo(49);
    }];
    
    QMUIButton *storeButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    storeButton.imagePosition = QMUIButtonImagePositionTop;
    storeButton.spacingBetweenImageAndTitle = 5;
    storeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [storeButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [storeButton setTitle:@"店铺" forState:(UIControlStateNormal)];
    [storeButton setImage:[UIImage imageNamed:@"sy_spxq_dianpu"] forState:(UIControlStateNormal)];
    [self.bottomView addSubview:storeButton];
    [storeButton addTarget:self action:@selector(storeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.collectButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectButton.imagePosition = QMUIButtonImagePositionTop;
    self.collectButton.spacingBetweenImageAndTitle = 5;
    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.collectButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [self.collectButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    [self.collectButton setImage:[UIImage imageNamed:@"sy_spxq_icon_sc"] forState:(UIControlStateNormal)];
    [self.collectButton setImage:[UIImage imageNamed:@"sy_spxq_icon_sc2"] forState:(UIControlStateSelected)];
    [self.bottomView addSubview:self.collectButton];
    [self.collectButton addTarget:self action:@selector(collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    QMUIButton *cartButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    cartButton.backgroundColor = YXBColorBlack;
    cartButton.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMinXMaxYCorner;
    cartButton.layer.cornerRadius = 20;
    cartButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cartButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [cartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    [self.bottomView addSubview:cartButton];
    [cartButton addTarget:self action:@selector(cartAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    QMUIButton *buyButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    buyButton.backgroundColor = YXBColorRed_Medium;
    buyButton.layer.qmui_maskedCorners = QMUILayerMaxXMinYCorner | QMUILayerMaxXMaxYCorner;
    buyButton.layer.cornerRadius = 20;
    buyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [buyButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [buyButton setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [self.bottomView addSubview:buyButton];
    [cartButton addTarget:self action:@selector(buyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(buyButton.mas_left);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(cartButton.mas_left).mas_offset(-10);
        make.left.mas_equalTo(storeButton.mas_right);
    }];
    
    [storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.collectButton);
    }];
}

#pragma mark ------------ 店铺 -------------
- (void)storeAction:(UIButton *)button {
    ShowToast(@"店铺");
}

#pragma mark ------------ 收藏 -------------
- (void)collectAction:(UIButton *)button {
    ShowToast(@"收藏");
}

#pragma mark ------------ 加入购物车 -------------
- (void)cartAction:(UIButton *)button {
    ShowToast(@"加入购物车");
}

#pragma mark ------------ 立即购买 -------------
- (void)buyAction:(UIButton *)button {
    ShowToast(@"立即购买");
}

#pragma mark -------------- 接收通知（商品，评价，推荐，详情 之间的跳转） ----------------------
- (void)creatNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpNotification:) name:SPProductDetailJumpNotification object:nil];
}

- (void)jumpNotification:(NSNotification *)noti {
    if (noti.object) {
        self.segmentedControl4.selectedSegmentIndex = [noti.object integerValue];
        self.segmentedControl4.indexChangeBlock([noti.object integerValue]);
    }
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPProductDetailJumpNotification object:nil];
}

- (void)dealloc {
    [self removeNotification];
}

@end
