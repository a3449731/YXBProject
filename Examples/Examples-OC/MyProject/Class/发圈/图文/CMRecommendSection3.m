//
//  CMRecommendSection3.m
//  BusProject
//
//  Created by 杨 on 2018/7/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "CMRecommendSection3.h"
#import "CMReconmmendCell.h"
#import "CMReconmmendPictureSection.h"
//#import "CMTieziDetailViewController.h"
//#import "CMTieziModel.h"
#import "NSArray+IGListDiffable.h"
#import <NSString+YYAdd.h>
#import "CMImageTextModel.h"
#import "NSArray+IGListDiffable.h"

@interface CMRecommendSection3() <IGListAdapterDataSource>

@property (nonatomic , strong) IGListAdapter *adapter;

@property (nonatomic , strong) CMImageTextModel *model;

@end

@implementation CMRecommendSection3

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
//        self.minimumLineSpacing = 100;
//        self.minimumInteritemSpacing = 100;
        
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    CGSize size = [self.model.context sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(self.collectionContext.containerSize.width - 15 - 20, 0) mode:(NSLineBreakByWordWrapping)];
    
    NSInteger count = 0;
    if ([self.model.detailsImg hasSuffix:@","]) {
        NSMutableString *string = [NSMutableString stringWithString:self.model.detailsImg];
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
        count = [string componentsSeparatedByString:@","].count;
    } else {
        count = [self.model.detailsImg componentsSeparatedByString:@","].count;
   }
    NSInteger line = (count / 3) + (count % 3 > 0 ? 1 : 0);
    
    return CGSizeMake(self.collectionContext.containerSize.width, size.height + 43 + 15 + 20 + line * kItemWidthCount(3));
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    id cellClass;
    
    cellClass = [CMReconmmendCell class];
    
    CMReconmmendCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass(cellClass) bundle:nil forSectionController:self atIndex:index];
    self.adapter.collectionView = cell.collectionView;
    cell.collectionView.bounces = NO;
    cell.collectionView.userInteractionEnabled = NO;
//    cell.bootomLineShow = YES;
//    cell.bootomLineInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    cell.bootomLineColor = COLOR(204, 204, 204, 1);
    
    [cell cellForModel:self.model];

    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
//    CMTieziDetailViewController *vc = [[CMTieziDetailViewController alloc] initWithNibName:@"CMTieziDetailViewController" bundle:nil];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:vc animated:YES];
//
//    CMTieziDetailViewController *vc = [CMTieziDetailViewController pushCMTieziDetailViewController:self.viewController.navigationController];
//    vc.post_id = self.model.data.posting.post_id;
}



#pragma mark ---------- 图片嵌套adapter ------------------
- (IGListAdapter *)adapter
{
    if (!_adapter)
    {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self.viewController];
        _adapter.dataSource = self;
    }
    return _adapter;
}
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
{
    CMImageTextModel *model = self.model;
    if ([model.detailsImg hasSuffix:@","]) {
           NSMutableString *string = [NSMutableString stringWithString:model.detailsImg];
           [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
         return @[[string componentsSeparatedByString:@","]];
       } else {
        return @[ [self.model.detailsImg componentsSeparatedByString:@","]];
       }
    
//    return @[model.url];
}
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object
{
    return [CMReconmmendPictureSection new];
//        return [EvaluatePictureSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
{
    return nil;
}

@end
