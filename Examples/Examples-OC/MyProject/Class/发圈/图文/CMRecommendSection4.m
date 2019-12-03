//
//  CMRecommendSection4.m
//  BusProject
//
//  Created by 杨 on 2018/7/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "CMRecommendSection4.h"
//#import "ButtonStateCell.h"
#import "YXBButtonCell.h"

#import "YXBHeaderView.h"
//#import "CMTieziModel.h"
#import "CMCommentViewController.h"
#import "CMImageTextModel.h"
#import "CircleCollectionAPI.h"
#import "CMImageTextViewController.h"

@interface CMRecommendSection4() <IGListSupplementaryViewSource>

@property (nonatomic , strong) CMImageTextModel *model;

@end

@implementation CMRecommendSection4
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 3;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(kItemWidthCount(3), 44);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    NSArray *titleArray = @[@"分享",@"留言",@"点赞"];
    NSArray *imageArray = @[@"fq_gz_share",@"fq_gz_message",@"fq_dianzan"];
    NSArray *selectImageArray = @[@"fq_gz_share",@"fq_gz_message",@"fq_gz"];
    
    id cellClass;
    cellClass = [YXBButtonCell class];
    
    YXBButtonCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    cell.button.userInteractionEnabled = NO;
    cell.button.imagePosition = QMUIButtonImagePositionLeft;
    cell.button.spacingBetweenImageAndTitle = 5;
    [cell.button setTitle:titleArray[index] forState:(UIControlStateNormal)];
    if (self.model.isLike) {
        [cell.button setImage:[UIImage imageNamed:selectImageArray[index]] forState:(UIControlStateNormal)];
    } else {
        [cell.button setImage:[UIImage imageNamed:imageArray[index]] forState:(UIControlStateNormal)];
    }
    cell.button.titleLabel.font = [UIFont systemFontOfSize:12];
    [cell.button setTitleColor:RGBAColor(51, 51, 51, 1) forState:(UIControlStateNormal)];
    
    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    if (index == 2)
    {
//        [CMRecommendViewController dingTieZi:self.model];
        
        YXBButtonCell *cell = [self.collectionContext cellForItemAtIndex:index sectionController:self];
        [self likeAction:cell];
    }

    if (index == 1)
    {
        CMCommentViewController *vc = [CMCommentViewController new];
        vc.targeID = self.model.id;
        CGRect rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 420, [UIScreen mainScreen].bounds.size.width, 420);
        SheetPresentVC(vc, rect);
    }
}

- (void)likeAction:(YXBButtonCell *)cell {
    MJWeakSelf;
    if (self.model.isLike) {
        CircleCollectionAPI *network = [[CircleCollectionAPI alloc] initWithTargetID:self.model.id type:@"1" classify:@"1"];
        [network startWithCompletionBlockWithSuccess:^(__kindof CircleCollectionAPI * _Nonnull request) {
            if ([request isValidRequestData]) {
                weakSelf.model.isLike = NO;
                [cell.button setImage:[UIImage imageNamed:@"fq_dianzan"] forState:(UIControlStateNormal)];
                CMImageTextViewController *vc = (CMImageTextViewController *)self.viewController;
                [vc.adapter reloadDataWithCompletion:nil];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else {
        CircleCollectionAPI *network = [[CircleCollectionAPI alloc] initWithTargetID:self.model.id type:@"1" classify:@"1"];
        [network startWithCompletionBlockWithSuccess:^(__kindof CircleCollectionAPI * _Nonnull request) {
            if ([request isValidRequestData]) {
                weakSelf.model.isLike = YES;
                [cell.button setImage:[UIImage imageNamed:@"fq_gz"] forState:(UIControlStateNormal)];
                CMImageTextViewController *vc = (CMImageTextViewController *)self.viewController;
                [vc.adapter reloadDataWithCompletion:nil];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
}


#pragma mark ----------- 头 -------------
// 需要在 init中遵守 supplementaryViewSource 协议 。
- (NSArray<NSString *> *)supportedElementKinds
{
    return @[UICollectionElementKindSectionFooter];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index
{
    
    YXBHeaderView *footer = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:[YXBHeaderView class] atIndex:index];
    footer.backgroundColor = RGBAColor(240, 242, 245, 1);
    return footer;
    
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index
{
    return CGSizeMake(kScreenWidth, 10);
}

@end
