//
//  CMReconmmendCell.m
//  BusProject
//
//  Created by 杨 on 2018/7/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "CMReconmmendCell.h"
//#import "CMTieziModel.h"
#import "CMImageTextModel.h"

@interface CMReconmmendCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;

@end

@implementation CMReconmmendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellForModel:(CMImageTextModel *)model
{
    self.namelabel.text = model.title;
    self.timeLabel.text = model.createTime;
//    self.cicleLabel.text = model.title;
    self.contentLabel.text = model.context;
//    self.specLabel.text = [NSString stringWithFormat:@"浏览%@次 顶%@ 评论%@",model.view_count,model.like_count,model.comment_count];
}


@end
