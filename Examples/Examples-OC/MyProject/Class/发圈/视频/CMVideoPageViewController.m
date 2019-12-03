//
//  CMVideoPageViewController.m
//  MyProject
//
//  Created by ShengChang on 2019/11/17.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMVideoPageViewController.h"
#import "SelVideoAPI.h"
#import "CMVideoViewController.h"

#pragma mark ----- 界面逻辑 ------------
// 1.通过数据请求，在reloadController方法中,重置当前控制器
// 2.由于当前控制器被重置，滑动时触发代理viewControllerBeforeViewController，viewControllerAfterViewController。
// 在代理中，根据当前控制器所赋予的model来寻找对应index, 从而确定前一个控制器，后一个控制器
// 3.通过代理willTransitionToViewControllers 预加载更多数据, 配合page,与hasMoreData使用

@interface CMVideoPageViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray<CMVideoModel *> *modelArray;
// 为了记录到哪一条数据了， 在刷新当前控制器中使用
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *page;
@property (nonatomic, assign) BOOL hasMoreData; // 用来判断是否有更多数据

@end

@implementation CMVideoPageViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    
}

- (void)setupTool {
    self.delegate = self;
    self.dataSource = self;
}

- (void)setupData {
    self.page = @"1";
    self.modelArray = [NSMutableArray array];
    [self requestVideoData];
}

- (void)requestVideoData {
    MJWeakSelf
    SelVideoAPI *network = [[SelVideoAPI alloc] initWithType:(CMSelCircleVideo) page:self.page limit:@"10"];
    [network startWithCompletionBlockWithSuccess:^(__kindof SelVideoAPI * _Nonnull request) {
        
        NSArray *array = [request jsonForVideoModel];
        [weakSelf.modelArray addObjectsFromArray:array];
        [weakSelf reloadController];
        
        // 判断是否有更多数据,避免无谓请求
        if (array.count > 0) {
            weakSelf.hasMoreData = YES;
        } else {
            weakSelf.hasMoreData = NO;
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark --------- 重置当前的控制器 ------------------
- (void)reloadController {
    if (self.modelArray.count) {
        CMVideoViewController* playerController = [[CMVideoViewController alloc] init];
        if (self.index < self.modelArray.count) {
            playerController.media = [self.modelArray objectAtIndex:self.index];
        } else {
            playerController.media = [self.modelArray firstObject];
            self.index = 0;
        }

        [self setViewControllers:@[playerController] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:^(BOOL finished) {
        }];
    } else {

    }
}

#pragma mark ------------ 前一个控制器  ----------------
// 利用当前控制器（viewController）寻找下标
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[CMVideoViewController class]]) return nil;
    
    NSInteger index = [self.modelArray indexOfObject:[(CMVideoViewController *)viewController media]];
    if (NSNotFound == index) return nil;

    index --;
    if (index < 0) return nil;
    
    CMVideoViewController* playerController = [[CMVideoViewController alloc] init];
    playerController.media = [self.modelArray objectAtIndex:index];
    self.index = index;
    
    return playerController;
}

#pragma mark ---------- 后一个控制器 ---------------
// 利用当前控制器（viewController）寻找下标
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[CMVideoViewController class]]) return nil;
    
    NSInteger index = [self.modelArray indexOfObject:[(CMVideoViewController *)viewController media]];
    if (NSNotFound == index) return nil;

    index ++;

    if (self.modelArray.count > index) {
        CMVideoViewController* playerController = [[CMVideoViewController alloc] init];
        playerController.media = [self.modelArray objectAtIndex:index];
        self.index = index;
        return playerController;
    }
    return nil;
}

#pragma mark ------- 将要转换控制器 （滑动时会触发,reload时也会触发）-------------------
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    // 当数据不足3条的时候,请求下一页数据. 且要满足有更多数据存在
    NSInteger index = [self.modelArray indexOfObject:[(CMVideoViewController *)pendingViewControllers.firstObject media]];
    if (index > self.modelArray.count - 3 && self.modelArray.count > 2 && self.hasMoreData) {
        self.page = [NSString stringWithFormat:@"%ld",[self.page integerValue] + 1];
        [self requestVideoData];
    }
    
    NSLog(@"%@", [NSString stringWithFormat:@"willTransition index = %ld",index]);
}

@end
