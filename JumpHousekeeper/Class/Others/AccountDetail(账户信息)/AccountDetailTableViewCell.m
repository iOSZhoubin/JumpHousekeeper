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
    NSArray *array4 = @[@"添加附件"];

    NSArray *sumArray = @[array1,array2,array3,array4];
    
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
        
        case 3:
        {
            self.contentField.enabled = NO;
            
            self.contentField.text = SafeString(contentDict[@"fileNum"]);
        }
            
            break;
            
        default:
            break;
    }

}


-(void)refreshDeviceWithModel:(DeviceDetailModel *)model status:(NSString *)status indexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *muArray = [NSMutableArray array];

    NSArray *titleArray = @[@"设备状态",@"设备版本信息",@"规则库版本",@"设备升级信息",@"设备许可信息",@"设备IP地址",@"设备ID",@"最新安全事件"];
    
    [muArray addObjectsFromArray:titleArray];
    
    if([model.ftype isEqualToString:@"6"] || [model.ftype isEqualToString:@"8"]){
        
        [muArray addObject:@"更多"];
    }
    
    self.titleName.text = muArray[indexPath.row];
     
    self.contentField.enabled = NO;
    
    NSString *stautus;
    
    if([status isEqualToString:@"1"]){

        stautus = @"在线";
        
    }else{

        stautus = @"离线";
    }
    
    if(indexPath.row == 7 || indexPath.row == 8){
        
        self.arrowImage.hidden = NO;

    }else{
        
        self.arrowImage.hidden = YES;
    }
    

    switch (indexPath.row) {
        case 0:
            self.contentField.text = stautus;
            break;
        case 1:
            self.contentField.text = SafeString(model.ver);

            break;
        case 2:
            self.contentField.text = SafeString(model.rulever);

            break;
        case 3:
            self.contentField.text = SafeString(model.fupdate);

            break;
        case 4:
            self.contentField.text = SafeString(model.license);

            break;
        case 5:
            self.contentField.text = SafeString(model.ip);

            break;
        case 6:
            self.contentField.text = SafeString(model.devid);
            
            break;

        default:
            break;
    }
}

+(NSMutableArray *)returnModelArray:(JumpMoreModel *)model{
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    NSArray *array1 = model.engstatus;
    
    for (NSDictionary *dict in array1) {
        
        NSString *name = @"";
        
        if([SafeString(dict[@"name"]) isEqualToString:@"datacenter"]){
            
            name = @"数据中心";
            
        }else if ([SafeString(dict[@"name"]) isEqualToString:@"analyse_eng"]){

            name = @"分析引擎";

        }else if ([SafeString(dict[@"name"]) isEqualToString:@"capture_eng"]){
            
            name = @"抓包引擎";

        }else if ([SafeString(dict[@"name"]) isEqualToString:@"secure_eng"]){

            name = @"安全引擎";
        }
        
        NSDictionary *newDict = @{
                                  @"status":SafeString(dict[@"status"]),
                                  @"anatype":SafeString(dict[@"anatype"]),
                                  @"anaid":SafeString(dict[@"anaid"]),
                                  @"name":SafeString(name)
                                  };
        
        [muArray addObject:newDict];
        
    }
    
    return muArray;
    
}


-(void)refreshMoreVcWithModel:(JumpMoreModel *)model indexPath:(NSIndexPath *)indexPath{
    
    self.contentField.enabled = NO;
    
    NSArray *array0 = @[@"硬盘使用率",@"引擎版本",@"激活模块",@"数据库服务",@"设备支持raid级别",@"系统运行时间",@"系统会话数",@"安全监控"];
    
    NSMutableArray *array1 = [AccountDetailTableViewCell returnModelArray:model];
    
    
    if(indexPath.section == 0){
        
        self.titleName.text = array0[indexPath.row];

    }else{
        
        NSString *str = SafeString(array1[indexPath.row][@"name"]);
        
        if([str isEqualToString:@"分析引擎"]){
            
            NSString *anatype = SafeString(array1[indexPath.row][@"anatype"]);
            NSString *anaid = SafeString(array1[indexPath.row][@"anaid"]);

            NSString *type = @"";
            
            if([anatype isEqualToString:@"0"]){
                
                type = @"流量引擎";
            
            }else{

                type = @"代理引擎";
            }
            
            self.titleName.text = [NSString stringWithFormat:@"分析引擎 %@ (%@)",anaid,type];

        }else{
            
            self.titleName.text = array1[indexPath.row][@"name"];
        }
    }
    
    if(indexPath.section == 0 && (indexPath.row == 2 || indexPath.row == 7)){
        
        self.arrowImage.hidden = NO;

    }else{
        
        self.arrowImage.hidden = YES;

    }
    
    if(indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0:
                self.contentField.text = [NSString stringWithFormat:@"%@%%",SafeString(model.disk)];

                break;
            case 1:
                self.contentField.text = SafeString(model.engver);
                
                break;

            case 3:
                self.contentField.text = SafeString(model.dbnum);

                break;
            case 4:
            {
                NSString *str = @"";
                
                if([SafeString(model.raid) isEqualToString:@"-1"]){
                    
                    str = @"未启用";
                    
                }else{
                    
                    str = SafeString(model.raid);
                }
                
                self.contentField.text = str;
            }
                
                break;
            case 5:
            {
                
                NSString *runTimer = @"";
                
                int dates = [model.runtime intValue]/(3600*24);
                int hours = [model.runtime intValue]%(3600*24)/3600;
                int minute = [model.runtime intValue]%(3600*24)%3600/60;
                int second = [model.runtime intValue]%(3600*24)%3600%60;
                
                if (dates == 0 && hours == 0 && minute == 0 &second == 0) {
                    runTimer = @"";
                }else if (dates == 0 && hours == 0 && minute == 0 && !(second == 0)){
                    runTimer = [NSString stringWithFormat:@"%i秒",second];
                }else if (dates == 0 && hours == 0 && !(minute == 0)){
                    runTimer = [NSString stringWithFormat:@"%i分%i秒",minute,second];
                }else if (dates == 0 && !(hours ==0)){
                    runTimer = [NSString stringWithFormat:@"%i小时%i分%i秒",hours,minute,second];
                }else if (!(dates == 0)){
                    runTimer = [NSString stringWithFormat:@"%i天%i小时%i分%i秒",dates,hours,minute,second];
                }else{
                    runTimer = @"";
                }
               
                self.contentField.text = SafeString(runTimer);

            }
                break;
            case 6:
                self.contentField.text = SafeString(model.sessionnum);

                break;
            default:
                break;
        }
        
    }else{

        NSString *status = SafeString(array1[indexPath.row][@"status"]);
        
        if([status isEqualToString:@"1"]){
            
            self.contentField.text = @"正常";

        }else{

            self.contentField.text = @"故障";
        }
    }

}


-(void)refreshSafeWithDict:(NSDictionary *)dict ftype:(NSString *)ftype indexPath:(NSIndexPath *)indexPath{
    
    self.arrowImage.hidden = YES;
    
    self.contentField.enabled = NO;
    
    NSArray *titleArray1 = @[@"IP",@"类型",@"监控状态",@"会话数",@"用户连接数"];

    self.titleName.text = titleArray1[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            self.contentField.text = SafeString(dict[@"ip"]);
            
            break;
        case 1:
            self.contentField.text = SafeString(dict[@"dbtype"]);

            break;
        case 2:
        {
            NSString *status = @"";
            
            if([dict[@"serverstate"] isEqualToString:@"1"]){
                
                status = @"在线";
                
            }else{
              
                status = @"离线";
            }
            
            self.contentField.text = status;
        }

            break;
        case 3:
            self.contentField.text = SafeString(dict[@"sessionnum"]);

            break;
        case 4:
            self.contentField.text = SafeString(dict[@"connnum"]);

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
