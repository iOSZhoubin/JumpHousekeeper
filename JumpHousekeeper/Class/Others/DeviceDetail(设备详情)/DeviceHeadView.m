//
//  DeviceHeadView.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/25.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "DeviceHeadView.h"
#import "myWkWebView.h"

@interface DeviceHeadView()<WKNavigationDelegate,WKUIDelegate>

//cpu外层view
@property (weak, nonatomic) IBOutlet UIView *cpuView;
//内存外层view
@property (weak, nonatomic) IBOutlet UIView *memoryView;
//图表view
@property (weak, nonatomic) IBOutlet myWkWebView *echartView;
//cpu
@property (weak, nonatomic) IBOutlet UILabel *cpuLabel;
//内存
@property (weak, nonatomic) IBOutlet UILabel *memoryLabel;

@property (strong,nonatomic) NSMutableArray *xArray;
@property (strong,nonatomic) NSMutableArray *yArray;

@end

@implementation DeviceHeadView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}




-(void)creatUI{
    
    [SVPShow show];
    
    //设置圆环
    self.cpuLabel.layer.cornerRadius =  self.cpuLabel.size.width/2;
    self.cpuLabel.layer.borderWidth = 3;
    self.cpuLabel.layer.borderColor = Customershallow.CGColor;
    self.cpuLabel.text = @"80%";
    
    self.memoryLabel.layer.cornerRadius =  self.memoryLabel.size.width/2;
    self.memoryLabel.layer.borderWidth = 3;
    self.memoryLabel.layer.borderColor = Customershallow.CGColor;
    self.memoryLabel.text = @"80%";
    
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
    
    NSArray *array = self.xArray;
    NSArray *data = self.yArray;
    
    NSDictionary *xAxis = @{@"boundaryGap":@false,@"type":@"category",@"data":array};
    
    NSDictionary *yAxis = @{@"type":@"value",@"splitNumber":@3};
    
    NSArray *dataZoom = @[@{@"startValue":@"00:00"},@{@"type":@"inside"}];
    
    NSDictionary *tooltip = @{@"show":@true};
    
    NSArray *series = @[@{
                            @"data":data,
                            @"type":@"line"
                            }];
    
    
    
    NSDictionary *option = @{
                             @"xAxis":xAxis,
                             @"yAxis":yAxis,
                             @"series":series,
                             @"tooltip":tooltip,
                             @"dataZoom":dataZoom
                             
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


#pragma mark --- 设备详情

-(void)deviceDetailWitdId:(NSString *)deviceId{
    
    L2CWeakSelf(self);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"m"] = @"2";
    parameters[@"t"] = @"8";
    parameters[@"d"] = SafeString(deviceId);
    
    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
        
        [weakself creatUI];

        NSArray *array = responseObject[@"result"];
        
        self.xArray = [NSMutableArray array];
        self.yArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            NSString *xStr = dict[@"t"];
            NSString *yStr = dict[@"t2"];
            [self.xArray addObject:xStr];
            [self.yArray addObject:yStr];
        }
        
        [self.echartView reload];
        
    } faliure:^(id error) {
       
        [SVPShow showFailureWithMessage:@"图表获取失败"];
        
    }];
}

@end
