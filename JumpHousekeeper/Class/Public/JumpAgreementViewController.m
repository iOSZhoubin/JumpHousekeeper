//
//  JumpAgreementViewController.m
//  Jump
//
//  Created by jumpapp1 on 2019/1/2.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "JumpAgreementViewController.h"
#import "myWkWebView.h"


@interface JumpAgreementViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (strong,nonatomic) WKWebView *webView;

@property (nonatomic,strong) UIView *progressLine;

@end

@implementation JumpAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = SafeString(self.titleName);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatWebView];
}

-(void)creatWebView{
    
    //初始化webView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    self.webView = [[WKWebView alloc]init];
    
    self.webView.frame = CGRectMake(0, 0, kWidth, kHeight-L2C_StatusBarAndNavigationBarHeight);
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];
    
    
    NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.webView loadRequest:requ];
    
    
    //添加进度条
    self.progressLine = [[UIView alloc] initWithFrame:CGRectMake(0, L2C_StatusBarAndNavigationBarHeight, 0, 2)];
    
    self.progressLine.backgroundColor = CustomerBlue;
    
    [self.view addSubview:self.progressLine];
    
    [UIView animateWithDuration:2 animations:^{
        
        self.progressLine.width = kWidth-20;
    }];
    
}



/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.progressLine.width = kWidth;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [self.progressLine removeFromSuperview];
        }
    }];
}


@end
