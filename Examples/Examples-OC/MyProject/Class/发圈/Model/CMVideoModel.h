//
//  CMVideoModel.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "YXBBaseModel.h"
#import "ProductModel.h"
#import "CMCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMVideoModel : YXBBaseModel

@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, assign) BOOL isLike; // 是否点赞（0未点赞 1已点赞）
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type; // 类型（1图文 2视频）
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) NSArray<CMCommentModel *> *commentList;
@property (nonatomic, strong) NSArray<ProductModel *> *goodsList;

@end

NS_ASSUME_NONNULL_END
