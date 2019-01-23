//
//  JumpBaseTabBarViewController.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/16.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import "JumpBaseTabBarViewController.h"
#import "JumpInformationViewController.h"
#import "JumpDeviceTableViewController.h"
#import "JumpSupportViewController.h"
#import "JumpMineTableViewController.h"


@interface JumpBaseTabBarViewController ()

@end

@implementation JumpBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTabBar];

}


-(void)setTabBar{
    
    
    //设置统一样式UI_APPEARANCE_SELECTOR
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = dict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    
    //添加子控制器
    
    JumpInformationViewController *vc1 = [[JumpInformationViewController alloc]init];

    [self setVc:vc1 title:@"资讯" image:@"information" selectImage:@"infomationSelect"];
    
    JumpDeviceTableViewController *vc2 = [[JumpDeviceTableViewController alloc]init];

    [self setVc:vc2 title:@"设备管理" image:@"deviceDefault" selectImage:@"deviceSelect"];
    
    JumpSupportViewController *vc3 = [[JumpSupportViewController alloc]init];
    
    [self setVc:vc3 title:@"一键支持" image:@"supportImage" selectImage:@"supportSelect"];
    
    JumpMineTableViewController *vc4 = [[JumpMineTableViewController alloc]init];
    
    [self setVc:vc4 title:@"我的" image:@"accountImage" selectImage:@"accountSelect"];
  
}



/**
 添加子控制器

 @param vc 控制器
 @param title 控制器title
 @param image 展示图片
 @param selectImage 选择后的图片
 */
-(void)setVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *images = [UIImage imageNamed:selectImage];
    images = [images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = images;
    [self addChildViewController:nav];
    
}


@end
