//
//  AccountDetailTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpAccountDetailModel.h"

@interface AccountDetailTableViewCell : UITableViewCell
/**
 * 账户信息刷新方法
 * @indexPath 索引
 * @model 模型
 */
-(void)refreshWithModel:(JumpAccountDetailModel *)model indexPath:(NSIndexPath *)indexPath;



/**
 * 配置向导和常见问题刷新方法
 * @indexPath 索引
 */
-(void)refreshWithindexPath:(NSIndexPath *)indexPath;

@end
