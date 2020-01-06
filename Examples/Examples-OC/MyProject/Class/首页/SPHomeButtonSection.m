//
//  SPHomeButtonSection.m
//  MyProject
//
//  Created by 杨 on 3/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeButtonSection.h"
#import "YXBCollectionCell.h"
#import "SPHomeButtonTwoSection.h"

@interface SPHomeButtonSection () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation SPHomeButtonSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 185);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [YXBCollectionCell class];
    YXBCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO scrollDirection:(UICollectionViewScrollDirectionHorizontal) topContentInset:0 stretchToEdge:NO];
    cell.collectionView.pagingEnabled = YES;
    [cell.collectionView setCollectionViewLayout:layout];
    self.adapter.collectionView = cell.collectionView;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
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
    return @[@"12378"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPHomeButtonTwoSection new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
