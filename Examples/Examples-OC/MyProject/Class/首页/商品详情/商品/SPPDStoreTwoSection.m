//
//  SPPDStoreTwoSection.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDStoreTwoSection.h"
#import "SPHomeProductCell.h"
#import "SPProductDetailViewController.h"

@implementation SPPDStoreTwoSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(20, 12, 0, 12);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 10;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(3), scaleBase375(kItemWidthCount(3)) + 60);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [SPHomeProductCell class];
    SPHomeProductCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
    [cell layoutWithDetailStoreProduct];
    [self cell:cell forModel:@""];
    return cell;
}

- (void)cell:(SPHomeProductCell *)cell forModel:(id)model {
    cell.productImageView.image = [UIImage imageNamed:@"sy_groupbuying_goods"];
    cell.nameLabel.text = @"TOM FORD汤姆福特细黑管柔雾 缎采唇膏 tf口红13 丝绒";
    cell.otherPriceLabel.text = @"￥420";
    cell.priceLabel.text = @"￥289";
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    SPProductDetailViewController *vc = [SPProductDetailViewController new];
    PUSH(vc);
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [UICollectionReusableView class];
    UICollectionReusableView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 100);
}

@end
