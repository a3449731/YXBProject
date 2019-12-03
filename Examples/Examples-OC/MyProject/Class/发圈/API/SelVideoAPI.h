//
//  SelVideoAPI.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "CMVideoModel.h"
#import "CMImageTextModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CMSelCircleVideo,   // 视频
    CMSelCircleImageText, // 图文
} CMSelCircle;

@interface SelVideoAPI : MyRequst

/// 查询发圈内容
/// @param type  视频 还是 图文
- (instancetype)initWithType:(CMSelCircle)type page:(NSString *)page limit:(NSString *)limit;

/// 视频
- (NSArray<CMVideoModel *> *)jsonForVideoModel;

/// 图文
- (NSArray<CMImageTextModel *> *)jsonForImageTextModel;

@end

NS_ASSUME_NONNULL_END
