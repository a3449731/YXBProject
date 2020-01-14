//
//  SPHomeButtonTwoSection.m
//  MyProject
//
//  Created by 杨 on 6/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPHomeButtonTwoSection.h"
#import "YXBButtonCell.h"
#import "NSArray+YXBAdd.h"
#import <NSObject+QMUI.h>

@interface SPHomeButtonTwoSection ()

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation SPHomeButtonTwoSection

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
    if ([model.allKeys containsObject:@"picuture"]) {
        [cell.button setImage:[UIImage imageNamed:[model valueForKey:@"picuture"]] forState:(UIControlStateNormal)];
    } else {
        [cell.button setImage:nil forState:(UIControlStateNormal)];
    }
    if ([model.allKeys containsObject:@"name"]) {
        [cell.button setTitle:[model valueForKey:@"name"] forState:(UIControlStateNormal)];
    } else {
        [cell.button setTitle:nil forState:(UIControlStateNormal)];
    }
    [cell.button sizeToFit];
}

- (void)didUpdateToObject:(id)object {
    // 因为横向滑动 数据排列的问题。 要对元数据进行重组
    // 1.以8个为一组,(因一页展示8个)。 奇偶分离
    NSArray *splitArray = [[self creatData] splitWithSubSize:8];
    NSMutableArray *backArray = [NSMutableArray array];
    for (NSArray *temArray in splitArray) {
        NSArray *newArray = [temArray verticalToHornorRank:8];
        [backArray addObjectsFromArray:newArray];
    }
    self.modelArray = backArray;
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
        
        @{@"name":@"1",
          @"picuture":@"sy_gn_icon6"},
        
        @{@"name":@"2",
          @"picuture":@"sy_gn_ico7"},
        
        @{@"name":@"3",
          @"picuture":@"sy_gn_icon8"},
        
        @{@"name":@"4",
          @"picuture":@"sy_gn_icon6"},

        @{@"name":@"5",
          @"picuture":@"sy_gn_ico7"},

        @{@"name":@"6",
        @"picuture":@"sy_gn_ico7"},

        @{@"name":@"7",
        @"picuture":@"sy_gn_ico7"},
        
    ];
}

@end
