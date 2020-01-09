//
//  SPPDInfoSection.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDInfoSection.h"
#import "SPPDInfoCell.h"

@implementation SPPDInfoSection

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
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, scaleBase375(280) + 120);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [SPPDInfoCell class];
    SPPDInfoCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    
    NSInteger count = arc4random() % 3;
    if (count == 0) {
        [cell cellForProduct:@""];
    }
    if (count == 1) {
        [cell cellForSeckill:@""];
    }
    if (count == 2) {
        [cell cellForTeamBuy:@""];
    }
    
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
