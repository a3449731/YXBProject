//
//  CMCommentModel.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 发圈评论
@interface CMCommentModel : YXBBaseModel

@property (nonatomic, copy) NSString *userHead; // 头像
@property (nonatomic, copy) NSString *commentId; // 评论id
@property (nonatomic, copy) NSString *create_time; // 评论时间
@property (nonatomic, copy) NSString *context; // 评论内容
@property (nonatomic, copy) NSString *userName; // 用户名称

@end

NS_ASSUME_NONNULL_END
