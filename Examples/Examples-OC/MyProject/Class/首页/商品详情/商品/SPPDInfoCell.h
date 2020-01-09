//
//  SPPDInfoCell.h
//  MyProject
//
//  Created by 杨 on 7/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPPDInfoCell : YXBCell

// 普通的商品详情
- (void)cellForProduct:(id)model;

// 秒杀商品详情
- (void)cellForSeckill:(id)model;

// 团购商品详情
- (void)cellForTeamBuy:(id)model;

@end

NS_ASSUME_NONNULL_END
