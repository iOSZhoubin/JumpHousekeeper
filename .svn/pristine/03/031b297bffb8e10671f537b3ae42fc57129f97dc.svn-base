//
//  JumpNoticeTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/4/10.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpNoticeTableViewCell.h"

@interface JumpNoticeTableViewCell()
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeL;
//内容
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation JumpNoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshWithDict:(NSDictionary *)dict{
    
    self.timeL.text = SafeString(dict[@"time"]);
    self.contentL.text = SafeString(dict[@"content"]);

}

@end
