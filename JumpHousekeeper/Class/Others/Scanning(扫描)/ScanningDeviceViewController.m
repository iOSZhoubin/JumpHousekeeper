//
//  ScanningDeviceViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "ScanningDeviceViewController.h"
#import "ChangePassWordViewController.h"
#import "QiCodePreviewView.h"
#import "QiCodeManager.h"

@interface ScanningDeviceViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//扫描区域view
@property (nonatomic, strong) QiCodePreviewView *previewView;

@property (nonatomic, strong) QiCodeManager *codeManager;

@end

@implementation ScanningDeviceViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_codeManager stopScanning];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}



-(void)creatUI{
    
    self.navigationItem.title = @"扫描";
    
//    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photo:)];
//
//    self.navigationItem.rightBarButtonItem = photoItem;

    //二维码界面
    _previewView = [[QiCodePreviewView alloc] initWithFrame:self.view.bounds];
    
    _previewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_previewView];
    
    L2CWeakSelf(self);
    
    _codeManager = [[QiCodeManager alloc] initWithPreviewView:_previewView completion:^{
        
        [weakself startScanning];
        
    }];
}


#pragma mark - 从相册中获取到的二维码

- (void)photo:(id)sender {
    
    L2CWeakSelf(self);

    //    检测用户是否开启了访问相册的权限
    BOOL isopen = [JumpPublicAction isopenPhoto];
    
    if(isopen){
        
        [_codeManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
            
            [weakself scanning:SafeString(code)];

        }];
        
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去开启访问相册权限?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [JumpPublicAction openfromSetting];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:cancel];
        [alertController addAction:ok];

        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - 直接扫描的二维码

- (void)startScanning {
    
    L2CWeakSelf(self);
    
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
        
        [weakself scanning:SafeString(code)];
   
    } autoStop:YES];
}

#pragma mark --- 扫描二维码获取设备状态

-(void)scanning:(NSString *)code{
    
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
    
    vc.deviceStr = SafeString(code);
    
    vc.type = self.type;
    
    vc.resultType = @"1";
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    L2CWeakSelf(self);
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    parameters[@"m"] = @"0";
//
//    if([self.type isEqualToString:@"1"]){
//
//        parameters[@"t"] = @"3";//注册传3
//
//    }else{
//
//        parameters[@"t"] = @"6";//添加设备传6
//    }
//
//    parameters[@"d"] = code;
//
//    [AFNHelper get:BaseUrl parameter:parameters success:^(id responseObject) {
//
//        if([responseObject[@"result"] isEqualToString:@"0"]){
//
//            [SVPShow showInfoWithMessage:@"未找到匹配的设备"];
//
//            [weakself startScanning];
//
//        }else if([responseObject[@"result"] isEqualToString:@"1"] || [responseObject[@"result"] isEqualToString:@"2"]){
//
//            //1-注册管理员 2-注册用户
//            ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
//
//            vc.deviceStr = SafeString(code);
//
//            vc.type = self.type;
//
//            vc.resultType = SafeString(responseObject[@"result"]);
//
//            vc.hidesBottomBarWhenPushed = YES;
//
//            [weakself.navigationController pushViewController:vc animated:YES];
//
//        }else if ([responseObject[@"result"] isEqualToString:@"3"]){
//
//            [SVPShow showInfoWithMessage:@"用户已绑定设备"];
//
//            [weakself startScanning];
//
//        }else{
//
//            [SVPShow showFailureWithMessage:@"获取设备码失败"];
//
//            [weakself startScanning];
//
//        }
//
//    } faliure:^(id error) {
//
//        [SVPShow showFailureWithMessage:@"获取设备码失败"];
//
//        [weakself startScanning];
//    }];
}


@end
