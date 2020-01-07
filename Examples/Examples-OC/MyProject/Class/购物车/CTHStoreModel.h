//
//  CTHStoreModel.h
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBBaseModel.h"
#import "CTHProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTHStoreModel : YXBBaseModel

@property (nonatomic, strong) NSMutableArray<CTHProductModel *> *productList;
@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
