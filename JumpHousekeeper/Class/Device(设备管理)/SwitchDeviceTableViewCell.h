//
//  SwitchDeviceTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpDeviceModel.h"


@interface SwitchDeviceTableViewCell : UITableViewCell

//刷新设备列表
-(void)refreshWithDeviceModel:(JumpDeviceModel *)model;

@end
