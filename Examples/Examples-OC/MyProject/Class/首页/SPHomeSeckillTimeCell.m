//
//  SPHomeSeckillTimeCell.m
//  MyProject
//
//  Created by 杨 on 4/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeSeckillTimeCell.h"

@interface SPHomeSeckillTimeCell ()


@end

@implementation SPHomeSeckillTimeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    [self creatSegment];
}

#pragma mark ------------ 标签 --------------
- (void)creatSegment {
    self.segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"10:00",@"12:00",@"14:00"]];
    // 未选中的字体,颜色
    NSDictionary *normalDic =  @{NSForegroundColorAttributeName : YXBColorBlack,
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    self.segmentControl.titleTextAttributes = normalDic;
    // 选择状态的字体，颜色
    NSDictionary *selectDic = @{NSForegroundColorAttributeName : YXBColorRed,
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    self.segmentControl.selectedTitleTextAttributes = selectDic;
    // 下划线的位置
//    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorColor = [UIColor clearColor];
//    self.segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -20);
    
    // 内缩
    self.segmentControl.segmentEdgeInset = UIEdgeInsetsMake(2, 0, 2, 0);
    
    // 分割线位置
    self.segmentControl.borderType = HMSegmentedControlBorderTypeBottom;
    self.segmentControl.borderColor = YXBColorBG_gray;
    
    [self.contentView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

@end
