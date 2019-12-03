//
//  MyRequst.h
//  YTKNetworkDemo
//
//  Created by ShengChang on 2019/10/30.
//  Copyright © 2019 yuantiku.com. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyRequst : YTKRequest

/// 数据是否有效
- (BOOL)isValidRequestData;

@end

NS_ASSUME_NONNULL_END


//- (NSArray *)jsonForModel {
//    if ([self isValidRequestData]) {
//        return [NSArray yy_modelArrayWithClass:[ProductModel class] json:[self.responseJSONObject valueForKey:@"data"]];
//    } else {
//        return @[];
//    }
//}

//- (UserMessageModel * _Nullable)jsonForModel {
//    if ([self isValidRequestData]) {
//        UserMessageModel *model = [UserMessageModel yy_modelWithJSON:[self.responseJSONObject valueForKey:@"data"]];
//        return model;
//    } else {
//        return nil;
//    }
//}
