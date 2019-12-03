//
//  MemberViewController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/1.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "MemberViewController.h"
#import <IGListKit/IGListKit.h>

#import "MGiftSection.h"
#import "MShareSection.h"
#import "MGiftCell.h"

@interface MemberViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *memberButton;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatBecomeMemberButton];
    [self creatCollectionView];
}

- (void)setupTool {
    [self creatAdapter];
}

- (void)setupData {
    [self requestHomeData];
}

#pragma mark ---------- 首页数据 -------------
- (void)requestHomeData {
//    GetMemberDataAPI *network = [[GetMemberDataAPI alloc] init];
//    [network startWithCompletionBlockWithSuccess:^(__kindof GetMemberDataAPI * _Nonnull request) {
//        self.model = [request jsonForModel];
//        if (self.model) {
//            [self.adapter reloadDataWithCompletion:nil];
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//    }];
}


#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.memberButton.mas_top).mas_offset(-5);
    }];
    
    // 这里提前注册了,IGList中会过滤同一个cell注册不同的标识。 注意在section中使用的注册标识和这里是不一样的
    [self.collectionView registerClass:[MGiftCell class] forCellWithReuseIdentifier:@"MGiftSectionMGiftCell"];
    [self.collectionView registerClass:[MGiftCell class] forCellWithReuseIdentifier:@"MShareSectionMGiftCell"];
}



#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

    return @[@"0",@"4"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isEqual:@"0"]) {
        return [MGiftSection new];
    }

    if ([object isEqual:@"4"]) {
        return [MShareSection new];
    }
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark --------- 成为会员 -----------
- (void)creatBecomeMemberButton {
    self.memberButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.memberButton.backgroundColor = UIColorFromHex(#F3CEB1);
    self.memberButton.layer.cornerRadius = 22;
    self.memberButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.memberButton setTitleColor:UIColorFromHex(#6E371A) forState:(UIControlStateNormal)];
    [self.memberButton setTitle:@"立即开通会员" forState:(UIControlStateNormal)];
    [self.view addSubview:self.memberButton];
    [self.memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    [self.memberButton addTarget:self action:@selector(becomeMemberAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)becomeMemberAction:(UIButton *)button {
    
}

@end
