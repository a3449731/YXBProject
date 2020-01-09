//
//  YXBConstDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/2.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBConstDefine : NSObject

// 精度
extern NSInteger const YXBAccuracyZero;
extern NSInteger const YXBAccuracyTwo;
extern NSInteger const YXBAccuracyFour;
extern NSInteger const YXBAccuracyEight;
extern NSString *const YXBAccuracyAddString; // 补精度使用的字符串

extern NSString *const SPProductDetailProduct;
extern NSString *const SPProductDetailEvaluate;
extern NSString *const SPProductDetailWebview;

extern NSString *const CTHomeChooseChangeNotification; // 购物车首页，选择商品发出的通知

extern NSString *const SPProductDetailJumpNotification; // 商品详情,view之间跳转的通知。

@end

NS_ASSUME_NONNULL_END
