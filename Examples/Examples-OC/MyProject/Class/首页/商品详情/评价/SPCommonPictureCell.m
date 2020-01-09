//
//  SPCommonPictureCell.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPCommonPictureCell.h"

@interface SPCommonPictureCell ()


@end

@implementation SPCommonPictureCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
}

- (void)commonPictureStyleLayout {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
