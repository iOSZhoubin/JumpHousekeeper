//
//  ExperienceViewController.h
//  Jump
//
//  Created by jumpapp1 on 2018/12/20.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import "JumpBaseViewController.h"

typedef void(^BackBlock)(NSString *backstr);

@interface ExperienceViewController : JumpBaseViewController

/** 页面标题 */
@property (copy,nonatomic) NSString *vcTitle;

/** 候选字 */
@property (copy, nonatomic)NSString *ploText;

/** 回调 block */
@property (copy,nonatomic) BackBlock block;

/** 内容字符 */
@property (copy,nonatomic) NSString *saveText;

/** 是否可以编辑，默认 NO */
@property (assign,nonatomic) BOOL isEnditor;

/** 内容长度限制（不传不限制输入字符）*/
@property (assign,nonatomic) NSInteger textLength;

@end
