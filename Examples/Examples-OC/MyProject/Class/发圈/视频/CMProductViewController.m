//
//  CouPonViewController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMProductViewController.h"
#import <IGListKit/IGListKit.h>
#import <QMUIKit/QMUIButton.h>
#import "SPSearchResultCell.h"

@interface CMProductViewController ()<IGListAdapterDataSource,IGListSingleSectionControllerDelegate>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) IGListCollectionView *collectionView;


@end

@implementation CMProductViewController

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpTool];
    [self setUpData];
    
}

- (void)setUpUI {
    self.view.backgroundColor = UIColorFromHex(#FFFFFF);
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromHex(#CCCCCC);
    view.layer.cornerRadius = 2.5;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(5);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(65);
    }];
    [self creatCollectionView];
}

- (void)setUpTool {
    [self creatAdapter];
}

- (void)setUpData {
    [self.adapter reloadDataWithCompletion:nil];
}

#pragma mark --------------- collectionView , IGList -------------------
- (void)creatCollectionView {
    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO scrollDirection:(UICollectionViewScrollDirectionVertical) topContentInset:0 stretchToEdge:YES];
    self.collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero listCollectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view);
    }];
    [self.collectionView registerClass:[SPSearchResultCell class] forCellWithReuseIdentifier:@"CMProductViewController"];
    self.collectionView.bounces = NO;
    
}

- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.modelArray;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    
    if ([object isKindOfClass:[ProductModel class]]) {
        IGListSingleSectionController *sc = [[IGListSingleSectionController alloc] initWithCellClass:[SPSearchResultCell class] configureBlock:^(id  _Nonnull item, __kindof SPSearchResultCell * _Nonnull cell) {
            
            [cell circleProductStyleLayout];
            [self cell:cell forProductModel:item];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            
        } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
            return CGSizeMake(collectionContext.containerSize.width, 120);
        }];
        sc.selectionDelegate = self;
        // 周边距
        sc.inset = UIEdgeInsetsMake(0, 0, 1, 0);
        // 行间距 与 列间距
        //    sc.minimumLineSpacing = 10;
        //    sc.minimumInteritemSpacing = 14.5;
        return sc;
    }
    return [IGListSectionController new];
}

// 空布局
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectZero];
    button.imagePosition = QMUIButtonImagePositionTop;
    button.spacingBetweenImageAndTitle = 14;
    [button setImage:[UIImage imageNamed:@"wd_scj_qsy2"] forState:(UIControlStateNormal)];
    [button setTitle:@"还没有推荐商品呦~" forState:(UIControlStateNormal)];
    [button setTitleColor:UIColorFromHex(#999999) forState:(UIControlStateNormal)];
    return button;
}

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController withObject:(id)object {
//    GoodsDetailViewController *vc = [GoodsDetailViewController new];
//    vc.productModel = object;
//    [self dismissViewControllerAnimated:YES completion:^{
//       PUSH(vc);
//    }];
}

- (void)cell:(SPSearchResultCell *)cell forProductModel:(ProductModel *)model {
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    cell.originPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.originalPrice];
    cell.nameLabel.text = model.goodsName;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:nil];
}

@end
