//
//  MMemberSection.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MShareSection.h"
#import "MGiftCell.h"

@interface MShareSection ()

//@property (nonatomic, strong) NSArray<ProductModel *> *modelArray;

@end

@implementation MShareSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumInteritemSpacing = 10;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 10;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(2), 250);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass;
    cellClass = [MGiftCell class];
//    MGiftCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    MGiftCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:@"MShareSection" forSectionController:self atIndex:index];;
    [cell shareStyleLayout];
//    [self cell:cell forModel:self.modelArray[index]];
    return cell;
}

- (void)didUpdateToObject:(id)object {
//    self.modelArray = object;
}
//
//- (void)cell:(MGiftCell *)cell forModel:(ProductModel *)model {
//    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
//    cell.originPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.originalPrice];
//    cell.nameLabel.text = model.goodsName;
//    NSString *savePrice = [NSString stringWithFormat:@"￥%.2f",[model.originalPrice floatValue] - [model.price floatValue]];
//    [cell.saveMoneyButton setTitle:savePrice forState:(UIControlStateNormal)];
//    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:nil];
//}

- (void)didSelectItemAtIndex:(NSInteger)index {

}

@end
