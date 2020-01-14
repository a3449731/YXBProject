//
//  SPBannerHeaderView.m
//  MyProject
//
//  Created by 杨 on 4/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPBannerHeaderView.h"
#import <PYSearch/PYSearch.h>
#import <UIView+QMUI.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "YXBNavigationController.h"
#import "SPSearchReulstViewController.h"

@interface SPBannerHeaderView ()

@property(nonatomic, strong) UIButton *searchButton;

@end

@implementation SPBannerHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.searchButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"sy_search_bg"] forState:(UIControlStateNormal)];
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    [self.searchButton addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)searchAction:(UIButton *)button {
    
    // 为了搜索页面禁用IQKeyboard. (与pysearch冲突)
    [[IQKeyboardManager sharedManager] setEnable:NO];
 
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索商品"];

    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    
    // 自定义结果页面
    searchViewController.searchResultController = [[SPSearchReulstViewController alloc] init];
    searchViewController.searchResultShowMode = PYSearchResultShowModeEmbed;
    // 在返回时,仍然显示结果页,配合PYSearchResultShowModeEmbed使用。
    searchViewController.showSearchResultWhenSearchBarRefocused = YES;
    // 在搜索文本变化时,也显示结果页面
    searchViewController.showSearchResultWhenSearchTextChanged = YES;
    
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    [self.qmui_viewController.navigationController pushViewController:searchViewController animated:YES];
    
    // 热搜
    searchViewController.hotSearches = @[@"1111",@"333333333",@"5555555555555"];
    /*
    HotSearchAPI *network = [[HotSearchAPI alloc] initWithPageNum:@"1" pageSize:@"15"];
    [network startWithCompletionBlockWithSuccess:^(__kindof HotSearchAPI * _Nonnull request) {
        NSArray *hotsearchArray = [request jsonForModel];
        if (hotsearchArray.count) {
            searchViewController.hotSearches = [NSArray getPropertyArrayWithString:@"searchKey" inTheArray:hotsearchArray];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    */
}

@end



