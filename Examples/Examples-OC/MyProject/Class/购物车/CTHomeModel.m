//
//  CTHomeModel.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHomeModel.h"

@implementation CTHomeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"storeList" : @"xxxxxx"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"storeList" : [CTHStoreModel class]};
}

@end
