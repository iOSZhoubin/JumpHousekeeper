//
//  SafeThingsTableViewCell.h
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/20.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafeThingsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeThingsTableViewCell : UITableViewCell

-(void)refreshWithSafeModel:(SafeThingsModel *)model;

@end

NS_ASSUME_NONNULL_END
