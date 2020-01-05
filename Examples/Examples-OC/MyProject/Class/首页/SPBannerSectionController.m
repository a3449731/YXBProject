//
//  SPBannerSectionController.m
//  BusProject
//
//  Created by 杨 on 2018/5/10.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "SPBannerSectionController.h"
#import "SPBannerHeaderView.h"
#import "SPBannerCell.h"

@interface SPBannerSectionController() <IGListSupplementaryViewSource>

@property (nonatomic , strong) NSArray *modelArray;

@end


@implementation SPBannerSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
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
    return CGSizeMake(kItemWidthCount(1), scaleBase375(140) + 50);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    Class cellClass;
    cellClass = [SPBannerCell class];
    
    SPBannerCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell cellForModel:self.modelArray];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.modelArray = object;
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [SPBannerHeaderView class];
    SPBannerHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50);
}

@end
