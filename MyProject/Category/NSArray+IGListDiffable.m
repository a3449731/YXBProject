//
//  NSArray+IGListDiffable.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/24.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "NSArray+IGListDiffable.h"

@implementation NSArray (IGListDiffable)

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return [self isEqual:object];
}


@end
