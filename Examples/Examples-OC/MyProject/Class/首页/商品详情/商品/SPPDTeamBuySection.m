//
//  SPPDTeamBuySection.m
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDTeamBuySection.h"
#import "YXBHeaderView.h"
#import "SPPDTeamBuyCell.h"

@interface SPPDTeamBuySection () <IGListSupplementaryViewSource,YXBHeaderDelegate>

@end

@implementation SPPDTeamBuySection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 3;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 70);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [SPPDTeamBuyCell class];
    SPPDTeamBuyCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell cellForModel:@""];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [YXBHeaderView class];
    YXBHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    header.delegate = self;
    header.imageView.hidden = NO;
    header.leftButton.hidden = NO;
    header.rightButton.hidden = NO;
    
    header.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [header.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
    }];
    header.rightButton.imagePosition = QMUIButtonImagePositionRight;
    header.rightButton.spacingBetweenImageAndTitle = 10;
    header.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    header.rightButton.adjustsImageTintColorAutomatically = YES;
    header.rightButton.tintColor = YXBColorWhite;
    [header.rightButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [header.rightButton setTitle:@"查看全部" forState:(UIControlStateNormal)];
    [header.rightButton setImage:[UIImage imageNamed:@"grzx_jiantou"] forState:(UIControlStateNormal)];
    
    [header.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    header.leftButton.imagePosition = QMUIButtonImagePositionLeft;
    header.leftButton.spacingBetweenImageAndTitle = 10;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [header.leftButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [header.leftButton setTitle:@"3人在拼单，可直接参与" forState:(UIControlStateNormal)];
    [header.leftButton setImage:[UIImage imageNamed:@"tuangou_icon2"] forState:(UIControlStateNormal)];
//    [header.leftButton setBackgroundImage:[UIImage imageNamed:@"sy_seckill_title"] forState:(UIControlStateNormal)];
    
    [header.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [header.bgView sendSubviewToBack:header.imageView];
    header.imageView.image = [UIImage imageNamed:@"sy_pt_spxq_bg"];
    
    [header.leftButton sizeToFit];
    [header.rightButton sizeToFit];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50);
}

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    ShowToast(@"查看全部拼团");
}

@end
