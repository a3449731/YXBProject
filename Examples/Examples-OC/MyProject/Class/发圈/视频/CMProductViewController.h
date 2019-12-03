//
//  CMProductViewController.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMProductViewController : UIViewController

@property (nonatomic, strong) NSArray<ProductModel *> *modelArray;

@end

NS_ASSUME_NONNULL_END
