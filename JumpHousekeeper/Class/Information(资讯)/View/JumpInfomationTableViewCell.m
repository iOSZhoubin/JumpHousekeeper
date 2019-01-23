//
//  JumpInfomationTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpInfomationTableViewCell.h"

@interface JumpInfomationTableViewCell()
//名称
@property (weak, nonatomic) IBOutlet UILabel *titleName;
//内容
@property (weak, nonatomic) IBOutlet UILabel *content;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end


@implementation JumpInfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)refreshTitle:(NSString *)titleName contentStr:(NSString *)contentStr image:(NSString *)image{
    
    self.titleName.text = SafeString(titleName);
    self.content.text = SafeString(contentStr);
    self.photoView.image = [UIImage imageNamed:image];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
