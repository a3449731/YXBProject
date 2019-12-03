//
//  CMImageTextModel.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


/// 圈子 -- 图文贴 model
@interface CMImageTextModel : YXBBaseModel

@property (nonatomic, assign) BOOL isLike; // 是否点赞（0未点赞 1已点赞）
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *context; // 内容
@property (nonatomic, assign) BOOL isCollection; // 是否收藏（0未收藏 1已收藏）
@property (nonatomic, copy) NSString *detailsImg; // 图片(多图逗号隔开)
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type; // 1图文 2视频
@property (nonatomic, copy) NSString *userId; // 用户id

@end

NS_ASSUME_NONNULL_END
