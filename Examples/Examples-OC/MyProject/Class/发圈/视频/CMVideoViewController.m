//
//  CMVideoViewController.m
//  MyProject
//
//  Created by ShengChang on 2019/11/17.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMVideoViewController.h"
#import <QMUIKit/QMUIButton.h>
#import "CMProductViewController.h"
#import "CMCommentViewController.h"
#import "CircleCollectionAPI.h"

@interface CMVideoViewController ()

@property (nonatomic, strong) UIButton *totalButton; // 全部商品
@property (nonatomic, strong) UIView *productView;
@property (nonatomic, strong) QMUIButton *commentButton;
@property (nonatomic, strong) QMUIButton *likeButton;

@end

@implementation CMVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatTotalButton];
    [self creatLikeButton];
    [self creatCommonButton];
}

- (void)setupTool {
    
}

- (void)setupData {
    
}


#pragma mark --------- 全部商品 ------------------
- (void)creatTotalButton {
    self.totalButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.totalButton setBackgroundImage:[UIImage imageNamed:@"fq_gwd"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.totalButton];
    [self.totalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(12);
        make.width.height.mas_equalTo(60);
    }];
    [self.totalButton addTarget:self action:@selector(totalAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)totalAction:(UIButton *)button {
    CMProductViewController *vc = [CMProductViewController new];
    vc.modelArray = self.media.goodsList;
    CGRect rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 420, [UIScreen mainScreen].bounds.size.width, 420);
    SheetPresentVC(vc, rect);
}

#pragma mark --------- 查看评论 --------------
- (void)creatCommonButton {
    self.commentButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.commentButton setImage:[UIImage imageNamed:@"fq_message"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.commentButton];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalButton);
        make.right.mas_equalTo(-100);
        make.width.height.mas_equalTo(30);
    }];
    [self.commentButton addTarget:self action:@selector(commonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)commonAction:(UIButton *)button {
    CMCommentViewController *vc = [CMCommentViewController new];
    vc.targeID = self.media.id;
    CGRect rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 420, [UIScreen mainScreen].bounds.size.width, 420);
    SheetPresentVC(vc, rect);
}

#pragma mark --------- 点赞 --------------
- (void)creatLikeButton {
    self.likeButton = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    
    if (self.media.isLike) {
        [self.likeButton setImage:[UIImage imageNamed:@"fq_gz"] forState:(UIControlStateNormal)];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"fq_heart"] forState:(UIControlStateNormal)];
    }
    [self.view addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalButton);
        make.right.mas_equalTo(-16);
        make.width.height.mas_equalTo(30);
    }];
    [self.likeButton addTarget:self action:@selector(likeAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)likeAction:(UIButton *)button {
    MJWeakSelf;
    if (self.media.isLike) {
        CircleCollectionAPI *network = [[CircleCollectionAPI alloc] initWithTargetID:self.media.id type:@"1" classify:@"2"];
        [network startWithCompletionBlockWithSuccess:^(__kindof CircleCollectionAPI * _Nonnull request) {
            if ([request isValidRequestData]) {
                weakSelf.media.isLike = NO;
                [weakSelf.likeButton setImage:[UIImage imageNamed:@"fq_heart"] forState:(UIControlStateNormal)];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    } else {
        CircleCollectionAPI *network = [[CircleCollectionAPI alloc] initWithTargetID:self.media.id type:@"1" classify:@"2"];
        [network startWithCompletionBlockWithSuccess:^(__kindof CircleCollectionAPI * _Nonnull request) {
            if ([request isValidRequestData]) {
                weakSelf.media.isLike = YES;
                [weakSelf.likeButton setImage:[UIImage imageNamed:@"fq_gz"] forState:(UIControlStateNormal)];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
    
}

@end
