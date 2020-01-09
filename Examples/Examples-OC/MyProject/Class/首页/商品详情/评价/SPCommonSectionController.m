//
//  SPCommonSectionController.m
//  BusProject
//
//  Created by 杨 on 2018/6/6.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "SPCommonSectionController.h"
#import "SPCommonCell.h"
#import "SPCommonPictureSectionController.h"

@interface SPCommonSectionController() <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation SPCommonSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 1, 0);
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
//    // 计算图片高度... + 内容高度...
//    CGFloat collectionHeight = kItemWidthCount(kEveryLineCountThree);
//    CGSize commonSize = [self.model.context textSizeFor:[UIFont systemFontOfSize:12] maxWidth:self.collectionContext.containerSize.width - self.inset.left - self.inset.right - 16 - 16];
//    CGFloat totalHeight = 12 + 25 + 10 + 20 + 10 + collectionHeight + commonSize.height;
    return CGSizeMake(self.collectionContext.containerSize.width, 230);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass;
    cellClass = [SPCommonCell class];
    SPCommonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell shopCommonStyleLayout];
    self.adapter.collectionView = cell.collectionView;
    [self cell:cell forModel:@""];
    return cell;
}

- (void)didUpdateToObject:(id)object {
//    self.model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)cell:(SPCommonCell *)cell forModel:(id)model {
    cell.userImageView.image = [UIImage imageNamed:@"bg1"];
    cell.userLabel.text = @"大***咻";
    cell.timeLabel.text = @"2019-07-23 10:38:57";
    cell.commonLabel.text = @"总体效果还是不错的，确实超级水润，外壳内里颜值都很高，挺适合干燥的夏天，真的是太美丽了，感觉12个色都值得拥有。爱不释手";
}


#pragma mark ---------- 图片嵌套adapter ------------------
- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self.viewController];
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1003"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [SPCommonPictureSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end

