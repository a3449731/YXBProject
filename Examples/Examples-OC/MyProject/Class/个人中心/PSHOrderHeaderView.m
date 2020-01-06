//
//  PSHOrderHeaderView.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "PSHOrderHeaderView.h"
#import <CALayer+QMUI.h>

@interface PSHOrderHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UILabel *shareCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *copButton; // 复制
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; // 余额
@property (weak, nonatomic) IBOutlet UILabel *collectProductLabel; // 收藏商品
@property (weak, nonatomic) IBOutlet UILabel *collectStoreLabel; // 收藏店铺
@property (weak, nonatomic) IBOutlet QMUIButton *orderButton; // 订单
@property (weak, nonatomic) IBOutlet UIView *bottomOrderView;

@end

@implementation PSHOrderHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.orderButton.imagePosition = QMUIButtonImagePositionRight;
    self.bottomOrderView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    self.bottomOrderView.layer.cornerRadius = 5;
}

// 设置
- (IBAction)settingAction:(UIButton *)sender {
    ShowToast(@"点击设置");
}

// 复制
- (IBAction)copyAction:(UIButton *)sender {
    if (self.shareCodeLabel.text.length) {
        ShowToast(@"复制成功");
        [UIPasteboard generalPasteboard].string = self.shareCodeLabel.text;
    }
}

// 全部订单
- (IBAction)orderAction:(QMUIButton *)sender {
    ShowToast(@"点击全部订单");
}

@end
