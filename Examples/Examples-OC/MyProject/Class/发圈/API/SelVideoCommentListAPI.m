//
//  SelVideoCommentListAPI.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SelVideoCommentListAPI.h"

@interface SelVideoCommentListAPI ()

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *limit;

@end

@implementation SelVideoCommentListAPI

- (instancetype)initWithVideoID:(NSString *)videoID page:(NSString *)page limit:(NSString *)limit {
    self = [super init];
    if (self) {
        self.videoId = videoID;
        self.page = page;
        self.limit = limit;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"new_yxz/videoComment/selVideoCommentList";
}

- (id)requestArgument {
    return @{@"videoId":self.videoId,
             @"page":self.page,
             @"limit":self.limit
    };
}

- (NSArray<CMCommentModel *> *)jsonForModel {
    if ([self isValidRequestData]) {
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CMCommentModel class] json:[self.responseJSONObject valueForKey:@"data"]];
        return modelArray;
    } else {
        return @[];
    }
}

@end
