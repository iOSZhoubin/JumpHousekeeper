//
//  InstrumentEchartsViewController.m
//  L2CSmartMotor
//
//  Created by feaonline on 2018/9/25.
//  Copyright © 2018年 feaonline. All rights reserved.
//

#import "JumpFirstViewController.h"
#import "myWkWebView.h"


@interface JumpFirstViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (weak, nonatomic) IBOutlet myWkWebView *wkwebView;
@property (weak, nonatomic) IBOutlet myWkWebView *wkwebView1;
@property (weak, nonatomic) IBOutlet myWkWebView *wkwebView2;
@property (weak, nonatomic) IBOutlet myWkWebView *wkwebView3;

@end

@implementation JumpFirstViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图表";
    
    [self creatUIWith:self.wkwebView];
    [self creatUIWith:self.wkwebView1];
    [self creatUIWith:self.wkwebView2];
    [self creatUIWith:self.wkwebView3];

}



-(void)creatUIWith:(myWkWebView *)wkwebView{
    
    wkwebView.layer.cornerRadius = 8;
    wkwebView.layer.masksToBounds = YES;
    wkwebView.layer.borderWidth = 1;
    wkwebView.layer.borderColor = RGB(240, 240, 240).CGColor;
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    wkwebView.UIDelegate = self;
    wkwebView.scrollView.scrollEnabled = NO;
    wkwebView.navigationDelegate = self;
    
    
    NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JumpEcharts" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *js = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"echarts.min" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    
    html = [html stringByReplacingOccurrencesOfString:@"<!--替换js-->" withString:js];
    
    [wkwebView loadHTMLString:html baseURL:nil];
   
}



/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self getview:self.wkwebView andType:@"0"];
    [self getview:self.wkwebView1 andType:@"1"];
    [self getview:self.wkwebView2 andType:@"2"];
    [self getview:self.wkwebView3 andType:@"3"];

}


-(void)getview:(myWkWebView *)wkwebView andType:(NSString *)type{
    

    if([type isEqualToString:@"0"]){
        
        NSDictionary *axisTick = @{
                                   @"length":@6,
                                   @"lineStyle":@{@"color":@"auto"}
                                   };
        
        NSDictionary *splitLine = @{
                                    @"length":@8,
                                    @"lineStyle":@{@"color":@"auto"}
                                    };
        
        NSDictionary *axisLabel = @{
                                    @"fontSize":@8,
                                    @"backgroundColor":@"auto",
                                    @"borderRadius":@2,
                                    @"color":@"#eee",
                                    @"padding":@3
                                    };
        
        NSDictionary *title = @{
                                @"fontWeight":@"bolder",
                                @"fontSize":@12,
                                @"fontStyle":@"italic"
                                };
        
        NSDictionary *detail = @{
                                 @"fontSize":@12,
                                 @"height":@12,
                                 @"width":@30,
                                 @"fontWeight":@"bolder",
                                 @"borderRadius":@3,
                                 @"backgroundColor":@"#444",
                                 @"borderColor":@"#aaa",
                                 @"shadowBlur":@5,
                                 @"shadowColor":@"#333",
                                 @"shadowOffsetX":@0,
                                 @"shadowOffsetY":@3,
                                 @"borderWidth":@2,
                                 @"textBorderColor":@"#000",
                                 @"textBorderWidth":@2,
                                 @"textShadowBlur":@2,
                                 @"textShadowColor":@"#fff",
                                 @"textShadowOffsetX":@0,
                                 @"textShadowOffsetY":@0,
                                 @"fontFamily":@"Arial",
                                 @"color":@"#eee",
                                 };
        
        NSDictionary *data =  @{@"value":@(1800),@"name":@"rpm"};
        
        NSDictionary *seriesDict = @{@"series":@[@{
                                                     @"pointer":@{@"width":@3},
                                                     @"name":@"速度",
                                                     @"type":@"gauge",
                                                     @"z":@3,
                                                     @"min":@0,
                                                     @"max":@4000,
                                                     @"splitNumber":@8,
                                                     @"radius":@"100%",
                                                     @"axisLine":@{@"lineStyle":@{@"width":@4}},
                                                     @"axisTick":axisTick,
                                                     @"splitLine":splitLine,
                                                     @"axisLabel":axisLabel,
                                                     @"title":title,
                                                     @"detail":detail,
                                                     @"axisTick":axisTick,
                                                     @"data":@[data],
                                                     }]};
        
        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",seriesDict.mj_JSONString] completionHandler:nil];

    }else if ([type isEqualToString:@"1"]){
        
        NSArray *array = @[@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"];
        NSArray *data = @[@"820",@"932",@"901",@"934",@"1290",@"1330",@"1320"];

        NSDictionary *xAxis = @{@"type":@"category",@"data":array};

        NSDictionary *yAxis = @{@"type":@"value"};

        NSArray *series = @[@{
                                @"data":data,
                                @"type":@"line"
                            }];
        
        NSDictionary *option = @{
                                 @"xAxis":xAxis,
                                 @"yAxis":yAxis,
                                 @"series":series
                                 };

        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];

    }else if ([type isEqualToString:@"2"]){
        
        NSArray *array = @[@"直接访问",@"邮件营销",@"联盟广告",@"视频广告",@"搜索引擎"];
        
        NSDictionary *legend = @{
                                 @"orient":@"vertical",
                                 @"left":@"left",
                                 @"data":array,
                                 @"height":@100,
                                 };
        
        NSArray *dataArray = @[
                               @{@"value":@"335",@"name":@"直接访问"},
                               @{@"value":@"310",@"name":@"邮件营销"},
                               @{@"value":@"234",@"name":@"联盟广告"},
                               @{@"value":@"135",@"name":@"视频广告"},
                               @{@"value":@"1548",@"name":@"搜索引擎"},
                               ];
        
        NSArray *series = @[@{
                                   @"type":@"pie",
                                   @"radius":@"55%",
//                                   @"center":@[@"50",@"60"],
                                   @"data":dataArray,
                                   }];
        
        NSDictionary *option = @{
                                 @"legend":legend,
                                 @"series":series,
                                 };
        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];

    }

    
    [SVPShow disMiss];
}


/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    //    页面加载失败重试3遍
    for (NSInteger i=0; i<3; i++) {
        
        [webView reload];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
