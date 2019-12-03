//
//  InsCollectionAPI.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CircleCollectionAPI.h"

@interface CircleCollectionAPI ()

@property (nonatomic, copy) NSString *targetID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *classify;

@end

@implementation CircleCollectionAPI

- (instancetype)initWithTargetID:(NSString *)targetID type:(NSString *)type classify:(NSString *)classify {
    self = [super init];
    if (self) {
        self.targetID = targetID;
        self.type = type;
        self.classify = classify;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"new_yxz/videoCollectionLikeApi/insVideoCollectionLike";
}

- (id)requestArgument {
    return @{@"videoId":self.targetID,
             @"type":self.type,
             @"classify":self.classify};
}

@end
