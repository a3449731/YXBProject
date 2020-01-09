//
//  SPPDetailView.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDetailView.h"
#import <IGListKit/IGListKit.h>
#import <UIView+QMUI.h>
#import <MJRefresh/MJRefresh.h>
#import "SPPDInfoSection.h"
#import "SPPDTeamBuySection.h"
#import "SPPDSpecificationSection.h"
#import "SPPDEvaluateSection.h"
#import "SPPDStoreSection.h"
#import "SPPDIntroduceSection.h"

@interface SPPDetailView () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SPPDetailView

- (void)creatAll {
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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.qmui_viewController.automaticallyAdjustsScrollViewInsets = NO;
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
    MJWeakSelf;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:SPProductDetailJumpNotification object:SPProductDetailWebview];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    [footer setTitle:@"下拉查看图文详情" forState:(MJRefreshStateIdle)];
    [footer setTitle:@"完成下拉，松开即可" forState:(MJRefreshStatePulling)];
    [footer setTitle:@"前往图文详情" forState:(MJRefreshStateRefreshing)];
    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self.qmui_viewController];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1",@"2",@"3",@"4",@"5"];
//    return @[@"1", @"2", @"3", @"4", @"5", @"6"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isEqual:@"1"]) {
        return [SPPDInfoSection new];
    }
    if ([object isEqual:@"2"]) {
        return [SPPDTeamBuySection new];
    }
    if ([object isEqual:@"3"]) {
        return [SPPDSpecificationSection new];
    }
    if ([object isEqual:@"4"]) {
        return [SPPDEvaluateSection new];
    }
    if ([object isEqual:@"5"]) {
        return [SPPDStoreSection new];
    }
    if ([object isEqual:@"6"]) {
        return [SPPDIntroduceSection new];
    }
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
