//
//  CMHomeViewController.m
//  YunXiaoZhi
//
//  Created by ShengChang on 2019/11/19.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "CMHomeViewController.h"
#import "CMVideoPageViewController.h"
#import "CMImageTextViewController.h"

@interface CMHomeViewController ()

@end

@implementation CMHomeViewController

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.selectIndex == 0) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 18;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.titleColorSelected = UIColorFromHex(#FFFFFF);
        self.titleColorNormal = UIColorFromHex(#666666);
        self.scrollEnable = NO;
        self.view.backgroundColor = UIColorFromHex(#060606);
    }
    return self;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"推荐";
    } else {
        return @"关注";
    }
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    if (index == 0) {
        CMVideoPageViewController *circle = [[[CMVideoPageViewController class] alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(UIPageViewControllerNavigationOrientationVertical) options:nil];
        return circle;
    } else {
        return [CMImageTextViewController new];
    }
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return  CGRectMake(0, StatusBarHeight(), kScreenWidth, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, StatusBarHeight() + 44, kScreenWidth, self.view.frame.size.height - 44 - StatusBarHeight());
}

- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
    if (index != currentIndex) {
        if (index == 0) {
            self.view.backgroundColor = UIColorFromHex(#060606);
//            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [self setNeedsStatusBarAppearanceUpdate];
        }
        
        if (index == 1) {
            self.view.backgroundColor = UIColorFromHex(#FFFFFF);
//            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    if (index == 0) {
        //        self.titleColorSelected = UIColorFromHex(#FFFFFF);
        //        self.titleColorNormal = UIColorFromHex(#666666);
        if (state == WMMenuItemStateNormal) {
            return UIColorFromHex(#666666);
        }
        if (state == WMMenuItemStateSelected) {
            return UIColorFromHex(#FFFFFF);
        }
        
    } else {
        
        if (state == WMMenuItemStateNormal) {
            return UIColorFromHex(#999999);
        }
        if (state == WMMenuItemStateSelected) {
            return UIColorFromHex(#000000);
        }
    }
    return [UIColor orangeColor];
}


@end
