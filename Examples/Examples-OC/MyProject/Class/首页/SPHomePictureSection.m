//
//  HomePictureSection.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPHomePictureSection.h"
#import "YXBImageCell.h"
#import <QMUIKit/QMUIAlertController.h>

static NSInteger targetCount = 10;

@interface SPHomePictureSection ()

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation SPHomePictureSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 10, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = -0.8;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return targetCount;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        return CGSizeMake(kItemWidthCount(1), 130);
    } else if (index == targetCount - 1) {
        return CGSizeMake(kItemWidthCount(1), 115);
    } else {
        return CGSizeMake(kItemWidthCount(2), 115);
    }
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [YXBImageCell class];
    YXBImageCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    cell.imageView.clipsToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (index == 0) {
        cell.backgroundColor = [UIColor clearColor];
        [cell.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    } else if (index == targetCount - 1) {
        cell.backgroundColor = YXBColorRed_Bold;
        [cell.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(-18);
            make.top.mas_equalTo(15);
        }];
    } else {
        cell.backgroundColor = YXBColorRed_Bold;
        cell.layer.shadowOpacity = 1;
        cell.layer.shadowColor = YXBColorRed_Bold.CGColor;
        cell.layer.shadowOffset = CGSizeMake(30, 0);
        [cell.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-0);
            make.top.mas_equalTo(10);
        }];
    }

    cell.imageView.image = [UIImage imageNamed:self.modelArray[index]];
    return cell;
}

- (void)didUpdateToObject:(id)object {
   self.modelArray = @[@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1",@"bg1"];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    NSString *string = [NSString stringWithFormat:@"点击第%ld个活动",index];
    ShowToast(string);
}

@end
