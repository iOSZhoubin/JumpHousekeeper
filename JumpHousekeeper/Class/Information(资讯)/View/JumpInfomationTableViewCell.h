//
//  JumpInfomationTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpInformationModel.h"

@interface JumpInfomationTableViewCell : UITableViewCell

/**
 * 刷新视图
 * @model  模型
 */
-(void)refreshWithModel:(JumpInformationModel *)model;

@end
