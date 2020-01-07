//
//  CTHProductModel.h
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTHProductModel : YXBBaseModel

@property (nonatomic, copy) NSString *yxb_count;
@property (nonatomic, copy) NSString *yxb_price;
@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
