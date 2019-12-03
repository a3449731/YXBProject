//
//  CMVideoModel.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMVideoModel.h"

@implementation CMVideoModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"cutType" : @"cut_type"};
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"commentList" : [CMCommentModel class],
             @"goodsList" : [ProductModel class]
    };
}


@end
