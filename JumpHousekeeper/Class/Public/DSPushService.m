//
//  DSPushService.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/4/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "DSPushService.h"
#import <UserNotifications/UserNotifications.h>


@implementation DSPushService


#pragma mark - lifeCycle
- (instancetype)init{
    if (self = [super init]) {
        //code here...
    }
    return self;
}
+ (instancetype)defaultPushService{
    static DSPushService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc]init];
    });
    return instance;
}

#pragma mark - 注册和授权
- (BOOL)DSPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0f) {
        //iOS10-
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            //判断
        }];
    }else if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f){
        //iOS8-iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }else{
        //iOS8以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    // 注册远程推送通知 (获取DeviceToken)
    [application registerForRemoteNotifications];
    
    //这个是应用未启动但是通过点击通知的横幅来启动应用的时候
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo != nil) {
        //如果有值，说明是通过远程推送来启动的
        //code here...
    }
    
    return YES;
}

//处理从后台到前台后的角标处理
-(void) DSBecomeActive:(UIApplication *)application{
    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber = 0;
    }
}

#pragma mark - 远程推送的注册结果的相关方法
//成功
- (void)DSPushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //获取设备相关信息
   
    
    
    //获取用户的通知设置状态
   
    
    //获取设备的UUID
   
    
    
    
    NSString *deviceTokenString = [[[[deviceToken description]
                                     stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                    stringByReplacingOccurrencesOfString:@">" withString:@""]
                                   stringByReplacingOccurrencesOfString: @" " withString: @""];


    //打印值看一下，是否正确，当然打印的可以用一个宏判断一下
    NSLog(@"😊😊%@", deviceTokenString);
  
    NSURL *url = [NSURL URLWithString:@"http://app.jump.net.cn:8000/app/iosapi.php"];
    if (!url) {
        NSLog(@"传入的URL为空或者有非法字符,请检查参数");
        return;
    }
    NSLog(@"%@",url);
    
    //发送异步请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setTimeoutInterval:5.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 && data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if (dict && [dict[@"ret"] integerValue] == 0) {
                    NSLog(@"上传deviceToken成功！deviceToken dict = %@",dict);
                }else{
                    NSLog(@"返回ret = %zd, msg = %@",[dict[@"ret"] integerValue],dict[@"msg"]);
                }
            }else if (error) {
                NSLog(@"请求失败，error = %@",error);
            }
        });
    }];
    [task resume];
}

//失败
- (void)DSPushApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册推送失败，error = %@", error);
    //failed fix code here...
}

#pragma mark - 收到远程推送通知的相关方法

//iOS7及以上
- (void)DSPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"%@", userInfo);
    
    
    //注意HomeScreen上一经弹出推送系统就会给App的applicationIconBadgeNumber设为对应值
    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber = 0;
    }
    
    
    
    NSLog(@"remote notification: %@",[userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert: %@", alert);
    NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push Sound: %@", sound);
    NSString *badge = [apsInfo objectForKey:@"badge"];
    NSLog(@"Received Push Badge: %@", badge);
    
    //处理customInfo
    if ([userInfo objectForKey:@"custom"] != nil) {
        //custom handle code here...
    }
    completionHandler(UIBackgroundFetchResultNoData);
}


@end
