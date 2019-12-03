//
//  InsVideoCommentAPI.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface InsVideoCommentAPI : MyRequst

/// 圈子视频 发布评论
/// @param videoID 视频或图文id
- (instancetype)initWithVideoID:(NSString *)videoID context:(NSString *)context;

@end

NS_ASSUME_NONNULL_END
