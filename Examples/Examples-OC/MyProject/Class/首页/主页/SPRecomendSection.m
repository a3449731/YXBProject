//
//  SPRecomendSection.m
//  MyProject
//
//  Created by 杨 on 4/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPRecomendSection.h"
#import "YXBHeaderView.h"
#import "SPHomeProductCell.h"
#import <YYText/YYText.h>
#import "SPProductDetailViewController.h"

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
    return 5;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(2), scaleBase375(kItemWidthCount(2)) + 115);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [SPHomeProductCell class];
    
    SPHomeProductCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass withReuseIdentifier:NSStringFromClass([self class]) forSectionController:self atIndex:index];
    cell.backgroundColor = YXBColorBG_white;
    cell.layer.cornerRadius = 5;
    [cell layoutWithHomeRecomend];
    [self cell:cell forModel:@""];
    return cell;
}

- (void)cell:(SPHomeProductCell *)cell forModel:(id)model {
    cell.productImageView.image = [UIImage imageNamed:@"sy_hot_goods2"];
    cell.nameLabel.text = @"2019秋冬新款纯羊绒衫女 半高领加厚毛衣宽松纯...";
    cell.priceLabel.text = @"￥59.9";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"￥19.9"];
    [att addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, att.string.length)];
//    [att setYy_strikethroughStyle:(NSUnderlineStyleSingle)];
    cell.otherPriceLabel.attributedText = att;
    [cell.tipButton setImage:[UIImage imageNamed:@"sy_hot_Label"] forState:(UIControlStateNormal)];
    cell.saleLabel.text = @"已售100件";
    cell.adressLabel.text = @"广州";
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    NSString *string = [NSString stringWithFormat:@"点击推荐第%ld个",index];
    ShowToast(string);
    
    SPProductDetailViewController *vc = [SPProductDetailViewController new];
    PUSH(vc);
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [YXBHeaderView class];
    YXBHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    header.backgroundColor = [UIColor clearColor];
    header.imageView.hidden = NO;
    header.leftButton.hidden = YES;
    header.rightButton.hidden = YES;
    
    [header.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    header.imageView.contentMode = UIViewContentModeCenter;
    header.imageView.clipsToBounds = YES;
    header.imageView.image = [UIImage imageNamed:@"sy_hot_title"];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 65);
}

@end
