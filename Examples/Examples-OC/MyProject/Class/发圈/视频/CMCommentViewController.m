//
//  CouPonViewController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/10/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMCommentViewController.h"
#import <QMUIKit/QMUIButton.h>
#import "CMCommentCell.h"
#import "YXBHeaderView.h"
#import "SelVideoCommentListAPI.h"
#import "InsVideoCommentAPI.h"

@interface CMCommentViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray<CMCommentModel *> *modelArray;
@property (nonatomic, copy) NSString *page;

@end

@implementation CMCommentViewController

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
    [self creatTableView];
    [self creatCommentView];
}

- (void)setUpTool {
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setUpData {
    self.page = @"1";
    self.modelArray = [NSMutableArray array];
    [self reqeustCommentData];
}

- (void)reqeustCommentData {
    SelVideoCommentListAPI *network = [[SelVideoCommentListAPI alloc] initWithVideoID:self.targeID page:self.page limit:@"10"];
    [network startWithCompletionBlockWithSuccess:^(__kindof SelVideoCommentListAPI * _Nonnull request) {
        NSArray *array = [request jsonForModel];
        if ([self.page integerValue] == 1) {
            self.modelArray = array.mutableCopy;
        } else {
            [self.modelArray addObjectsFromArray:array];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)creatMJ_header {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = @"1";
        [self reqeustCommentData];
    }];
    self.tableView.mj_header = header;
}

- (void)creatMJ_footer {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = [NSString stringWithFormat:@"%ld",[self.page integerValue] + 1];
        [self reqeustCommentData];
    }];
    self.tableView.mj_footer = footer;
}

#pragma mark --------------- tableview -------------------
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
//    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-48);
    }];
    [self.tableView registerClass:[CMCommentCell class] forCellReuseIdentifier:@"CMCommentCell"];
//    [self.tableView registerClass:[YXBReusableView class] forHeaderFooterViewReuseIdentifier:@"YXBReusableView"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMCommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellWithModel:self.modelArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YXBHeaderView *header = [[YXBHeaderView alloc] init];
    header.backgroundColor = [UIColor whiteColor];
    [header.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(12);
    }];
    header.leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [header.leftButton setTitleColor:UIColorFromHex(#333333) forState:(UIControlStateNormal)];
    header.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSString *title = [NSString stringWithFormat:@"%ld条评论",self.modelArray.count];
    [header.leftButton setTitle:title forState:(UIControlStateNormal)];
    return header;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectZero];
    button.imagePosition = QMUIButtonImagePositionTop;
    button.spacingBetweenImageAndTitle = 14;
    [button setImage:[UIImage imageNamed:@"wd_scj_qsy2"] forState:(UIControlStateNormal)];
    [button setTitle:@"暂无评论~" forState:(UIControlStateNormal)];
    [button setTitleColor:UIColorFromHex(#999999) forState:(UIControlStateNormal)];
    return button;
}

#pragma mark ---------- 添加评论 -----------
- (void)creatCommentView {
    
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitleColor:UIColorFromHex(#333333) forState:(UIControlStateNormal)];
    [confirmButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_offset(0);
        make.width.mas_equalTo(73);
    }];
    [confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColorFromHex(#F3F3F3);
    bgView.layer.cornerRadius = 19;
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(confirmButton.mas_left).mas_offset(-10);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"发送评论";
    self.textField.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)confirmAction:(UIButton *)button {
    if (self.textField.text.length == 0) {
        ShowToast(@"评论不能为空");
        return;
    }
    
    [self.view endEditing:YES];
    MJWeakSelf;
    InsVideoCommentAPI *network = [[InsVideoCommentAPI alloc] initWithVideoID:self.targeID context:self.textField.text];
    [network startWithCompletionBlockWithSuccess:^(__kindof InsVideoCommentAPI * _Nonnull request) {
        if ([request isValidRequestData]) {
            ShowToast(@"评论成功");
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
