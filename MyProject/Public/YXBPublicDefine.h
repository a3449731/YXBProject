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
#import "NSObject+YXBAdd.h"
#import "YXBConstDefine.h"

#define ShowToast(msg) [[UIApplication sharedApplication].keyWindow makeToast:msg duration:1.5 position:CSToastPositionCenter];


/// 修补字符串 小数位
/// @param original 原字符串
/// @param scale 几位小数
/// @param AddString 小数位补什么. 一般补0
NS_INLINE NSString *stringRepairScaleWithString(NSString *original, NSInteger scale, NSString *AddString) {
    if ((original == nil || [original yxb_isNull])  || (AddString == nil || [AddString yxb_isNull])) {
        return @"";
    }
    
    if ([original containsString:@"."]) {
        NSString *before = [original componentsSeparatedByString:@"."].firstObject;
        NSString *behind = [original componentsSeparatedByString:@"."].lastObject;
        if (behind.length < scale) {
            NSString *ret = [[NSString alloc] init];
            ret = behind;
            for(int y =0; y < (scale - behind.length); y++ ){
                ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
            }
            return [@[before,ret] componentsJoinedByString:@"."];
        } else {
            NSString *ret = [[NSString alloc] init];
            ret = [behind substringToIndex:scale];
            if (ret.length == 0) {
                return before;
            } else {
                return [@[before,ret] componentsJoinedByString:@"."];
            }
        }
    } else {
        NSString *ret = [[NSString alloc] init];
        for(int y =0; y < scale; y++ ){
            ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
        }
        if (ret.length == 0) {
            return original;
        } else {
            return [@[original,ret] componentsJoinedByString:@"."];
        }
    }
}

/// 字符串精度, (去尾)
/// @param original 原字符串
/// @param scale 精度几位小数
NS_INLINE NSString *stringAccuracyRoundDown(NSString *original, NSInteger scale) {
    if (original == nil || [original yxb_isNull]) {
        original = @"0";
    }
    if (original.length == 0) {
        original = @"0";
    }
    NSString *revisetring = [NSString stringWithFormat:@"%@", original];
    NSDecimalNumber *input = [NSDecimalNumber decimalNumberWithString:revisetring];
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *outPut = [input decimalNumberByRoundingAccordingToBehavior:handel];
    return stringRepairScaleWithString([outPut stringValue], scale, @"0");
//    return [outPut stringValue];
}

/**
修正数据精度丢失
@param original 传入接口取到的数据
@return 修正精度后的数据
**/
NS_INLINE NSString *getReviseNumberData(NSString *original) {
//    double originalValue = [original doubleValue];
    if (original == nil || [original yxb_isNull]) {
        return @"";
    }
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
//    NSString *string = stringAccuracyRoundDown([outPut stringValue], YXBAccuracyFour);
    return [outPut stringValue];
}

#pragma mark --------- 由于floatVlaue精度失准，影响加减乘除的结果 ----------------

/// 加法
NS_INLINE NSString *stringAddString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByAdding:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 减法
NS_INLINE NSString *stringSubtractString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberBySubtracting:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 乘法
NS_INLINE NSString *stringMultiplyString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByMultiplyingBy:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 除法
NS_INLINE NSString *stringDivideString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        return @"0";
    }
    if ([secondString isEqualToString:@"0"]) {
        return @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByDividingBy:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}


/// 标签文本转为富文本
/// @param text 标签文本
NS_INLINE NSAttributedString *attributedStringWithHTMLString(NSString *text) {
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    if (attrStr == nil) {
        attrStr = [[NSAttributedString alloc] initWithString:@"                                                                                                                                 "];
    }
    if (attrStr.length < 30) {
        NSString *newString = [attrStr.string stringByAppendingString:@"                                                                                                                                 "];
        attrStr = [[NSAttributedString alloc] initWithString:newString];
    }
    return attrStr;
}


/// 为标签文本注入js，为了适配屏幕
/// @param text 带标签的文本
NS_INLINE NSString *HTMLStringWithXMLString(NSString *text) {
    if (text == nil || [text yxb_isNull]) {
        return @"";
    }
    
    NSString *htmlstring =[NSString stringWithFormat:@"<html> \n"
    "<head> \n"
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no\">"
    "<style type=\"text/css\"> \n"
    // "body {font-size:15px;}\n"
    "ul, li, p, h1, h2, h3, dl, dt, dd {"
    "margin: 0;"
    "padding: 0;"
    "  }"
    
    "  ul, li, dl, dt, dd {"
    " list-style: none;"
    "  }"
    "</style> \n"
    "</head> \n"
    "<body>"
    "<script type='text/javascript'>"
    "window.onload = function(){\n"
    "var $img = document.getElementsByTagName('img');\n"
    "for(var p in  $img){\n"
    " $img[p].style.width = '100%%';\n"
    "$img[p].style.height ='auto'\n"
    "}\n"
    "}"
    "</script>%@"
    "</body>"
    "</html>",text];
    
    return htmlstring;
}


#endif /* YXBPublicDefine_h */
