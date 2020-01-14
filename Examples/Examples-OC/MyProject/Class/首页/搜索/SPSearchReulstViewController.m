//
//  SPSearchReulstViewController.m
//  MyProject
//
//  Created by 杨 on 13/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPSearchReulstViewController.h"
#import <MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <PYSearch/PYSearch.h>
//#import "GoodsListAPI.h"
#import "SPHomeSearchResultCell.h"
#import "SPProductDetailViewController.h"

@interface SPSearchReulstViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,PYSearchViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, copy) NSString *currentPage;

@property (nonatomic, copy) NSString *searchText; // 当前的搜索文本

@end

@implementation SPSearchReulstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatTableView];
}

- (void)setupTool {
    // 监听搜索框变化
    [self creatSearchDelegate];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    self.currentPage = @"1";
    self.modelArray = [NSMutableArray array];
}

#pragma mark ---------- 搜索框 ---------------------------
- (void)creatSearchDelegate {
    // 这个地方存在不确定因素,
    PYSearchViewController *vc = (PYSearchViewController *)getCuttentViewController();
    if ([vc isKindOfClass:[PYSearchViewController class]]) {
        // 不要使用strong强持有PYSearchViewController，会造成循环引用
        vc.delegate = self;
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText {
    if (searchText.length) {
        self.searchText = searchText;
        [self reqeustOnePage];
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController
   didSelectHotSearchAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText {
    self.searchText = searchText;
    [self reqeustOnePage];
}

- (void)searchViewController:(PYSearchViewController *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText {
    self.searchText = searchText;
    [self reqeustOnePage];
}


#pragma mark ---------- MJRefresh -------------
- (void)creatMJ_header {
    MJWeakSelf;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reqeustOnePage];
    }];
    self.tableView.mj_header = header;
}

- (void)creatMJ_footer {
    MJWeakSelf;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf reqeustMoreData];
    }];
    self.tableView.mj_footer = footer;
}

#pragma mark ----------- tableView ------------
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = UIColorFromHex(#F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPHomeSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPHomeSearchResultCell"];
    if (cell == nil) {
        cell = [[SPHomeSearchResultCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SPHomeSearchResultCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColorFromHex(#F6F6F6);
    [cell layoutWithSearchProduct];
    [cell cellForModel:@""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SPProductModel *model = self.modelArray[indexPath.row];
    SPProductDetailViewController *vc = [SPProductDetailViewController new];
//    vc.goodsID = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"qsy"];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

#pragma mark ---------- 请求数据 -----------
- (void)reqeustOnePage {
    MJWeakSelf;
    self.currentPage = @"1";
//    GoodsListAPI *network = [[GoodsListAPI alloc] initWithPageNum:self.currentPage pageSize:@"20" firstClassify:nil secondClassify:nil goodsName:self.searchText orderType:nil shopId:nil];
//    [network startWithCompletionBlockWithSuccess:^(__kindof GoodsListAPI * _Nonnull request) {
//        weakSelf.modelArray = [[request jsonForModel] mutableCopy];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
}

- (void)reqeustMoreData {
    MJWeakSelf;
    self.currentPage = [NSString stringWithFormat:@"%ld",[self.currentPage integerValue] + 1];
//    GoodsListAPI *network = [[GoodsListAPI alloc] initWithPageNum:self.currentPage pageSize:@"20" firstClassify:nil secondClassify:nil goodsName:self.searchText orderType:nil shopId:nil];
//    [network startWithCompletionBlockWithSuccess:^(__kindof GoodsListAPI * _Nonnull request) {
//        NSArray *array = [request jsonForModel];
//        [weakSelf.modelArray addObjectsFromArray:array];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
}

- (void)dealloc {
    
}

@end
