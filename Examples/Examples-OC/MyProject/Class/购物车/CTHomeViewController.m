//
//  CTHomeViewController.m
//  MyProject
//
//  Created by 杨 on 5/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "CTHomeViewController.h"
#import <IGListKit/IGListKit.h>
#import <YYText/YYText.h>
#import <MJRefresh/MJRefresh.h>
#import "CTHStoreSection.h"
#import "CTHEmptySection.h"
#import "SPRecomendSection.h"
#import "NSArray+IGListDiffable.h"
#import "CTHomeModel.h"

@interface CTHomeViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) IGListCollectionView *collectionView;
@property (nonatomic, strong) CTHomeModel *model;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) QMUIButton *allSelectButton; // 全选
@property (nonatomic, strong) UILabel *totalPriceLabel; // 总价
@property (nonatomic, strong) QMUIButton *settleButton; // 结算
@property (nonatomic, strong) QMUIButton *deleteButton; // 删除
@property (nonatomic, strong) QMUIButton *collectButton; // 移入收藏夹

@end

static NSInteger bottomHeight = 49;

@implementation CTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(@"购物车");

- (void)setupUI {
    [self setupNavigationItem];
    [self creatRightItem];
    [self creatCollectionView];
    [self ctratBottomView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
    [self creatNotification];
}

- (void)setupData {
    [self caculateTotalPrice];
    //    [self requestData];
}

#pragma mark -------------- right item --------------------
- (void)creatRightItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"随便" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self rightAction:rightItem];
}

- (void)removeRightItem {
    UIBarButtonItem *rightItem = self.navigationItem.rightBarButtonItem;
    rightItem.title = @"";
}

- (void)rightAction:(UIBarButtonItem *)item {
    if (item.title.length) {
        if ([item.title isEqualToString:@"编辑"]) {
            item.title = @"完成";
            self.settleButton.hidden = YES;
            self.totalPriceLabel.hidden = YES;
            self.deleteButton.hidden = NO;
            self.collectButton.hidden = NO;
        } else {
            item.title = @"编辑";
            self.settleButton.hidden = NO;
            self.totalPriceLabel.hidden = NO;
            self.deleteButton.hidden = YES;
            self.collectButton.hidden = YES;
        }
    }
}

- (void)requestData {
    self.model = [[CTHomeModel alloc] init];
    NSMutableArray *storeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i ++) {
        CTHStoreModel *stroeModel = [[CTHStoreModel alloc] init];
        NSMutableArray *productArray = [NSMutableArray array];
        for (NSInteger j = 0; j < arc4random() % 6; j ++) {
            CTHProductModel *proModel = [[CTHProductModel alloc] init];
            proModel.yxb_price = [NSString stringWithFormat:@"%u", arc4random()%1000];
            proModel.yxb_count = [NSString stringWithFormat:@"%u", arc4random()%20 + 1];
            [productArray addObject:proModel];
        }
        stroeModel.productList = productArray;
        [storeArray addObject:stroeModel];
    }
    self.model.storeList = storeArray;
    [self.adapter reloadDataWithCompletion:nil];
    
    [self.collectionView.mj_header endRefreshing];
    [self creatRightItem];
    [self checkChooseStatus];
    [self caculateTotalPrice];
}

- (void)ctratBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(bottomHeight);
    }];
    
    [self creatAllSelcetButton];
    [self creatTotalPriceLabel];
    [self creatSettleButton];
    [self creatDeleteButton];
    [self creatCollectButton];
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO scrollDirection:(UICollectionViewScrollDirectionVertical) topContentInset:0 stretchToEdge:YES];
    self.collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero listCollectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    //    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //
    //    }];
    //    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    if (self.model) {
        if (self.model.storeList.count) {
            NSMutableArray *array = [self.model.storeList mutableCopy];
            [array addObject:@"7"];
            return array;
        } else {
            return @[@"no",@"7"];
        }
    }
    return @[@"no",@"7"];;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[CTHStoreModel class]]) {
        self.bottomView.hidden = NO;
        self.adapter.collectionView.contentInset = UIEdgeInsetsMake(0, 0, bottomHeight, 0);
        return [CTHStoreSection new];
    }
    if ([object isEqual:@"no"]) {
        [self removeRightItem];
        self.bottomView.hidden = YES;
        self.adapter.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        return [CTHEmptySection new];
    }
    if ([object isEqual:@"7"]) {
        return [SPRecomendSection new];
    }
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark ----------- 总价 -------------------
- (void)creatTotalPriceLabel {
    self.totalPriceLabel = [[UILabel alloc] init];
    [self.bottomView addSubview:self.totalPriceLabel];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.allSelectButton.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(0);
    }];
}

// 计算总价
- (void)caculateTotalPrice {
    NSString *totalPrice = @"";
    for (CTHStoreModel *storeModel in self.model.storeList) {
        for (CTHProductModel *productModel in storeModel.productList) {
            if (productModel.selected == YES) {
                NSString *onePrice = stringMultiplyString(productModel.yxb_price, productModel.yxb_count);
                totalPrice = stringAddString(totalPrice, onePrice);
            }
        }
    }
    NSString *price = [NSString stringWithFormat:@"￥%@",stringAccuracyRoundDown(totalPrice, YXBAccuracyTwo)];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:%@",price]];
    att.yy_font = [UIFont systemFontOfSize:12];
    att.yy_color = YXBColorGray_999;
    NSRange range = [att.string rangeOfString:price];
    [att yy_setFont:[UIFont systemFontOfSize:15] range:range];
    [att yy_setColor:YXBColorRed_Medium range:range];
    self.totalPriceLabel.attributedText = att;
}

#pragma mark ----------- 全选 ------------------
- (void)creatAllSelcetButton {
    self.allSelectButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.allSelectButton.imagePosition = QMUIButtonImagePositionLeft;
    self.allSelectButton.spacingBetweenImageAndTitle = 10;
    self.allSelectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.allSelectButton setTitleColor:YXBColorBlack forState:(UIControlStateNormal)];
    [self.allSelectButton setTitle:@"全选" forState:(UIControlStateNormal)];
    [self.allSelectButton setImage:[UIImage imageNamed:@"gwc_wxz"] forState:(UIControlStateNormal)];
    [self.allSelectButton setImage:[UIImage imageNamed:@"gwc_xz"] forState:(UIControlStateSelected)];
    [self.bottomView addSubview:self.allSelectButton];
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    [self.allSelectButton addTarget:self action:@selector(allChooseAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)allChooseAction:(UIButton *)button {
    button.selected = !button.selected;
    for (CTHStoreModel *storeModel in self.model.storeList) {
        storeModel.selected = button.selected;
        for (CTHProductModel *productModel in storeModel.productList) {
            productModel.selected = button.selected;
        }
    }
    // 发通知到购物车首页
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHomeChooseChangeNotification object:nil];
}

// 检查店铺的选择按钮状态，检查全选的按钮状态
- (void)checkChooseStatus {
    BOOL allChoose = YES;
    for (CTHStoreModel *storeModel in self.model.storeList) {
        BOOL storeProductAllChoose = YES;
        for (CTHProductModel *productModel in storeModel.productList) {
            if (productModel.selected == NO) {
                // 一旦有未选中的商品，就要取消店铺的选择状态
                storeProductAllChoose = NO;
            }
        }
        storeModel.selected = storeProductAllChoose;
        if (storeModel.selected == NO) {
            allChoose = NO;
        }
    }
    // 如果没有商品了，也不要全选
    if (self.model.storeList.count == 0) {
        allChoose = NO;
    }
    self.allSelectButton.selected = allChoose;
}


#pragma mark ------------ 选中的通知（选择商品，选择店铺，选中全部 以及商品加减), 以及删除也会走通知 --------------------
- (void)creatNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseChangeNotifaction:) name:CTHomeChooseChangeNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTHomeChooseChangeNotification object:nil];
}

- (void)chooseChangeNotifaction:(NSNotification *)notification {
    // 检查店铺的选择按钮状态，检查全选的按钮状态
    [self checkChooseStatus];
    
    // 计算总价
    [self caculateTotalPrice];
    
    [self.adapter reloadDataWithCompletion:nil];
}

#pragma mark -------------- 删除 -------------------
- (void)creatDeleteButton {
    self.deleteButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.deleteButton setTitleColor:YXBColorGray_999 forState:(UIControlStateNormal)];
    [self.deleteButton setTitle:@"删除" forState:(UIControlStateNormal)];
    self.deleteButton.layer.cornerRadius = 15;
    self.deleteButton.layer.borderWidth = 1;
    self.deleteButton.layer.borderColor = YXBColorGray_999.CGColor;
    [self.bottomView addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-112);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    [self.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)deleteAction:(UIButton *)button {
    
    // 删商品。
    for (NSInteger i = self.model.storeList.count - 1; i >= 0; i--) {
        CTHStoreModel *storeModel = self.model.storeList[i];
        for (NSInteger j = storeModel.productList.count - 1; j >= 0 ; j--) {
            CTHProductModel *productModel = storeModel.productList[j];
            if (productModel.selected == YES) {
                [storeModel.productList removeObjectAtIndex:j];
            }
        }
    }
    
    // 把没有商品的店铺也删除掉
    for (NSInteger i = self.model.storeList.count - 1; i >= 0; i--) {
        CTHStoreModel *storeModel = self.model.storeList[i];
        if (storeModel.productList.count == 0) {
            [self.model.storeList removeObjectAtIndex:i];
        }
    }
    
    // 发通知到购物车首页
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHomeChooseChangeNotification object:nil];
    
    ShowToast(@"删除");
}

#pragma mark -------------- 移入收藏夹 -------------------
- (void)creatCollectButton {
    self.collectButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.collectButton setTitleColor:YXBColorRed_Medium forState:(UIControlStateNormal)];
    [self.collectButton setTitle:@"移入收藏夹" forState:(UIControlStateNormal)];
    self.collectButton.layer.cornerRadius = 15;
    self.collectButton.layer.borderWidth = 1;
    self.collectButton.layer.borderColor = YXBColorRed_Medium.CGColor;
    [self.bottomView addSubview:self.collectButton];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    [self.collectButton addTarget:self action:@selector(collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)collectAction:(UIButton *)button {
    ShowToast(@"移入收藏夹");
}


#pragma mark --------------- 结算 -------------------
- (void)creatSettleButton {
    self.settleButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.settleButton.adjustsButtonWhenHighlighted = YES;
    self.settleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.settleButton setTitleColor:YXBColorWhite forState:(UIControlStateNormal)];
    [self.settleButton setTitle:@"结算" forState:(UIControlStateNormal)];
    self.settleButton.backgroundColor = YXBColorRed_Medium;
    self.settleButton.layer.cornerRadius = 15;
    [self.bottomView addSubview:self.settleButton];
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    [self.settleButton addTarget:self action:@selector(settleAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)settleAction:(UIButton *)button {
    ShowToast(@"结算");
}

- (void)dealloc {
    [self removeNotification];
}

@end
