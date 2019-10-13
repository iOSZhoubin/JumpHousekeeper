//
//  JumpEchartsViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/10/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpEchartsViewController.h"
#import "myWkWebView.h"

@interface JumpEchartsViewController ()<WKNavigationDelegate,WKUIDelegate>

//图表
@property (weak, nonatomic) IBOutlet myWkWebView *echartView;

/** 叠加柱状图（监控一览） */

@property (strong,nonatomic) NSMutableArray *oneArray;
@property (strong,nonatomic) NSMutableArray *title1Array;

/** 饼状图（异常一览） */
@property (strong,nonatomic) NSMutableArray *twoArray;
@property (strong,nonatomic) NSMutableArray *title2Array;

/** 雷达图（最新安全事件） */
@property (strong,nonatomic) NSMutableArray *threeArray;
@property (strong,nonatomic) NSMutableArray *numArray;

@end

@implementation JumpEchartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if([self.type isEqualToString:@"1"]){
        
        self.navigationItem.title = @"监控一览";
        [self loadData1];

    }else if([self.type isEqualToString:@"2"]){

        self.navigationItem.title = @"异常一览";
        [self loadData2];

    }else{
        
        self.navigationItem.title = @"最新安全事件";
        [self loadData3];
    }
    
    self.view.backgroundColor = BackGroundColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    //打开横屏
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = YES;
    
    [self setNewOrientation:YES];
    
}


-(void)creatUi{
    
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


//返回只支持竖屏

- (void)backAction {
    
    [SVPShow disMiss];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    
    [self setNewOrientation:NO];
    
    if (self.navigationController.viewControllers.count>1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



/**
 横竖屏

 @param fullscreen fullscreen（YES-横屏 NO-竖屏）
 */
- (void)setNewOrientation:(BOOL)fullscreen

{
    
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}


/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if([self.type isEqualToString:@"1"]){
     
        [self echart1:self.echartView];

    }else if ([self.type isEqualToString:@"2"]){

        [self echart2:self.echartView];

    }else{

        [self echart3:self.echartView];
    }
    
    [SVPShow disMiss];
}





/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    [SVPShow disMiss];

    //    页面加载失败重试2遍
    for (NSInteger i=0; i<2; i++) {
        
        [webView reload];
    }
}


#pragma mark  --- 叠加柱状图（监控一览）


-(void)loadData1{
    
    L2CWeakSelf(self);
    
    [SVPShow show];
    
    NSString *url = [NSString stringWithFormat:@"%@?m=5&t=1&devid=%@",EchartBaseUrl,SafeString(self.deviceId)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        
        NSString *str = [data mj_JSONString];
        
        if(str.length > 50){
            
            NSDictionary *dict1 = [data mj_JSONObject];
            
            NSDictionary *dict = @{@"result":dict1};
            
            NSArray *titleA = dict[@"result"][@"categories"];
            
            NSDictionary *xDict = dict[@"result"][@"series"];
            
            NSArray *keyArray = [xDict allKeys];
            
            if(keyArray.count > 0 && titleA.count > 0){
                
                weakself.oneArray = [NSMutableArray array];
                
                weakself.title1Array = [NSMutableArray array];
                
                [weakself.title1Array addObjectsFromArray:titleA];
                
                for(NSInteger i=0;i<keyArray.count;i++){
                    
                    NSArray *numArray = dict[@"result"][@"series"][keyArray[i]];
                    
                    NSString *title = keyArray[i];
                    
                    NSDictionary *dict = @{
                                           @"title":title,
                                           @"num":numArray
                                           };
                    
                    [weakself.oneArray addObject:dict];
                }
            }
            
            [weakself creatUi];
            
        }else{
            
            [SVPShow showInfoWithMessage:@"暂无数据"];
        }
   

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        JumpLog(@"%@",error);
        [SVPShow showInfoWithMessage:@"请求服务器失败"];

    }];
    
}



-(void)echart1:(myWkWebView *)wkwebView{
    
    NSMutableArray *titleA = [NSMutableArray array];
    NSMutableArray *seriesA = [NSMutableArray array];

    for(NSInteger i=0;i<self.oneArray.count;i++){
        
        NSString *str = SafeString(self.oneArray[i][@"title"]);
        NSArray *numArray = self.oneArray[i][@"num"];
        
        NSDictionary *dict = @{
                                @"name":str,
                                @"type":@"bar",
                                @"barWidth" : @30,
                                @"stack": @"监控",
                                @"data":numArray
                                
                                };
        
        [titleA addObject:str];
        [seriesA addObject:dict];
    }
    
    
    if(self.oneArray.count > 0){
        
        NSDictionary *tooltip = @{
                                  @"trigger":@"axis",
                                  @"axisPointer":@{@"type":@"line"}
                                  };
        
        NSDictionary *legend = @{@"data":titleA};
        
        NSDictionary *grid = @{
                               @"left":@"5%",
                               @"right":@"5%",
                               @"bottom":@"8%",
                               @"left":@true
                               };
        
        NSDictionary *xDict = @{
                                @"type":@"category",
                                @"data":self.title1Array
                                };
        
        NSArray *xAxis = @[xDict];
        NSArray *yAxis = @[@{@"type":@"value"}];
        NSArray *colorArray = @[@"rgb(255,191,0)",@"red",@"rgb(0,198,106)",@"rgb(0,122,255)"];

        
        NSDictionary *option = @{
                                 @"tooltip":tooltip,
                                 @"legend":legend,
                                 @"grid":grid,
                                 @"xAxis":xAxis,
                                 @"yAxis":yAxis,
                                 @"series":seriesA,
                                 @"color":colorArray
                                 };
        
        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];
    }
}


#pragma mark  --- 饼状图（异常一览）

-(void)loadData2{
    
    [SVPShow show];

    L2CWeakSelf(self);
    
    NSString *url = [NSString stringWithFormat:@"%@?m=5&t=2&devid=%@",EchartBaseUrl,SafeString(self.deviceId)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        
        NSDictionary *dict = [data mj_JSONObject];
       
        NSString *str = [data mj_JSONString];

        weakself.twoArray = [NSMutableArray array];
        weakself.title2Array = [NSMutableArray array];

        if(str.length > 50){
            
            NSArray *array = dict[@"data"];
            
            for (NSInteger i=0; i<array.count; i++) {
                
                NSArray *dataArray = array[i];
                
                NSString *name = dataArray[0];
                NSInteger num = [dataArray[1] integerValue];
                NSNumber *nums = @(num);
                
     
                NSDictionary *dict = @{@"value":nums,@"name":name,@"itemStyle":@{@"color":@"blue"}};
                
                [weakself.title2Array addObject:name];
                [weakself.twoArray addObject:dict];

            }
            
            [weakself creatUi];

        }else{
            
            [SVPShow showInfoWithMessage:@"暂无数据"];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        JumpLog(@"%@",error);
        [SVPShow showInfoWithMessage:@"请求服务器失败"];

    }];
    
}

-(void)echart2:(myWkWebView *)wkwebView{
    
    if(self.title2Array.count > 0){
        
        NSDictionary *title = @{@"text":@"",@"subtext":@"",@"x":@"center"};
        
        NSDictionary *tooltip = @{@"trigger":@"item",@"formatter":@"{a} <br/>{b} : {c} ({d}%)"};
        
        NSArray *data = self.title2Array;
        
        NSDictionary *legend = @{@"orient":@"vertical",@"left":@"left",@"data":data};
        
        NSArray *colorArray = @[@"rgb(255,69,87)",@"rgb(208,178,71)",@"rgb(0,142,202)",@"rgb(154,195,114)",@"rgb(0,198,106)"];

        NSArray *array = self.twoArray;
        
        NSDictionary *emphasis = @{@"shadowBlur":@10,@"shadowOffsetX":@0,@"shadowColor":@"rgba(0, 0, 0, 0.5)"};
        
        NSArray *series = @[
                            @{
                                @"type":@"pie",
                                @"radius":@"55%",
                                @"center":@[@"50%",@"60%"],
                                @"data":array,
                                @"itemStyle":emphasis
                                }
                            ];
        
        
        
        
        NSDictionary *option = @{
                                 @"title":title,
                                 @"tooltip":tooltip,
                                 @"legend":legend,
                                 @"series":series,
                                 @"color":colorArray
                                 };
        
        
        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];
        
    }
}




#pragma mark  --- 雷达图（最新安全事件）

-(void)loadData3{
    
    [SVPShow show];
    
    L2CWeakSelf(self);
    
    NSString *url = [NSString stringWithFormat:@"%@?m=5&t=3&devid=%@",EchartBaseUrl,SafeString(self.deviceId)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        
        NSDictionary *dict = [data mj_JSONObject];
        
        NSString *str = [data mj_JSONString];
        
        weakself.threeArray = [NSMutableArray array];
        weakself.numArray = [NSMutableArray array];
        
        if(str.length > 50){
            
            NSArray *array = dict[@"date"];
            
            for (NSInteger i=0; i<array.count; i++) {
                
                NSArray *dataArray = array[i];
                
                NSString *name = dataArray[0];
                NSInteger num = [dataArray[1] integerValue];
                NSNumber *nums = @(num);
                
                NSInteger maxNum = num + 200;
                NSNumber *maxNums = @(maxNum);
                
                
                NSDictionary *dict = @{@"name":name,@"max":maxNums};
                
                [weakself.numArray addObject:nums];
                [weakself.threeArray addObject:dict];
                
            }
            
            [weakself creatUi];
            
        }else{
            
            [SVPShow showInfoWithMessage:@"暂无数据"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        JumpLog(@"%@",error);
        [SVPShow showInfoWithMessage:@"请求服务器失败"];
        
    }];
}

-(void)echart3:(myWkWebView *)wkwebView{
    
    if(self.threeArray.count > 0){
        
        NSDictionary *title = @{@"text":@"安全事件"};
        
        NSDictionary *tooltip = @{};
        
        NSDictionary *textStyle = @{
                                    @"color":@"#fff",
                                    @"backgroundColor":@"#999",
                                    @"borderRadius":@3,
                                    @"padding":@[@3,@5]
                                    };
        
        NSDictionary *name = @{@"name":textStyle};
        
        NSArray *indicator = self.threeArray;
        
        NSDictionary *radar = @{@"name":name,@"indicator":indicator};
        
        
        NSArray *data = @[@{
                              @"value":self.numArray
                              }];
        
        NSDictionary *lineStyle = @{@"color":@"rgb(0, 122, 255)"};
        
        NSArray *series = @[@{@"type":@"radar",@"data":data,@"lineStyle":lineStyle}];
        
        NSDictionary *option = @{
                                 @"title":title,
                                 @"tooltip":tooltip,
                                 @"radar":radar,
                                 @"series":series
                                 
                                 };
        
        [wkwebView evaluateJavaScript:[NSString stringWithFormat:@"setOP(%@)",option.mj_JSONString] completionHandler:nil];
    }
}





@end
