//
//  AccountDetailTableViewCell.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/1/23.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "AccountDetailTableViewCell.h"

@interface AccountDetailTableViewCell()<UITextFieldDelegate>

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



-(void)refreshWithindexPath:(NSIndexPath *)indexPath{
    
    NSArray *titleArray = @[@"Web应用防火墙",@"入侵检测",@"入侵防御",@"漏洞扫描",@"防火墙",@"信息审计",@"服务器维护",@"数据库审计",@"SSLVPN",@"SOC"];
 
    self.titleName.text = titleArray[indexPath.row];
    
    self.contentField.enabled = NO;
}



-(void)refreshOpinionWithContent:(NSMutableDictionary *)contentDict indexPath:(NSIndexPath *)indexPath{

    NSArray *array1 = @[@"设备类型"];
    NSArray *array2 = @[@"问题类型",@"问题描述"];
    NSArray *array3 = @[@"联系人姓名",@"联系人电话"];
    
    NSArray *sumArray = @[array1,array2,array3];
    
    self.titleName.text = sumArray[indexPath.section][indexPath.row];
    
    self.arrowImage.hidden = NO;
    
    switch (indexPath.section) {
        case 0:
            self.contentField.enabled = NO;
            self.contentField.placeholder = @"请选择设备类型";
            self.contentField.text = SafeString(contentDict[@"deviceType"]);
            
            break;
        case 1:
            
        {
            self.contentField.enabled = NO;
            
            if(indexPath.row == 0){
                
                self.contentField.text = SafeString(contentDict[@"problemType"]);
                self.contentField.placeholder = @"请选择问题类型";

            }else{

                self.contentField.text = SafeString(contentDict[@"problemContent"]);
                self.contentField.placeholder = @"请填写问题描述(可选)";

            }
            
        }

            break;
        case 2:
            
        {
            self.contentField.enabled = YES;
            self.contentField.delegate = self;
            self.arrowImage.hidden = YES;

            if(indexPath.row == 0){
                
                self.contentField.text = SafeString(contentDict[@"contactName"]);
                self.contentField.placeholder = @"请输入姓名(可选)";

            }else{
                
                self.contentField.text = SafeString(contentDict[@"contactNumber"]);
                self.contentField.placeholder = @"请输入电话(必填)";

            }
        }
            break;
        default:
            break;
    }

}


#pragma mark --- UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.delegate){
        
        [self.delegate contentDetail:SafeString(textField.text) andCell:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
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
