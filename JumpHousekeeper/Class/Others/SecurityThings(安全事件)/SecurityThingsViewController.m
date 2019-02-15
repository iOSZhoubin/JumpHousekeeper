//
//  SecurityThingsViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SecurityThingsViewController.h"
#import "myWkWebView.h"

@interface SecurityThingsViewController ()<WKNavigationDelegate,WKUIDelegate>

//图表view
@property (weak, nonatomic) IBOutlet myWkWebView *echartView;

@end

@implementation SecurityThingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"安全事件";

    [self creatUI];
}



-(void)creatUI{
    
    [SVPShow show];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    self.echartView.UIDelegate = self;
    self.echartView.scrollView.scrollEnabled = NO;
    self.echartView.navigationDelegate = self;
    
    
    NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JumpEcharts" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *js = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"echarts.min" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    
    html = [html stringByReplacingOccurrencesOfString:@"<!--替换js-->" withString:js];
    
    [self.echartView loadHTMLString:html baseURL:nil];
    
}



/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self getview:self.echartView];
    
    
}


-(void)getview:(myWkWebView *)wkwebView{
    
    
    NSArray *array = @[@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"];
    NSArray *data = @[@"820",@"932",@"901",@"934",@"1290",@"1330",@"1320"];
    
    NSDictionary *grid = @{@"left":@"3%",@"right":@"4%",@"bottom":@"3%",@"containLabel":@true};

    NSDictionary *xAxis = @{@"axisTick":@{@"alignWithLabel":@true},@"type":@"category",@"data":array,@"triggerEvent":@true};
    
    NSDictionary *yAxis = @{@"type":@"value",@"triggerEvent":@true};
    
    NSArray *series = @[@{
                            @"data":data,
                            @"type":@"bar",
                            @"barWidth":@"60%"
                            }];
    
    NSDictionary *option = @{
                             @"color":@[@"#3398DB"],
                             @"grid":grid,
                             @"xAxis":xAxis,
                             @"yAxis":yAxis,
                             @"series":series
                             };
    
    [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];
    
    [SVPShow disMiss];
}


/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    //    页面加载失败重试2遍
    for (NSInteger i=0; i<2; i++) {
        
        [webView reload];
    }
}


@end
