//
//  SPPDStoreSection.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDStoreSection.h"
#import <UIView+QMUI.h>
#import "YXBHeaderView.h"
#import "YXBCollectionCell.h"
#import "SPPDStoreTwoSection.h"

@interface SPPDStoreSection () <IGListSupplementaryViewSource,YXBHeaderDelegate,IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation SPPDStoreSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 10, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, scaleBase375(110 ) + 85);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [YXBCollectionCell class];
    YXBCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [cell.collectionView setCollectionViewLayout:layout];
    self.adapter.collectionView = cell.collectionView;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
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
    header.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [header.rightButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.rightButton setTitle:@"进店逛逛 >>" forState:(UIControlStateNormal)];
    [header.rightButton setImage:nil forState:(UIControlStateNormal)];
    
    [header.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    header.leftButton.imagePosition = QMUIButtonImagePositionLeft;
    header.leftButton.spacingBetweenImageAndTitle = 10;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [header.leftButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.leftButton setTitle:@"物格美妆专营店" forState:(UIControlStateNormal)];
    [header.leftButton setImage:nil forState:(UIControlStateNormal)];
//    [header.leftButton setBackgroundImage:[UIImage imageNamed:@"sy_groupbuying_title"] forState:(UIControlStateNormal)];
    
    [header.leftButton sizeToFit];
    [header.rightButton sizeToFit];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 60);
}

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    ShowToast(@"进店逛逛");
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
    return @[@"10084446"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPPDStoreTwoSection new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
