//
//  SPCommonPictureCell.h
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPCommonPictureCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

/// 评论图片cell的布局
- (void)commonPictureStyleLayout;

@end

NS_ASSUME_NONNULL_END
