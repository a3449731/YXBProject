//
//  HomeNotificSection.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPHomeNotificSection.h"
#import "SPHomeNotificCell.h"

@interface SPHomeNotificSection ()

@property (nonatomic, strong) id model;

@end

@implementation SPHomeNotificSection

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
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [SPHomeNotificCell class];
    SPHomeNotificCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell cellForModel:self.model];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    ShowToast(@"点滚动公告");
}

@end
