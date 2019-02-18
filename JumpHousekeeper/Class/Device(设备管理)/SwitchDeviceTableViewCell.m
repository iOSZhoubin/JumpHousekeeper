//
//  SwitchDeviceTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SwitchDeviceTableViewCell.h"

@interface SwitchDeviceTableViewCell()
//名称
@property (weak, nonatomic) IBOutlet UILabel *titleName;
//开关按钮
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end

@implementation SwitchDeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshWithDeviceModel:(JumpDeviceModel *)model{
    
    self.titleName.text = SafeString(model.fname);
}


- (IBAction)switchAction:(UISwitch *)sender {
    
    if(sender.isOn){
        
        JumpLog(@"开关打开");
        
    }else{
       
        JumpLog(@"开关关闭");
    }
}

@end
