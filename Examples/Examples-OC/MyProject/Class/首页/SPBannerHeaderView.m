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

@interface SPBannerHeaderView () <PYSearchViewControllerDelegate>

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
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"bg1"] forState:(UIControlStateNormal)];
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
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        //            // eg：Push to a temp view controller
        //            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    
    searchViewController.cancelBarButtonItem.title = @"";
    [searchViewController.cancelButton setTitle:@"" forState:(UIControlStateNormal)];
    
    // 3. Set style for popular search and search history
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    
    
    // 4. Set delegate
    searchViewController.delegate = self;
    
    // 5. Present(Modal) or push search view controller
    // Present(Modal)
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //    [self presentViewController:nav animated:YES completion:nil];
    
    // Push
    // Set mode of show search view controller, default is `PYSearchViewControllerShowModeModal`
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModeModal;
    //    // Push search view controller
    [self.qmui_viewController.navigationController pushViewController:searchViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section ? NSLocalizedString(@"PYExampleTableSectionZeroTitle", @"选择搜索历史风格（热门搜索为默认风格)") : NSLocalizedString(@"PYExampleTableSectionZeroTitle", @"选择热门搜索风格（搜索历史为默认风格)");
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText {
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

@end



