//
//  JumpTypeModel.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/30.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JumpTypeModel : NSObject

//名称
@property (copy,nonatomic) NSString *cname;
//标题ID
@property (copy,nonatomic) NSString *fid;
//标题
@property (copy,nonatomic) NSString *fname;
//0-否 1-是
@property (copy,nonatomic) NSString *showchart;


@end
