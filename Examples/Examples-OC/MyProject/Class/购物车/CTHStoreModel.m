//
//  CTHStoreModel.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHStoreModel.h"

@implementation CTHStoreModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productList" : @"xxxxxx"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"productList" : [CTHProductModel class]};
}

@end
