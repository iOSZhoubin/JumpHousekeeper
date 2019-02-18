//
//  JumpInfomationTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "JumpInfomationTableViewCell.h"
#import "UIImageView+WebCache.h"

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





-(void)refreshWithModel:(JumpInformationModel *)model{
    
    self.titleName.text = SafeString(model.title);
    
    self.content.text = @"西安交大捷普网络科技有限公司";
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageBaseUrl,model.img]]
                      placeholderImage:[UIImage imageNamed:@"photo3"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 
                             }];
 
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
