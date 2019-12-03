//
//  SelVideoAPI.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/13.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SelVideoAPI.h"

@interface SelVideoAPI ()

@property (nonatomic, assign) CMSelCircle type;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *limit;

@end

@implementation SelVideoAPI

- (instancetype)initWithType:(CMSelCircle)type page:(NSString *)page limit:(NSString *)limit {
    self = [super init];
    if (self) {
        self.type = type;
        self.page = page;
        self.limit = limit;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"new_yxz/videoApi/selVideoAll";
}

- (id)requestArgument {
    NSString *type = self.type == CMSelCircleVideo ? @"2" : @"1";
    return @{@"type":type,
             @"page":self.page,
             @"limit":self.limit
    };
}

- (NSArray<CMVideoModel *> *)jsonForVideoModel {
    if (self.type == CMSelCircleVideo) {
        if ([self isValidRequestData]) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CMVideoModel class] json:[self.responseJSONObject valueForKey:@"data"]];
            return modelArray;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSArray<CMImageTextModel *> *)jsonForImageTextModel {
    if (self.type == CMSelCircleImageText) {
        if ([self isValidRequestData]) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CMImageTextModel class] json:[self.responseJSONObject valueForKey:@"data"]];
            return modelArray;
        } else {
            return @[];
        }
    } else {
        return @[];
    }
}



@end
