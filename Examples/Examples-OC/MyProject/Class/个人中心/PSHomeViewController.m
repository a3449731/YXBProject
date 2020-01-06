//
//  PSHomeViewController.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "PSHomeViewController.h"
#import <IGListKit/IGListKit.h>
#import "PSHomeOrderSection.h"
#import "PSHomeServeSection.h"
#import "PSHomeThirdSection.h"
#import "SPRecomendSection.h"

@interface PSHomeViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PSHomeViewController

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

- (void)setupUI {
    [self creatCollectionView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
//    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO scrollDirection:(UICollectionViewScrollDirectionVertical) topContentInset:0 stretchToEdge:NO];
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
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1",@"2",@"3",@"7"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isEqual:@"1"]) {
        return [PSHomeOrderSection new];
    }
    if ([object isEqual:@"2"]) {
        return [PSHomeServeSection new];
    }
    if ([object isEqual:@"3"]) {
        return [PSHomeThirdSection new];
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
