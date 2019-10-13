//
//  SelectImageTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/22.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SelectImageTableViewCell.h"

@interface SelectImageTableViewCell()
//附件图片
@property (weak, nonatomic) IBOutlet UIImageView *fileImageView;
//附件标题
@property (weak, nonatomic) IBOutlet UILabel *fileTitle;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *fileTime;

@end

@implementation SelectImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshFileList:(NSDictionary *)muDict{
    
    self.fileImageView.image = muDict[@"newImage"];
    
    self.fileTitle.text = muDict[@"fileName"];

    self.fileTime.text = muDict[@"createTime"];
}



@end
