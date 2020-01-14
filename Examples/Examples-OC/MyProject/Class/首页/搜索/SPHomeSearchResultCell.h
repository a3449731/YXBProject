//
//  SPHomeSearchResultCell.h
//  OCDemoProject
//
//  Created by 杨 on 14/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPHomeSearchResultCell : UITableViewCell

/// 搜索 商品 布局
- (void)layoutWithSearchProduct;

- (void)cellForModel:(id)model;

@end

NS_ASSUME_NONNULL_END
