//
//  PSHomeServeSection.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "PSHomeServeSection.h"
#import "YXBHeaderView.h"
#import "YXBButtonCell.h"
#import <CALayer+QMUI.h>

@interface PSHomeServeSection ()<IGListSupplementaryViewSource>

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation PSHomeServeSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0.5, 12, 10, 12);
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
    return CGSizeMake(kItemWidthCount(4), 84);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [YXBButtonCell class];
    YXBButtonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    if (index == 4) {
        cell.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner;
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
    } else if (index == 7) {
        cell.layer.qmui_maskedCorners = QMUILayerMaxXMaxYCorner;
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
    } else {
        cell.layer.cornerRadius = 0;
        cell.layer.masksToBounds = NO;
    }
    
    cell.button.userInteractionEnabled = NO;
    cell.button.titleLabel.font = [UIFont systemFontOfSize:11];
    [cell.button setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    cell.button.imagePosition = QMUIButtonImagePositionTop;
    cell.button.spacingBetweenImageAndTitle = 10;
    [self cell:cell ForModel:self.modelArray[index]];
    return cell;
}

- (void)cell:(YXBButtonCell *)cell ForModel:(NSDictionary *)model {
    [cell.button setImage:[UIImage imageNamed:model[@"picuture"]] forState:(UIControlStateNormal)];
    [cell.button setTitle:model[@"name"] forState:(UIControlStateNormal)];
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
        @{@"name":@"我的资产",
          @"picuture":@"grzx_wdzc"},
        
        @{@"name":@"我的团队",
          @"picuture":@"grzx_wdtd"},
        
        @{@"name":@"我的账单",
          @"picuture":@"grzx__wdzd"},
        
        @{@"name":@"商家入驻",
          @"picuture":@"grzx_sjrz"},
        
        @{@"name":@"收货地址",
          @"picuture":@"grzx_shdz"},
        
        @{@"name":@"优惠券",
          @"picuture":@"grzx_yhq"},
        
        @{@"name":@"联系客服",
          @"picuture":@"grzx_lxkf"},
        
        @{@"name":@"关于我们",
          @"picuture":@"grzx_gywm"},

        ];
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index {
    id headerClass = [YXBHeaderView class];
    YXBHeaderView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    
    header.bgView.backgroundColor = YXBColorBG_white;
    header.bgView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
    header.bgView.layer.cornerRadius = 5;
    [header.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    header.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    header.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [header.leftButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [header.leftButton setTitle:@"我的服务" forState:(UIControlStateNormal)];
    [header.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 42);
}

@end
