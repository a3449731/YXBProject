//
//  ProductModel.h
//  OCDemoProject
//
//  Created by YangXiaoBin on 2019/12/3.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : YXBBaseModel

@property (nonatomic, copy) NSString *goodsImg; // 商品图
@property (nonatomic, copy) NSString *currentTime; //当前时间
@property (nonatomic, copy) NSString *startSeckillTime; // 秒杀开始时间 9点
@property (nonatomic, copy) NSString *endSeckillTime; // 秒杀结束时间 10点
@property (nonatomic, copy) NSString *price; // 商品现价
@property (nonatomic, copy) NSString *originalPrice; // 商品原价
@property (nonatomic, copy) NSString *seckillPrice; // 秒杀价
@property (nonatomic, copy) NSString *id; // 商品id
@property (nonatomic, copy) NSString *stock; // 秒杀库存
@property (nonatomic, copy) NSString *goodsName; // 商品名称
@property (nonatomic, copy) NSString *seckillStock; // 商品总库存
@property (nonatomic, copy) NSString *discount; // 会员折扣 (为0时不打折)

//1    9.9尖货
//2    秒杀区
//3    新人区
//4    推荐区
//5    品牌区
//6    礼包区
//7    会员折扣区
@property (nonatomic, copy) NSString *partitionId; // 产品所属分区的id

@end

NS_ASSUME_NONNULL_END
