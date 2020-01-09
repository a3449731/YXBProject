//
//  SPPDWebView.m
//  MyProject
//
//  Created by 杨 on 9/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "SPPDWebView.h"
#import <WebKit/WebKit.h>
#import <MJRefresh/MJRefresh.h>

@interface SPPDWebView () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic , strong) WKWebView *webView;
@property (nonatomic , assign) CGFloat height;

@end

@implementation SPPDWebView

- (void)creatAll {
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self craetScrollView];
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.webView);
    }];
}

- (void)setupTool {
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    NSString *result = HTMLStringWithXMLString(@"<b>所谓的噶啥的的发表<img src=\"http://attach.bbs.miui.com/forum/201304/25/195151szk8umd8or8fmfa5.jpg\" alt=\"\"></b>");
    [self.webView loadHTMLString:result baseURL:nil];
}

- (void)craetScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }

    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(self.scrollView);
    }];
}


#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJWeakSelf;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:SPProductDetailJumpNotification object:SPProductDetailProduct];
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
    [header setTitle:@"上拉返回商品详情" forState:(MJRefreshStateIdle)];
    [header setTitle:@"上拉返回商品详情" forState:(MJRefreshStatePulling)];
    [header setTitle:@"前往商品详情" forState:(MJRefreshStateRefreshing)];
    self.scrollView.mj_header = header;
}

- (void)creatMJ_footer {
    
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 15;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        //        //以下代码适配大小
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        config.userContentController = wkUController;

        _webView = [[WKWebView alloc]initWithFrame:self.bounds configuration:config];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.UIDelegate =self;
        _webView.navigationDelegate = self;
        // 此处因为高度自适应所以不应该让webview内部可以滚动
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

// 页面加载完成之后调用 此方法会调用多次
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    MJWeakSelf;
    __block CGFloat webViewHeight;
    [webView evaluateJavaScript:@"document.body.scrollHeight"
              completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        webViewHeight = [result doubleValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.webView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(webViewHeight);
            }];
        });
    }];
}

@end
