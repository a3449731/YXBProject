//
//  CTHProductCell.h
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBCell.h"
#import <PPNumberButton/PPNumberButton.h>
#import "CTHProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CTHProductCell;

@protocol CTHProductCellDelegate <NSObject>

- (void)CTHProductCell:(CTHProductCell *)cell chooseProduct:(CTHProductModel *)model;

- (void)CTHProductCell:(CTHProductCell *)cell model:(CTHProductModel *)model numberButton:(PPNumberButton *)numberButton increaseStatus:(BOOL)increaseStatus;

@end

@interface CTHProductCell : YXBCell

@property (nonatomic, strong) UIImageView *productImageView; // 商品图片
@property (nonatomic, strong) UILabel *nameLabel; // 商品名字
@property (nonatomic, strong) UILabel *priceLabel; // 价格
@property (nonatomic, strong) UILabel *otherPriceLabel; // 其他价（例如划线价）
@property (nonatomic, strong) UILabel *modeLabel; // 规格
@property (nonatomic, strong) PPNumberButton *numberButton; // 规格
@property (nonatomic, strong) UIButton *chooseButton; // 选择按钮

@property (nonatomic, weak) id<CTHProductCellDelegate> delegate;
@property (nonatomic, strong) CTHProductModel *model; // 有cell赋值时传入。(只是为了代理的时候再传回去，锁定模型)

/// 购物车商品 布局
- (void)layoutWithCartProduct;

@end

NS_ASSUME_NONNULL_END
