//
//  AccountDetailTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "AccountDetailTableViewCell.h"

@interface AccountDetailTableViewCell()

//名称
@property (weak, nonatomic) IBOutlet UILabel *titleName;
//箭头
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
//内容
@property (weak, nonatomic) IBOutlet UITextField *contentField;

@end


@implementation AccountDetailTableViewCell

-(void)refreshWithModel:(JumpAccountDetailModel *)model indexPath:(NSIndexPath *)indexPath{

    NSArray *titleArray = @[@"昵称",@"账号",@"真实姓名",@"手机号",@"邮箱",@"详细地址"];
    
    self.titleName.text = titleArray[indexPath.row];
    
    self.contentField.enabled = NO;
    
    if(indexPath.row == 5){
        
        self.arrowImage.hidden = NO;
        
    }else{
        
        self.arrowImage.hidden = YES;
    }
    
    switch (indexPath.row) {
        case 0:
            self.contentField.text = model.accountName;
            break;
        case 1:
            self.contentField.text = model.account;
            break;
        case 2:
            self.contentField.text = model.userName;
            break;
        case 3:
            self.contentField.text = model.phoneNumber;
            break;
        case 4:
            self.contentField.text = model.email;
            break;
        case 5:
            self.contentField.text = model.address;
            break;
        default:
            break;
    }
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
