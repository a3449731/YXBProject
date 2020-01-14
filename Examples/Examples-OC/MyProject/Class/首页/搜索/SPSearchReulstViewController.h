//
//  SPSearchReulstViewController.h
//  MyProject
//
//  Created by 杨 on 13/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPSearchReulstViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

// 如何使用pysearch。
// pod 'PYSearch', '~> 0.9.1'

// #import <PYSearch/PYSearch.h>
// #import "HotSearchAPI.h"
// #import "NSArray+YXBAdd.h"
// #import "SPSearchReulstViewController.h"

/*
 - (void)searchAction:(UIButton *)button {
  
    // **** 重要:跳转搜索之前禁用iqkeyboard **** //
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
     HotSearchAPI *network = [[HotSearchAPI alloc] initWithPageNum:@"1" pageSize:@"15"];
     [network startWithCompletionBlockWithSuccess:^(__kindof HotSearchAPI * _Nonnull request) {
         NSArray *hotsearchArray = [request jsonForModel];
         if (hotsearchArray.count) {
             searchViewController.hotSearches = [NSArray getPropertyArrayWithString:@"searchKey" inTheArray:hotsearchArray];
         }
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         
     }];
     
 }
 */

