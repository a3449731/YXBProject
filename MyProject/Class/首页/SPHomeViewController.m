//
//  SPHomeViewController.m
//  MyProject
//
//  Created by ShengChang on 2019/11/9.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPHomeViewController.h"
#import <IGListKit/IGListKit.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>

@interface SPHomeViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatCollectionView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    
    NSLog(@"\n kSafeAreaTopMargin =%f,\n kSafeAreaBottomMargin = %f,\n kNavigationBarHeight = %f ,\n kStatusBarHeight = %f ,\n kTabbarHeight = %f,\n kStatusBarAndNavigationBarHeight = %f",kSafeAreaTopMargin,kSafeAreaBottomMargin,kNavigationBarHeight,kStatusBarHeight,kTabbarHeight,kStatusBarAndNavigationBarHeight);
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
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
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
