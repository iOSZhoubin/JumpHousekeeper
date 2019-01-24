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
    
    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photo:)];
    
    self.navigationItem.rightBarButtonItem = photoItem;

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
    
    [_codeManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
        
        ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
        
        vc.type = @"1";
        
        vc.deviceStr = SafeString(code);
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [weakself.navigationController pushViewController:vc animated:YES];

    }];
}


#pragma mark - 直接扫描的二维码

- (void)startScanning {
    
    L2CWeakSelf(self);
    
    [_codeManager startScanningWithCallback:^(NSString * _Nonnull code) {
        
        ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
        
        vc.deviceStr = SafeString(code);
        
        vc.type = @"1";
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [weakself.navigationController pushViewController:vc animated:YES];
        
    } autoStop:YES];
}

@end
