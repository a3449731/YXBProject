//
//  CMReconmmendPictureSection.m
//  BusProject
//
//  Created by 杨 on 2018/7/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "CMReconmmendPictureSection.h"
#import "BrandsCell.h"

@interface CMReconmmendPictureSection()

@property (nonatomic , strong) NSArray <NSString *> *modelArray;

@end

@implementation CMReconmmendPictureSection

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.inset = UIEdgeInsetsMake(0, 15, 5, 15);
        self.minimumLineSpacing = 8;
        self.minimumInteritemSpacing = 10;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return self.modelArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(kItemWidthCount(3), kItemWidthCount(3));
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    id cellClass;
    cellClass = [BrandsCell class];
    
    BrandsCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass(cellClass) bundle:nil forSectionController:self atIndex:index];
    [cell cellForCMRecommendPictureSection:self.modelArray[index]];
    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.modelArray = object;
}
@end
