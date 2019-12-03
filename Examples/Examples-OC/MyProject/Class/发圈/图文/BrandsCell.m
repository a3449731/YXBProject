//
//  BrandsCell.m
//  BusProject
//
//  Created by 杨 on 2018/5/10.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "BrandsCell.h"


@interface BrandsCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BrandsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)cellForCMRecommendPictureSection:(id)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:nil];
}

@end
