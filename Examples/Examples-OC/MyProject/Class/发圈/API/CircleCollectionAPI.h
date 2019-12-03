//
//  CircleCollectionAPI.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/20.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MyRequst.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleCollectionAPI : MyRequst


/// 圈子点赞收藏 / 取消点赞收藏
/// @param targetID 视频或图文id
/// @param type 类型（1点赞 2收藏）
/// @param classify 分类（1图文 2视频）
- (instancetype)initWithTargetID:(NSString *)targetID type:(NSString *)type classify:(NSString *)classify;

@end

NS_ASSUME_NONNULL_END
