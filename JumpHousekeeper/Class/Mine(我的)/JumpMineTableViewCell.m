//
//  JumpMineTableViewCell.m
//  Jump
//
//  Created by jumpapp1 on 2019/1/3.
//  Copyright © 2019年 zb. All rights reserved.
//

#import "JumpMineTableViewCell.h"

@interface JumpMineTableViewCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//名称
@property (weak, nonatomic) IBOutlet UILabel *title;
//箭头
@property (weak, nonatomic) IBOutlet UIImageView *pushArrow;

@end

@implementation JumpMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshWithIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *titleArray = @[@"账户信息",@"设备列表",@"我的收藏",@"关于我们",@"意见反馈",@"清除缓存",@"修改密码"];
    NSArray *imageArray = @[@"accountImage",@"device1",@"collectionImage",@"aboutimage",@"feedback",@"cleanImage",@"changepassword"];
        
    self.title.text = titleArray[indexPath.row];
    self.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
