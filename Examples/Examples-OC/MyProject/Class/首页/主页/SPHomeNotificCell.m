//
//  HomeNotificCell.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPHomeNotificCell.h"
#import <QMUIKit/QMUIKit.h>

@interface SPHomeNotificCell ()

@property (nonatomic, strong) QMUIMarqueeLabel *label;

@end

@implementation SPHomeNotificCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YXBColorBG_white;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"sy_theheadlines"];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    self.label = [[QMUIMarqueeLabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:13] textColor:UIColorFromHex(#666666)];
    self.label.textAlignment = NSTextAlignmentCenter;// 跑马灯文字一般都是居中显示，所以 Demo 里默认使用 center
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    self.label.textStartAfterFade = YES;// 文字停靠在遮罩的右边
//    self.label.shouldFadeAtEdge = NO;// 关闭渐隐遮罩
    
}

- (void)cellForModel:(id)model {
    // 在UILabel的样式（如字体）设置完后，将label的text设置为一个测试字符，再调用sizeToFit，从而令label的高度适应字体
    [self.label qmui_calculateHeightAfterSetAppearance];
    [self.label requestToStopAnimation];
    self.label.text = @"恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    [self.label requestToStartAnimation];
}

@end
