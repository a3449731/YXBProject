//
//  SPHomeTeamSection.m
//  MyProject
//
//  Created by 杨 on 3/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeTeamSection.h"
#import "YXBHeaderView.h"
#import "YXBCollectionCell.h"
#import "SPHomeTeamTwoSection.h"

@interface SPHomeTeamSection () <IGListSupplementaryViewSource,YXBHeaderDelegate,IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation SPHomeTeamSection

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
    header.imageView.hidden = NO;
    header.leftButton.hidden = NO;
    header.rightButton.hidden = NO;
    
    header.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [header.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
    header.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [header.rightButton setTitleColor:YXBColorRed forState:(UIControlStateNormal)];
    [header.rightButton setTitle:@"查看更多 >>" forState:(UIControlStateNormal)];
    
    [header.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(header.rightButton);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(22);
    }];
    header.leftButton.imagePosition = QMUIButtonImagePositionLeft;
    header.leftButton.spacingBetweenImageAndTitle = 10;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [header.leftButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
//    [header.leftButton setTitle:@"量贩团" forState:(UIControlStateNormal)];
//    [header.leftButton setImage:[UIImage imageNamed:@"account_highlight"] forState:(UIControlStateNormal)];
    [header.leftButton setBackgroundImage:[UIImage imageNamed:@"sy_groupbuying_title"] forState:(UIControlStateNormal)];
    
    [header.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(scaleBase375(120));
    }];
    header.imageView.image = [UIImage imageNamed:@"sy_groupbuying_banner"];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50 + scaleBase375(120));
}

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    ShowToast(@"查看更多");
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
    return @[@"10086"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPHomeTeamTwoSection new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
