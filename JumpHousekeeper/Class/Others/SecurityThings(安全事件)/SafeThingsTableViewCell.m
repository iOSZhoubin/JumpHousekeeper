//
//  SafeThingsTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/20.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SafeThingsTableViewCell.h"

@interface SafeThingsTableViewCell( )
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeL;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleL;
//描述
@property (weak, nonatomic) IBOutlet UILabel *remarkL;

@end

@implementation SafeThingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshWithSafeModel:(SafeThingsModel *)model{
    
    self.timeL.text = [self timestampToString:[model.logtime integerValue]];
    
    self.titleL.text = model.title;
    
    self.remarkL.text = model.fdesc;
    
    
}


//时间戳专为字符串
-(NSString *)timestampToString:(NSInteger)timestamp{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    
    return string;
    
}


@end
