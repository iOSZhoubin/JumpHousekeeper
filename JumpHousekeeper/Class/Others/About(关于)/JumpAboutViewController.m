//
//  JumpAboutViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpAboutViewController.h"

@interface JumpAboutViewController ()
//距上
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
//版权
@property (weak, nonatomic) IBOutlet UILabel *copyrightL;

@end

@implementation JumpAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"关于我们";
    
    self.topH.constant = L2C_StatusBarAndNavigationBarHeight;
    
    //获取当前时间的年
    
    NSDate *date =[NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    
    self.copyrightL.text = [NSString stringWithFormat:@"Copyright©1999-%d.ALL Rights Reserved.",currentYear];

}



@end
