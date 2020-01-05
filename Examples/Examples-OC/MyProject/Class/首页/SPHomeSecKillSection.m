//
//  SPHomeTeamSection.m
//  MyProject
//
//  Created by 杨 on 3/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeSecKillSection.h"
#import <UIColor+QMUI.h>
#import "YXBHeaderView.h"
#import "SPHomeSeckillCollectionCell.h"
#import "SPHomeSeckillTimeCell.h"
#import "SPHomeProductCell.h"

@interface SPHomeSecKillSection () <IGListSupplementaryViewSource,YXBHeaderDelegate,IGListAdapterDataSource,IGListSingleSectionControllerDelegate>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

static NSInteger SeckillProductCellHeght = 128;

@implementation SPHomeSecKillSection

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
    return 2;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        return CGSizeMake(kItemWidthCount(1), 45);
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            return CGSizeMake(kItemWidthCount(1), SeckillProductCellHeght * 3);
        }
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            return CGSizeMake(kItemWidthCount(1), SeckillProductCellHeght * 4);
        }
        if (self.segmentedControl.selectedSegmentIndex == 2) {
            return CGSizeMake(kItemWidthCount(1), SeckillProductCellHeght * 2);
        }
        return CGSizeMake(kItemWidthCount(1), 0);
    }
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        id cellClass = [SPHomeSeckillTimeCell class];
        SPHomeSeckillTimeCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
        self.segmentedControl = cell.segmentControl;
        
        [cell.segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:(UIControlEventValueChanged)];
        return cell;
    } else {
        id cellClass = [SPHomeSeckillCollectionCell class];
        SPHomeSeckillCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
        cell.collectionView.bounces = NO;
        InvalidateScrollViewAdjustBehavior(self.viewController, cell.collectionView);
        self.adapter.collectionView = cell.collectionView;
        [self.adapter reloadDataWithCompletion:nil];
        return cell;
    }
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
    header.imageView.hidden = YES;
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
//    [header.leftButton setTitle:@"限时秒杀" forState:(UIControlStateNormal)];
//    [header.leftButton setImage:[UIImage imageNamed:@"account_highlight"] forState:(UIControlStateNormal)];
    [header.leftButton setBackgroundImage:[UIImage imageNamed:@"sy_seckill_title"] forState:(UIControlStateNormal)];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50);
}

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    ShowToast(@"查看更多");
}

#pragma mark ----------- 时间 -----------------------
// 标签的点击方法。
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [self.collectionContext performBatchAnimated:YES updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [batchContext reloadInSectionController:self atIndexes:set];
    } completion:^(BOOL finished) {
        
    }];
    
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
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return @[@"123",@"1234",@"12345"];
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        return @[@"333",@"444",@"555",@"666"];
    }
    if (self.segmentedControl.selectedSegmentIndex == 2) {
        return @[@"777",@"888"];
    }
    return nil;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    id cellClass = [SPHomeProductCell class];
    IGListSingleSectionController *sc = [[IGListSingleSectionController alloc] initWithCellClass:cellClass configureBlock:^(id  _Nonnull item, __kindof SPHomeProductCell * _Nonnull cell) {
        [cell layoutWithHomeSecikill];
        [self cell:cell forModel:item];
        
    } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
        return CGSizeMake(collectionContext.containerSize.width, SeckillProductCellHeght);
    }];
    sc.inset = UIEdgeInsetsMake(0, 0, 0, 0);
    sc.selectionDelegate = self;
    return sc;
}

- (void)cell:(SPHomeProductCell *)cell forModel:(id)model {
    cell.productImageView.image = [UIImage imageNamed:@"sy_hot_goods"];
    cell.nameLabel.text = @"TOM FORD汤姆福特细黑管柔雾 缎采唇膏 tf口红13 丝绒";
    cell.priceLabel.text = @"￥289";
    [cell.tipButton setImage:[UIImage imageNamed:@"sy_seckill_label"] forState:(UIControlStateNormal)];
    cell.percentLabel.text = @"已抢69%";
    cell.percentProgress.progress = 0.69;
    cell.randomImageView.image = [UIImage imageNamed:@"sy_seckill_lable_middle"];
    cell.savePriceLabel.text = @"省38元";
    cell.robLabel.text = @"抢";
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController
                        withObject:(id)object {
    NSString *string = [NSString stringWithFormat:@"点击秒杀商品%@",object];
    ShowToast(string);
}

@end
