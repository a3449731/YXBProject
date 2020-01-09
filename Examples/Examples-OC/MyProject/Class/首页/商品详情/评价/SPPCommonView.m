//
//  SPPCommonView.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPCommonView.h"
#import <IGListKit/IGListKit.h>
#import <UIView+QMUI.h>
#import "SPCommonSectionController.h"

@interface SPPCommonView ()<IGListAdapterDataSource>

@property (nonatomic, strong) IGListCollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation SPPCommonView

- (void)creatAll {
    [self setUpUI];
    [self setUpTools];
    [self setUpData];
}

- (void)setUpUI {
    [self creatTopUI];
    [self creatCollectionView];
}

- (void)setUpTools {
    [self creatAdapter];
}

- (void)setUpData {
    
}

- (void)creatTopUI {
    UIView *topView = [[UIView alloc] init];
    topView.qmui_borderLocation = QMUIViewBorderLocationInside;
    topView.qmui_borderPosition = QMUIViewBorderPositionBottom;
    topView.qmui_borderWidth = 1;
    topView.qmui_borderColor = UIColorFromHex(#F4F4F4);
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = UIColorFromHex(#333333);
    label.text = [NSString stringWithFormat:@"买家评论(%@)",@"10"];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-12);
    }];
}

#pragma mark --------------- collectionView , IGList -------------------
- (void)creatCollectionView {
    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO scrollDirection:(UICollectionViewScrollDirectionVertical) topContentInset:0 stretchToEdge:YES];
    self.collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero listCollectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self.qmui_viewController];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"3312",@"3",@"4",@"5"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPCommonSectionController new];
}

// 空布局
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
