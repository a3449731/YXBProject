//
//  NSArray+YXBAdd.m
//  YingXingBoss
//
//  Created by 杨 on 2018/4/13.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "NSArray+YXBAdd.h"
#import "UIImage+YXBAdd.h"


@implementation NSArray (YXBAdd)

+ (NSMutableArray *)getPropertyArrayWithString:(NSString *)property inTheArray:(NSArray *)array
{
    NSMutableArray *backArray = [NSMutableArray array];
    if (property)
    {
        for (NSInteger i = 0; i < array.count; i ++)
        {
            id object = array[i];
            id pro = [object valueForKey:property];
            if (pro) {
                [backArray addObject:pro];
            }
        }
    }
    return backArray;
}


- (NSMutableArray *)imageArrayCoverToBase64ImageArray
{
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64 = [image imageToBase64WithQuality:0.5];
        [backArray addObject:base64];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayWithTargetSize:(CGSize)size
{
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        UIImage *yxb_image = [image yxb_imageByResizeToSize:size];
        NSString *base64 = [yxb_image imageToBase64WithQuality:0.5];
        [backArray addObject:base64];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory
{
    CGFloat everyLimit = limitMemory / self.count;
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64String = [image coverToBase64LinmitMB:everyLimit];
        [backArray addObject:base64String];
    }
    return backArray;
}

- (NSMutableArray *)imageArrayCoverToBase64ImageArrayLimitMemoryMB:(CGFloat)limitMemory targetSize:(CGSize)size
{
    CGFloat everyLimit = limitMemory / self.count;
    NSMutableArray *backArray = [NSMutableArray array];
    for (UIImage *image in self)
    {
        NSString *base64String = [image coverToBase64LimitMemoryMB:everyLimit targetSize:size];
        [backArray addObject:base64String];
    }
    return backArray;
}

@end
