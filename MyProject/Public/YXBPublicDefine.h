//
//  YXBPublicDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/17.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBPublicDefine_h
#define YXBPublicDefine_h

#import <Toast/UIView+Toast.h>

#define ShowToast(msg) [[UIApplication sharedApplication].keyWindow makeToast:msg duration:1 position:CSToastPositionCenter];

/**
修正数据精度丢失
@param original 传入接口取到的数据
@return 修正精度后的数据
**/
NS_INLINE NSString *getReviseNumberData(NSString *original) {
//    double originalValue = [original doubleValue];
    NSString *revisetring = [NSString stringWithFormat:@"%@", original];
    NSDecimalNumber *input = [NSDecimalNumber decimalNumberWithString:revisetring];
    // 精度处理
    /*
    typedef NS_ENUM(NSUInteger, NSRoundingMode) {
        NSRoundPlain,   // Round up on a tie(四舍五入)
        NSRoundDown,    // Always down == truncate(只舍不入)
        NSRoundUp,      // Always up(只入不舍)
        NSRoundBankers  // on a tie round so last digit is even(也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
    它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
    NSRoundPlain结果为1.3,而NSRoundBankers则是1.2),下面是例子:
    };
    */
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *outPut = [input decimalNumberByRoundingAccordingToBehavior:handel];
    return [outPut stringValue];
}

/// 修补字符串 小数位
/// @param original 原字符串
/// @param scale 几位小数
/// @param AddString 小数位补什么. 一般补0
NS_INLINE NSString *stringRepairScaleWithString(NSString *original, NSInteger scale, NSString *AddString) {
    if ([original containsString:@"."]) {
        NSString *before = [original componentsSeparatedByString:@"."].firstObject;
        NSString *behind = [original componentsSeparatedByString:@"."].lastObject;
        NSString *ret = [[NSString alloc] init];
        ret = behind;
        for(int y =0; y < (scale - behind.length); y++ ){
            ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
        }
        return [@[before,ret] componentsJoinedByString:@"."];
    } else {
        NSString *ret = [[NSString alloc] init];
        for(int y =0; y < scale; y++ ){
            ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
        }
        return [@[original,ret] componentsJoinedByString:@"."];
    }
}

/// 字符串精度, (去尾)
/// @param original 原字符串
/// @param scale 精度几位小数
NS_INLINE NSString *stringAccuracyRoundDown(NSString *original, NSInteger scale) {
    if (original == nil) {
        original = @"0";
    }
    NSString *revisetring = [NSString stringWithFormat:@"%@", original];
    NSDecimalNumber *input = [NSDecimalNumber decimalNumberWithString:revisetring];
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *outPut = [input decimalNumberByRoundingAccordingToBehavior:handel];
    return stringRepairScaleWithString([outPut stringValue], scale, @"0");
//    return [outPut stringValue];
}

#pragma mark --------- 由于floatVlaue精度失准，影响加减乘除的结果 ----------------

/// 加法
NS_INLINE NSString *stringAddString(NSString *firstString, NSString *secondString) {
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByAdding:twoNumber];
    return [resultNumber stringValue];
}

/// 减法
NS_INLINE NSString *stringSubtractString(NSString *firstString, NSString *secondString) {
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberBySubtracting:twoNumber];
    return [resultNumber stringValue];
}

/// 乘法
NS_INLINE NSString *stringMultiplyString(NSString *firstString, NSString *secondString) {
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByMultiplyingBy:twoNumber];
    return [resultNumber stringValue];
}

/// 除法
NS_INLINE NSString *stringDivideString(NSString *firstString, NSString *secondString) {
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByDividingBy:twoNumber];
    return [resultNumber stringValue];
}

#endif /* YXBPublicDefine_h */
