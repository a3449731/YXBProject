//
//  SPCommonPictureSectionController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/25.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "SPCommonPictureSectionController.h"
#import <QMUIImagePreviewViewController.h>
#import "SPCommonPictureCell.h"

@interface SPCommonPictureSectionController () <QMUIImagePreviewViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *modelArray;

@end

@implementation SPCommonPictureSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 12, 0, 12);
        self.minimumLineSpacing = 11;
        self.minimumInteritemSpacing = 11;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.modelArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(kItemWidthCount(3), kItemWidthCount(3));
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass;
    cellClass = [SPCommonPictureCell class];
    
    SPCommonPictureCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell commonPictureStyleLayout];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.modelArray[index]] placeholderImage:nil];
    cell.imageView.image = [UIImage imageNamed:self.modelArray[index]];
    return cell;
}

- (void)didUpdateToObject:(id)object {
//    // 先分割再拼接是因为，后台返的数据可能是结尾存在逗号。
//    NSMutableArray *tempArray = [object.commentsImg componentsSeparatedByString:@","].mutableCopy;
//     // 拆分后存在@""空字符串
//    [tempArray removeObject:@""];
    self.modelArray = @[@"bg1",@"bg2",@"bg3"];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    QMUIImagePreviewViewController *vc = [[QMUIImagePreviewViewController alloc] init];
//    vc.presentingStyle = QMUIImagePreviewViewControllerTransitioningStyleZoom;
    vc.imagePreviewView.delegate = self;
    vc.imagePreviewView.currentImageIndex = index;
    [self.viewController presentViewController:vc animated:YES completion:nil];
}

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.modelArray.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    
    zoomImageView.reusedIdentifier = @(index);
    // 模拟异步加载的情况
    if (index == 2) {
        [zoomImageView showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([zoomImageView.reusedIdentifier isEqual:@(index)]) {
                [zoomImageView hideEmptyView];
                zoomImageView.image = [UIImage imageNamed:self.modelArray[index]];
            }
        });
    } else {
        zoomImageView.image = [UIImage imageNamed:self.modelArray[index]];
    }
}

@end
