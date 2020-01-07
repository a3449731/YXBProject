//
//  CTHStoreSection.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHStoreSection.h"
#import "YXBHeaderView.h"
#import "CTHProductCell.h"
#import <UIView+QMUI.h>
#import <CALayer+QMUI.h>
#import "CTHStoreModel.h"
#import "CTHomeViewController.h"

@interface CTHStoreSection () <IGListSupplementaryViewSource,YXBHeaderDelegate,CTHProductCellDelegate>

@property (nonatomic, strong) CTHStoreModel *model;

@end

@implementation CTHStoreSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(10, 12, 0, 12);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.model.productList.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 140);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [CTHProductCell class];
    CTHProductCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    cell.backgroundColor = YXBColorBG_white;
    if (index == self.model.productList.count - 1) {
        cell.qmui_borderColor = UIColorFromHex(#F6F6F6);
        cell.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner | QMUILayerMaxXMaxYCorner;
        cell.layer.cornerRadius = 5;
    }
    [cell layoutWithCartProduct];
    cell.delegate = self;
    cell.model = self.model.productList[index];
    [self cell:cell forModel:self.model.productList[index]];
    return cell;
}

- (void)cell:(CTHProductCell *)cell forModel:(CTHProductModel *)model {
    cell.productImageView.image = [UIImage imageNamed:@"sy_groupbuying_goods"];
    cell.nameLabel.text = @"CHANEL 香奈儿可可小姐女士浓香 水EDP 50ml 白色摩登";
    cell.modeLabel.text = @"120ml*2";
    cell.priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.yxb_price];
    cell.numberButton.currentNumber = [model.yxb_count integerValue];
    [cell.chooseButton setImage:[UIImage imageNamed:@"gwc_xz"] forState:(UIControlStateSelected)];
    [cell.chooseButton setImage:[UIImage imageNamed:@"gwc_wxz"] forState:(UIControlStateNormal)];
    cell.chooseButton.selected = model.selected;
}

- (void)didUpdateToObject:(id)object {
    self.model = object;
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
    header.backgroundColor = YXBColorBG_white;
    header.qmui_borderLocation = QMUIViewBorderLocationOutside;
    header.qmui_borderPosition = QMUIViewBorderPositionBottom;
    header.qmui_borderColor = UIColorFromHex(#F6F6F6);
    header.qmui_borderWidth = 1;
    header.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    header.layer.cornerRadius = 5;
    header.leftButton.hidden = NO;
    header.rightButton.hidden = NO;
    header.imageView.hidden = YES;
    
    header.leftButton.imagePosition = QMUIButtonImagePositionLeft;
    header.leftButton.spacingBetweenImageAndTitle = 10;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [header.leftButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    header.rightButton.imagePosition = QMUIButtonImagePositionLeft;
    header.rightButton.spacingBetweenImageAndTitle = 10;
    header.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [header.rightButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    
    [header.leftButton setTitle:@"物格美妆专营店" forState:(UIControlStateNormal)];
    [header.leftButton setImage:[UIImage imageNamed:@"gwc_wxz"] forState:(UIControlStateNormal)];
    [header.leftButton setImage:[UIImage imageNamed:@"gwc_xz"] forState:(UIControlStateSelected)];
    header.leftButton.selected = self.model.selected;
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 40);
}

#pragma mark ------------ 选择店铺 ---------------
- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button {
    self.model.selected = !self.model.selected;
    for (CTHProductModel *model in self.model.productList) {
        model.selected = self.model.selected;
    }
//    [[(CTHomeViewController *)self.viewController adapter] reloadDataWithCompletion:nil];
    // 发通知到购物车首页
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHomeChooseChangeNotification object:nil];
}

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button {
    
}

#pragma mark ------------ 选择商品 ---------------
- (void)CTHProductCell:(CTHProductCell *)cell chooseProduct:(CTHProductModel *)model {
    model.selected = !model.selected;
    // 发通知到购物车首页
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHomeChooseChangeNotification object:nil];
}

#pragma mark ------------ 商品 加 减 ---------------
- (void)CTHProductCell:(CTHProductCell *)cell model:(CTHProductModel *)model numberButton:(PPNumberButton *)numberButton increaseStatus:(BOOL)increaseStatus {
    // 在这里要进行 购物车加减的接口验证，若失败要把数字还原。(建议服务器返回当前数量,避免其他原因，本地数据与服务器数据不一致)
    
    if (increaseStatus == YES) {
        ShowToast(@"加");
    } else {
        ShowToast(@"减");
    }
    model.yxb_count = [NSString stringWithFormat:@"%ld",(long)numberButton.currentNumber];
    // 发通知到购物车首页
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHomeChooseChangeNotification object:nil];
}

@end
