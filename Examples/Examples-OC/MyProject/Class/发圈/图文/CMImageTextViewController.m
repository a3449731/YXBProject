//
//  CMImageTextViewController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/20.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMImageTextViewController.h"
#import <IGListKit/IGListKit.h>
#import "CMRecommendSection3.h"
#import "CMRecommendSection4.h"
#import "SelVideoAPI.h"

@interface CMImageTextViewController () <IGListAdapterDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<CMImageTextModel *> *modelArray;
@property (nonatomic, copy) NSString *page;

@end

@implementation CMImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatCollectionView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    self.page = @"1";
    self.modelArray = [NSMutableArray array];
    [self reqeustImgaeTextData];
}

- (void)reqeustImgaeTextData {
    MJWeakSelf;
    SelVideoAPI *network = [[SelVideoAPI alloc] initWithType:(CMSelCircleImageText) page:self.page limit:@"10"];
    [network startWithCompletionBlockWithSuccess:^(__kindof SelVideoAPI * _Nonnull request) {
        
        if ([weakSelf.page integerValue] == 1) {
            weakSelf.modelArray = [network jsonForImageTextModel].mutableCopy;
        } else {
            [weakSelf.modelArray addObjectsFromArray:[network jsonForImageTextModel]];
        }
        [weakSelf.adapter reloadDataWithCompletion:nil];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.collectionView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJWeakSelf
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = @"1";
        [weakSelf reqeustImgaeTextData];
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    MJWeakSelf
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page = [NSString stringWithFormat:@"%ld",[weakSelf.page integerValue] + 1];
        [weakSelf reqeustImgaeTextData];
    }];
    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
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
    //    return [IGListSectionController new];
    CMRecommendSection4 *sc4 = [CMRecommendSection4 new];
    NSArray *array = @[[CMRecommendSection3 new],
                       sc4];
    IGListStackedSectionController *stact = [[IGListStackedSectionController alloc] initWithSectionControllers:array];
    stact.inset = UIEdgeInsetsMake(0, 0, 0, 0);
    return stact;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
