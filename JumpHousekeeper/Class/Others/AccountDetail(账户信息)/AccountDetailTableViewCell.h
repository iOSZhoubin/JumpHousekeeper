//
//  AccountDetailTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpAccountDetailModel.h"


@class AccountDetailTableViewCell;

@protocol OpinionTextDelegate <NSObject>

@optional

-(void)contentDetail:(NSString *)content andCell:(AccountDetailTableViewCell *)cell;

@end


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


/**
 * 意见反馈刷新方法
 * @contentDict 存储内容的字典
 * @indexPath 索引
 */
-(void)refreshOpinionWithContent:(NSMutableDictionary *)contentDict indexPath:(NSIndexPath *)indexPath;


@property (weak,nonatomic) id<OpinionTextDelegate> delegate;

@end
