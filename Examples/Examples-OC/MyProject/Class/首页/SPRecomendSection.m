//
//  SPRecomendSection.m
//  MyProject
//
//  Created by 杨 on 4/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPRecomendSection.h"
#import "YXBHeaderView.h"

@interface SPRecomendSection () <IGListSupplementaryViewSource>

@end

@implementation SPRecomendSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(10, 12, 10, 12);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 20;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(2), scaleBase375(170) + 110);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [UICollectionViewCell class];
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    cell.backgroundColor = YXBColorBG_white;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    NSString *string = [NSString stringWithFormat:@"点击推荐第%ld个",index];
    ShowToast(string);
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [YXBHeaderView class];
    YXBHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    header.imageView.hidden = NO;
    header.leftButton.hidden = YES;
    header.rightButton.hidden = YES;
    
    [header.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    header.imageView.contentMode = UIViewContentModeCenter;
    header.imageView.clipsToBounds = YES;
    header.imageView.image = [UIImage imageNamed:@"bg1"];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 65);
}

@end
