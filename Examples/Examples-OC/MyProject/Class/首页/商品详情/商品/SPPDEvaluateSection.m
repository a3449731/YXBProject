//
//  SPPDEvaluateSection.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDEvaluateSection.h"
#import <UIColor+QMUI.h>
#import <UIView+QMUI.h>
#import "YXBHeaderView.h"
#import "YXBCollectionCell.h"
#import "SPCommonSectionController.h"
#import "YXBButtonCell.h"

@interface SPPDEvaluateSection () <IGListSupplementaryViewSource,YXBHeaderDelegate,IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation SPPDEvaluateSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 10, 0);
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
//    return 1;
    return 1 + 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        return CGSizeMake(kItemWidthCount(1), 230 + 1);
    } else {
        return CGSizeMake(kItemWidthCount(1), 42);
    }
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        id cellClass = [YXBCollectionCell class];
        YXBCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
        cell.collectionView.bounces = NO;
        InvalidateScrollViewAdjustBehavior(self.viewController, cell.collectionView);
        self.adapter.collectionView = cell.collectionView;
        [self.adapter reloadDataWithCompletion:nil];
        return cell;
    } else {
        id cellClass = [YXBButtonCell class];
        YXBButtonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
        cell.button.userInteractionEnabled = NO;
        [self cell:cell forModel:@""];
        return cell;
    }
}

- (void)cell:(YXBButtonCell *)cell forModel:(id)model {
    cell.button.imagePosition = QMUIButtonImagePositionRight;
    cell.button.spacingBetweenImageAndTitle = 10;
    cell.button.titleLabel.font = [UIFont systemFontOfSize:14];
    cell.button.tintColor = YXBColorGray_999;
    cell.button.adjustsImageTintColorAutomatically = YES;
    cell.button.adjustsTitleTintColorAutomatically = YES;
    [cell.button setTitle:@"查看全部163条评论" forState:(UIControlStateNormal)];
    [cell.button setImage:[UIImage imageNamed:@"grzx_jiantou"] forState:(UIControlStateNormal)];
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    if (index == 1) {
        // 查看全部评论
        [[NSNotificationCenter defaultCenter] postNotificationName:SPProductDetailJumpNotification object:SPProductDetailEvaluate];
    }
}

#pragma mark --------------- 分区头 -----------------------
- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [YXBHeaderView class];
    YXBHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    header.delegate = self;
    header.backgroundColor = YXBColorBG_white;
    header.qmui_borderLocation = QMUIViewBorderLocationOutside;
    header.qmui_borderPosition = QMUIViewBorderPositionBottom;
    header.qmui_borderColor = UIColorFromHex(#F4F4F4);
    header.qmui_borderWidth = 1;
    header.imageView.hidden = YES;
    header.leftButton.hidden = NO;
    header.rightButton.hidden = NO;
    
    header.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [header.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
    }];
    header.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    header.rightButton.adjustsImageTintColorAutomatically = YES;
    header.rightButton.tintColor = YXBColorBlack;
    [header.rightButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.rightButton setTitle:@"" forState:(UIControlStateNormal)];
    [header.rightButton setImage:[UIImage imageNamed:@"grzx_jiantou"] forState:(UIControlStateNormal)];
    
    [header.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    header.leftButton.imagePosition = QMUIButtonImagePositionLeft;
    header.leftButton.spacingBetweenImageAndTitle = 10;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [header.leftButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.leftButton setTitle:@"买家评论(163)" forState:(UIControlStateNormal)];
    [header.leftButton setImage:nil forState:(UIControlStateNormal)];
//    [header.leftButton setBackgroundImage:[UIImage imageNamed:@"sy_seckill_title"] forState:(UIControlStateNormal)];
    
    [header.leftButton sizeToFit];
    [header.rightButton sizeToFit];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 44);
}

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    ShowToast(@"查看评论");
}

#pragma mark ----------- 嵌套adapter ----------------
- (IGListAdapter *)adapter {
    if (_adapter == nil) {
        IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
        _adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self.viewController];
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    if (self.numberOfItems == 1) {
        return nil;
    } else {
        return @[@"啊哈哈"];
    }
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPCommonSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    QMUIButton *emptyButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    emptyButton.imagePosition = QMUIButtonImagePositionTop;
    emptyButton.spacingBetweenImageAndTitle = 10;
    emptyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [emptyButton setTitleColor:YXBColorGray_999 forState:(UIControlStateNormal)];
    [emptyButton setTitle:@"暂无相关评论" forState:(UIControlStateNormal)];
    [emptyButton setImage:[UIImage imageNamed:@"gwc_icon"] forState:(UIControlStateNormal)];

    return emptyButton;
}

@end
