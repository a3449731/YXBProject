//
//  InsVideoCommentAPI.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "InsVideoCommentAPI.h"

@interface InsVideoCommentAPI ()

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *context;

@end

@implementation InsVideoCommentAPI

- (instancetype)initWithVideoID:(NSString *)videoID context:(NSString *)context {
    self = [super init];
    if (self) {
        self.videoId = videoID;
        self.context = context;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"new_yxz/videoComment/insVideoComment";
}

- (id)requestArgument {
    return @{@"videoId":self.videoId,
             @"context":self.context};
}

@end
