//
//  MainTabBarController.m
//  CYLTabBarController
//
//  Created by YangXiaoBin on 2019/11/11.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//
#import "TabBarViewController.h"
#import <UIKit/UIKit.h>
#import "YXBNavigationController.h"
#import "SPHomeViewController.h"
#import "MemberViewController.h"
#import "CMHomeViewController.h"
#import "PSHomeViewController.h"
#import "CTHomeViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray *vcArray;
@property (nonatomic, strong) NSMutableArray *configArray;

@end

@implementation TabBarViewController

- (instancetype)init {
    self = [self configData];
    if (self) {
        self.delegate = self;
        [UITabBar appearance].translucent = NO;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (instancetype)configData {
    self.vcArray = [NSMutableArray array];
    self.configArray = [NSMutableArray array];
    [self configFirstVC];
    [self configSecondVC];
    [self configThiredVC];
    [self configFourthVC];
    [self configFifthVC];
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    return [super initWithViewControllers:self.vcArray tabBarItemsAttributes:self.configArray imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];    
}

- (void)configFirstVC {
    UIViewController *vc = [[SPHomeViewController alloc] init];
    UINavigationController *nav = [[CYLBaseNavigationController alloc]
                             initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"home_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}

- (void)configSecondVC {
    UIViewController *vc = [[CMHomeViewController alloc] init];
    UINavigationController *nav = [[CYLBaseNavigationController alloc]
                             initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"发圈",
        CYLTabBarItemImage : @"gray_tabbar_message_animation_lottie_placeholder",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"message_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}

- (void)configThiredVC {
    UIViewController *vc = [[CTHomeViewController alloc] init];
    UINavigationController *nav = [[YXBNavigationController alloc]
                             initWithRootViewController:vc];
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"home_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}

- (void)configFifthVC {
    UIViewController *vc = [[MemberViewController alloc] init];
    UINavigationController *nav = [[CYLBaseNavigationController alloc]
                             initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"会员",
        CYLTabBarItemImage : @"fishpond_normal",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"fishpond_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}

- (void)configFourthVC {
    UIViewController *vc = [[PSHomeViewController alloc] init];
    UINavigationController *nav = [[YXBNavigationController alloc]
                             initWithRootViewController:vc];
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"home_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}


/**
 *  如果想更进一步的自定义 TabBar 样式可在 -application:didFinishLaunchingWithOptions: 方法中设置
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    //     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set background color
    // 设置 TabBar 背景
    // 半透明
    //    [UITabBar appearance].translucent = YES;
    // [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
    // [[UITabBar appearance] setBackgroundColor:[UIColor cyl_systemBackgroundColor]];
    
    
    //     [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
    
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    // NO.2，using Image
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"TabBar_Bg_Shadow"]];
    // NO.1，using layer to add shadow. note:recommended. 推荐该方式，可以给PlusButton突出的部分也添加上阴影
    //    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    tabBarController.tabBar.layer.shadowRadius = 15.0;
    //    tabBarController.tabBar.layer.shadowOpacity = 0.2;
    //    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    //    tabBarController.tabBar.layer.masksToBounds = NO;
    //    tabBarController.tabBar.clipsToBounds = NO;
}

@end
