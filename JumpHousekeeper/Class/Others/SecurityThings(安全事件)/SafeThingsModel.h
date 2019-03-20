//
//  SafeThingsModel.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/20.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeThingsModel : NSObject

//类型
@property (copy,nonatomic) NSString *ftype;
//id
@property (copy,nonatomic) NSString *fid;
//标题
@property (copy,nonatomic) NSString *title;
//描述
@property (copy,nonatomic) NSString *fdesc;
//时长
@property (copy,nonatomic) NSString *logtime;

@end

NS_ASSUME_NONNULL_END
