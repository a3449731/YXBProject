//
//  SPHomeButtonSection.m
//  MyProject
//
//  Created by 杨 on 3/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeButtonSection.h"
#import "YXBButtonCell.h"

@interface SPHomeButtonSection ()

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation SPHomeButtonSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.modelArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(4), 90);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [YXBButtonCell class];
    YXBButtonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
//    cell.button.enabled = NO;
//    cell.button.alpha = 1;
    cell.button.imageEdgeInsets = UIEdgeInsetsMake((kItemWidthCount(4) - 50) / 2, (kItemWidthCount(4) - 50) / 2, (kItemWidthCount(4) - 50) / 2, (kItemWidthCount(4) - 50) / 2);
    cell.button.titleEdgeInsets = UIEdgeInsetsMake(-25, 0, 0, 0);
    cell.button.userInteractionEnabled = NO;
    cell.button.titleLabel.font = [UIFont systemFontOfSize:12];
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
        @{@"name":@"女装服饰",
          @"picuture":@"sy_gn_icon"},
        
        @{@"name":@"家具百货",
          @"picuture":@"sy_gn_icon2"},
        
        @{@"name":@"美妆护肤",
          @"picuture":@"sy_gn_icon3"},
        
        @{@"name":@"母婴用品",
          @"picuture":@"sy_gn_icon4"},
        
        @{@"name":@"食品零食",
          @"picuture":@"sy_gn_icon5"},
        
        @{@"name":@"数码产品",
          @"picuture":@"sy_gn_icon6"},
        
        @{@"name":@"潮流箱包",
          @"picuture":@"sy_gn_ico7"},
        
        @{@"name":@"运动健康",
          @"picuture":@"sy_gn_icon8"},
        
        ];
}

@end
