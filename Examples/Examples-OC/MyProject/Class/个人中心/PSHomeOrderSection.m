//
//  PSHomeOrderSection.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "PSHomeOrderSection.h"
#import "PSHOrderHeaderView.h"
#import "YXBButtonCell.h"
#import "YXBImageCell.h"
#import <CALayer+QMUI.h>

@interface PSHomeOrderSection () <IGListSupplementaryViewSource>

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation PSHomeOrderSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 12, 10, 12);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.modelArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    if (index < 5) {
        return CGSizeMake(kItemWidthCount(5), 70);
    } else {
        return CGSizeMake(kItemWidthCount(1), scaleBase375(107));
    }
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (index < 5) {
        id cellClass = [YXBButtonCell class];
        YXBButtonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
        cell.button.userInteractionEnabled = NO;
        cell.button.titleLabel.font = [UIFont systemFontOfSize:11];
        [cell.button setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
        cell.button.imagePosition = QMUIButtonImagePositionTop;
        cell.button.spacingBetweenImageAndTitle = 10;
        [self cell:cell ForModel:self.modelArray[index]];
        return cell;
    } else {
        id cellClass = [YXBImageCell class];
        YXBImageCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
        cell.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner | QMUILayerMaxXMaxYCorner;
        cell.layer.cornerRadius = 5;
        NSDictionary *dic = self.modelArray[index];
        cell.imageView.image = [UIImage imageNamed:dic[@"picuture"]];
        return cell;
    }
    
}

- (void)cell:(YXBButtonCell *)cell ForModel:(NSDictionary *)model {
    [cell.button setImage:[UIImage imageNamed:model[@"picuture"]] forState:(UIControlStateNormal)];
    [cell.button setTitle:model[@"name"] forState:(UIControlStateNormal)];
    [cell.button sizeToFit];
}

- (void)didUpdateToObject:(id)object {
    self.modelArray = [self creatData];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    ShowToast(@"点按钮");
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = YXBColorBG_white;
    PUSH(vc);
}

- (NSArray *)creatData {
    return @[
        @{@"name":@"待付款",
          @"picuture":@"grzx_icon"},
        
        @{@"name":@"待发货",
          @"picuture":@"grzx_icon2"},
        
        @{@"name":@"待发货",
          @"picuture":@"grzx_icon3"},
        
        @{@"name":@"待评价",
          @"picuture":@"grzx_icon4"},
        
        @{@"name":@"退款/售后",
          @"picuture":@"grzx_icon5"},
        
        @{@"name":@"",
        @"picuture":@"grzx_yqhy"},
        
        ];
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [PSHOrderHeaderView class];
    PSHOrderHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self nibName:NSStringFromClass(headerClass) bundle:[NSBundle mainBundle] atIndex:index];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 260);
}

@end
