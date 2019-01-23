//
//  JumpInfomationTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JumpInfomationTableViewCell : UITableViewCell


/**
 * 刷新视图
 * @titleName  名称
 * @contentStr 内容
 * @image  图片
 */
-(void)refreshTitle:(NSString *)titleName contentStr:(NSString *)contentStr image:(NSString *)image;

@end
