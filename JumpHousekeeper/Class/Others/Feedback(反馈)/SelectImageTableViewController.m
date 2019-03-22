//
//  SelectImageTableViewController.m
//  JumpHousekeeper
//
//  Created by jumpapp1 on 2019/3/22.
//  Copyright © 2019年 zhoubin. All rights reserved.
//

#import "SelectImageTableViewController.h"
#import "ZLPhotoActionSheet.h"
#import "SelectImageTableViewCell.h"

@interface SelectImageTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//添加附件
@property (strong,nonatomic) UIButton *addBtn;
//数据源
@property (strong,nonatomic) NSMutableArray *dataArray;
//上传照片的字符串
@property (copy,nonatomic) NSString *baseStr;

@end

@implementation SelectImageTableViewController

-(NSMutableArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(UIButton *)addBtn{
    
    if(!_addBtn){
        
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44)];
        
        _addBtn.enabled = YES;
        
        _addBtn.backgroundColor = RGB(0, 122, 255);
        
        [_addBtn setTitle:@"添加附件" forState:UIControlStateNormal];
        
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addBtn;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    kToolbarAppearItem(self.addBtn);

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    kToolbarDisappearItem;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"附件";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureAction:)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectImageTableViewCell"];
    
    if(self.selectArray.count > 0){
        
        [self.dataArray addObjectsFromArray:self.selectArray];
    }
}


#pragma mark --- UITableViewDataSource And delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectImageTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    [cell refreshFileList:dict];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    L2CWeakSelf(self);
    
    UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"确认删除?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            JumpLog(@"确认");
            [weakself deleteAction:indexPath.row];
            
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [weakself presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    return @[cancel];
    
}

#pragma mark -- 删除附件

-(void)deleteAction:(NSInteger)num{
    
    [self.dataArray removeObjectAtIndex:num];
    
    [self.tableView reloadData];
}


#pragma mark --- 添加附件

-(void)addAction:(UIButton *)sender{
    
    L2CWeakSelf(self);
    
    if(weakself.dataArray.count > 0){
        
        [SVPShow showInfoWithMessage:@"最多添加一张附件"];
     
        return;
    }
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"添加附件" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakself takePhoto];
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"从手机相册选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [weakself selectPhoto];
        
    }]];
    
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

//拍照
-(void)takePhoto{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        cameraUI.allowsEditing = NO;
        
        cameraUI.delegate = self;
        
        [self presentViewController:cameraUI animated:YES completion:nil];
  
    }else{
        
        
        [SVPShow showInfoWithMessage:@"访问系统相机错误"];
        
    }
}

//选择照片
-(void)selectPhoto{
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 30;
    
    [actionSheet showPreviewPhotoWithSender:self.navigationController animate:YES lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        
        NSLog(@"%@", selectPhotos);
        
        for(NSInteger i = 0;i<selectPhotos.count ;i ++)
        {
            NSMutableDictionary *attachmentDic = [NSMutableDictionary dictionary];
            
            NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
            
            [dateFormat setDateStyle:NSDateFormatterMediumStyle];
            
            [dateFormat setTimeStyle:NSDateFormatterMediumStyle];
            
            dateFormat.dateFormat= [NSString stringWithFormat:@"yyyy-MM-dd HH:mm"];
            
            NSDate * date = [NSDate new];
            
            NSString *imageCreateTime = [dateFormat stringFromDate:date];
            
            UIImage *img = selectPhotos[i];
            
            CGFloat imageheight = img.size.height;
            
            CGFloat imagewidth = img.size.width;
            
            if (imagewidth>1024 || imageheight>1024)
            {
                CGRect rect;
                
                if (imagewidth > imageheight)
                {
                    rect = CGRectMake(0, 0, 1024, 1024*imageheight/imagewidth);
                }
                else
                {
                    rect = CGRectMake(0, 0, 1024*imagewidth/imageheight, 1024);
                }
                
                
                UIGraphicsBeginImageContext(rect.size);
                
                [img drawInRect:rect];
                
                img = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
            }
            
            NSData *imageData = UIImageJPEGRepresentation(img, 0.2);
            
            self.baseStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            
            NSString *fileSize = [NSString stringWithFormat:@"%lu",imageData.length/1000];
            
            NSString *imageName = [NSString stringWithFormat:@"%@.jpg",imageCreateTime];
            
            [attachmentDic setObject:fileSize forKey:@"fileSize"];
            [attachmentDic setObject:imageCreateTime forKey:@"createTime"];
            [attachmentDic setObject:img forKey:@"newImage"];
            [attachmentDic setObject:imageName forKey:@"fileName"];
            
            [self.dataArray addObject:attachmentDic];

            [self.tableView reloadData];
            
        }
    }];
}


#pragma mark -- 拍照选择后回掉

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    UIImage *newimage;
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)== kCFCompareEqualTo)
    {
        UIImage *imageToUse = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum (imageToUse, nil, nil , nil);
        }
        
        CGFloat imagewidth = imageToUse.size.width;
        CGFloat imageheight = imageToUse.size.height;
        
        if (imagewidth>1024 || imageheight>1024)
        {
            CGRect rect;
            
            if (imagewidth > imageheight)
            {
                rect = CGRectMake(0, 0, 1024, 1024*imageheight/imagewidth);
            }
            else
            {
                rect = CGRectMake(0, 0, 1024*imagewidth/imageheight, 1024);
            }
            
            
            UIGraphicsBeginImageContext(rect.size);
            
            [imageToUse drawInRect:rect];
            
            newimage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        }
        else
        {
            newimage = imageToUse;
        }
        
        NSMutableDictionary *attachmentDic = [NSMutableDictionary dictionary];
        
        NSData *imageData = UIImageJPEGRepresentation(newimage, 0.2);
        
        self.baseStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSString *fileSize = [NSString stringWithFormat:@"%lu",imageData.length/1000];
        
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        
        [dateFormat setTimeStyle:NSDateFormatterMediumStyle];
        
        dateFormat.dateFormat= [NSString stringWithFormat:@"yyyy-MM-dd HH:mm"];
        
        NSDate * date = [NSDate new];
        
        NSString *imageCreateTime = [dateFormat stringFromDate:date];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",imageCreateTime];
        
        [attachmentDic setObject:fileSize forKey:@"fileSize"];
        
        [attachmentDic setObject:imageCreateTime forKey:@"createTime"];
        
        [attachmentDic setObject:newimage forKey:@"newImage"];
        
        [attachmentDic setObject:imageName forKey:@"fileName"];
        
        [self.dataArray addObject:attachmentDic];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
        [self.tableView reloadData];
        
    }
}


#pragma mark --- 确认

-(void)sureAction:(UIBarButtonItem *)item{
    
    if(self.dataArray.count < 1){
        
        [SVPShow showInfoWithMessage:@"未添加附件"];
        
        return;
    
    }else{
        
        if(self.block){
            
            self.block(self.baseStr, self.dataArray);
            
            [self backAction];
        }
    }
}

@end
