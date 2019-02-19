//
//  JumpTypeTableViewController.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/24.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpBaseTableViewController.h"

typedef void(^SureBlock)(NSDictionary *selectDict);

@interface JumpTypeTableViewController : JumpBaseTableViewController

/** 回调 block */
@property (copy,nonatomic) SureBlock block;

@end
