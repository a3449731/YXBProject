//
//  SelVideoCommentListAPI.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"
#import "CMCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelVideoCommentListAPI : MyRequst


/// 查询评论列表
/// @param videoID 视频或图文id
- (instancetype)initWithVideoID:(NSString *)videoID page:(NSString *)page limit:(NSString *)limit;

- (NSArray<CMCommentModel *> *)jsonForModel;

@end

NS_ASSUME_NONNULL_END
