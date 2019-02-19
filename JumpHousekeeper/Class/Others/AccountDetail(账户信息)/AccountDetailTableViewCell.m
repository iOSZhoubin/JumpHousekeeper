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

-(void)refreshWithModel:(JumpAccountDetailModel *)model isEnabel:(NSString *)isEnabel indexPath:(NSIndexPath *)indexPath{

    NSArray *titleArray = @[@"昵称",@"账号",@"真实姓名",@"手机号",@"邮箱",@"详细地址"];
    
    NSDictionary *userInfo = [JumpKeyChain getKeychainDataForKey:@"userInfo"];

    NSString *account = SafeString(userInfo[@"account"]);
    
    model.account = account;
    
    self.titleName.text = titleArray[indexPath.row];
    
    self.contentField.delegate = self;
    
    //是否显示右侧箭头
    if(indexPath.row == 5){
        
        self.arrowImage.hidden = NO;
        
    }else{
        
        self.arrowImage.hidden = YES;
    }
    
    
    //是否可以编辑
    if([isEnabel isEqualToString:@"1"]){
        
        if(indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5){
            
            self.contentField.enabled = NO;
        
        }else{
            
            self.contentField.enabled = YES;
        }
        
    }else{
        
        self.contentField.enabled = NO;
    }
    
    switch (indexPath.row) {
        case 0:
            self.contentField.text = model.nickname;
            break;
        case 1:
            self.contentField.text = model.account;
            break;
        case 2:
            self.contentField.text = model.truename;
            break;
        case 3:
            self.contentField.text = model.phonenum;
            break;
        case 4:
            self.contentField.text = model.mailnum;
            break;
        case 5:
            self.contentField.text = model.address;
            break;
        default:
            break;
    }
}



-(void)refreshWithModel:(JumpTypeModel *)model{

    self.titleName.text = SafeString(model.cname);
    
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

                self.contentField.text = SafeString(contentDict[@"remark"]);
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


-(void)refreshDeviceWithModel:(DeviceDetailModel *)model indexPath:(NSIndexPath *)indexPath{

    NSArray *titleArray = @[@"设备状态",@"最新安全事件",@"设备版本信息",@"设备安全补丁",@"设备升级信息",@"设备许可信息",@"设备IP地址",@"设备ID"];
    
    self.titleName.text = titleArray[indexPath.row];
    
    self.contentField.enabled = NO;
    
    if(indexPath.row == 1){
        
        self.arrowImage.hidden = NO;
        
    }else{
        
        self.arrowImage.hidden = YES;
    }
 
    switch (indexPath.row) {
        case 0:
            self.contentField.text = SafeString(model.status);
            break;
        case 1:
            self.contentField.text = SafeString(model.news);

            break;
        case 2:
            self.contentField.text = SafeString(model.version);

            break;
        case 3:
            self.contentField.text = SafeString(model.patch);

            break;
        case 4:
            self.contentField.text = SafeString(model.upgrade);

            break;
        case 5:
            self.contentField.text = SafeString(model.license);

            break;
        case 6:
            self.contentField.text = SafeString(model.ip);

            break;
        case 7:
            self.contentField.text = SafeString(model.deviceId);

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
