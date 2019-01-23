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
    
    NSArray *array1 = @[@{@"title":@"账户信息",@"image":@"accountImage"}];
    NSArray *array2 = @[
                          @{@"title":@"我的收藏",@"image":@"collectionImage"},
                          @{@"title":@"关于我们",@"image":@"aboutimage"},
                          @{@"title":@"意见反馈",@"image":@"feedback"}
                        ];
    NSArray *array3 = @[@{@"title":@"清除缓存",@"image":@"cleanImage"}];
    NSArray *array4 = @[@{@"title":@"修改密码",@"image":@"changepassword"}];

    NSArray *sumArray = @[array1,array2,array3,array4];
    
    self.title.text = SafeString(sumArray[indexPath.section][indexPath.row][@"title"]);
    
    NSString *imgeName = SafeString(sumArray[indexPath.section][indexPath.row][@"image"]);
    
    self.imageView.image = [UIImage imageNamed:imgeName];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
