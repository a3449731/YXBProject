//
//  SPHomeTeamTwoSection.m
//  MyProject
//
//  Created by 杨 on 3/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeTeamTwoSection.h"

@implementation SPHomeTeamTwoSection

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
    return CGSizeMake(kItemWidthCount(3), 150);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [UICollectionViewCell class];
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    cell.backgroundColor = YXBColorRed;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    NSString *string = [NSString stringWithFormat:@"点击团队第%ld个",index];
    ShowToast(string);
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
