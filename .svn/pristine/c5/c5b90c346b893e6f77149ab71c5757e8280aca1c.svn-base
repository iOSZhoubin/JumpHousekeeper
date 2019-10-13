//
//  SVPShow.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/13.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import "SVPShow.h"
#import "SVProgressHUD.h"
//#import "UIImage+GIF.h"

static CGFloat svpTime = 1.5;

static UIView *gifView;

@implementation SVPShow

+ (void)show {
//    [SVProgressHUD dismiss];
//    [self makeView];
//    [self showGIF];
    
    [self setStyle];
    [SVProgressHUD show];
}


+ (void)setStyle{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:ColorA(0, 0, 0,0.8 * 255)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

+ (void)disMiss {
    
//    [self dismissGIF];
    [SVProgressHUD dismiss];
    
}

+ (void)showSuccessWithMessage:(NSString *)messgae {
    
//    [self dismissGIF];
    [self setStyle];
    
    [SVProgressHUD showSuccessWithStatus:messgae];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

+ (void)showFailureWithMessage:(NSString *)message {
    
//    [self dismissGIF];

    [self setStyle];
    [SVProgressHUD showErrorWithStatus:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

+ (void)showInfoWithMessage:(NSString *)message {
//    [self dismissGIF];

    [self setStyle];
    [SVProgressHUD showInfoWithStatus:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

//+ (void)makeView{
//    if (!gifView) {
//        UIImageView *imageView;
//        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 60, 60)];
//
//        imageView.center = KeyWindow.center;
//        imageView.backgroundColor = [UIColor clearColor];
//        imageView.alpha = 0.95;
//
//        imageView.image = [UIImage sd_animatedGIFNamed:@"Logining3"];
//
//        gifView = imageView;
//    }
//}

+ (void)showGIF {
    [KeyWindow addSubview:gifView];
}

+ (void)dismissGIF{
    UIView *view = gifView;
    
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        view.alpha = 0.95;
    }];
    
}

@end
