//
//  SelectImageTableViewController.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/22.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpBaseTableViewController.h"

typedef void(^SelectBlock)(NSString *baseStr,NSMutableArray *dataArray);


NS_ASSUME_NONNULL_BEGIN

@interface SelectImageTableViewController : JumpBaseTableViewController

/** 回调 block */
@property (copy,nonatomic) SelectBlock block;
//附件数组
@property (strong,nonatomic) NSMutableArray *selectArray;

@end

NS_ASSUME_NONNULL_END
