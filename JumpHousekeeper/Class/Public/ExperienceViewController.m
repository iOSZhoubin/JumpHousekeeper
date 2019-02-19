//
//  ExperienceViewController.m
//  Jump
//
//  Created by jumpapp1 on 2018/12/20.
//  Copyright © 2018年 zhoubin. All rights reserved.
//

#import "ExperienceViewController.h"


@interface ExperienceViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *ploLa;
@property (strong, nonatomic) UILabel *charactorNumberAlert;

@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}


-(void)creatUI
{
    self.navigationItem.title = self.vcTitle;
    
    self.view.backgroundColor = BackGroundColor;
 
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(2, 0, kWidth-4,260)];
    
    _textView.textColor = [UIColor blackColor];
    
    _textView.font = [UIFont systemFontOfSize:16];
    
    _textView.delegate = self;
    
    _textView.text = [self filterHTML:_saveText];
    
    [self.view addSubview:_textView];

    CGFloat labelY = _textView.frame.origin.y + _textView.frame.size.height;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,labelY , kWidth, 0.5)];
    
    label.backgroundColor = RGB(224, 224, 224);
    
    [self.view addSubview:label];
    
    
    if(_isEnditor == YES)
    {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(success:)];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        _textView.editable = YES;
        [_textView becomeFirstResponder];
        
    }else{
        
        _textView.editable = NO;

    }
//设置等待文字
    _ploLa = [[UILabel alloc] initWithFrame:CGRectMake(6, 7, kWidth - 4, 20)];
    
    _ploLa.font = [UIFont systemFontOfSize:14];
    
    _ploLa.textColor = RGB(204, 204, 204);
    
     [_textView addSubview:_ploLa];
    
    if (_ploText && _isEnditor && (!_saveText || _saveText.length == 0)) { //如果外界给了ploText才显示提示字
       
        _ploLa.text = _ploText;
        
    }else{
        
        _ploLa.text = @"";
    }
//添加字数限制label
    
    self.charactorNumberAlert = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-90, _textView.frame.size.height + 5, 80, 20)];
    self.charactorNumberAlert.font = [UIFont systemFontOfSize:15];
    self.charactorNumberAlert.textAlignment = NSTextAlignmentRight;
    self.charactorNumberAlert.textColor = [UIColor grayColor];
    
    if(self.saveText.length > self.textLength){
        
        self.saveText = [self.saveText substringToIndex:self.textLength];
    }
    
    self.charactorNumberAlert.text = [NSString stringWithFormat:@"%ld/%ld",self.saveText.length,self.textLength];
    
    if(self.textLength){
      
        [self.view addSubview:self.charactorNumberAlert];
    }
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length == 0) {
        
        _ploLa.text = _ploText;
        
    }else{
        
        _ploLa.text = @"";
    }
    
    if (textView.text.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    if(self.textLength){
        
        if(textView.text.length > self.textLength){
            
            textView.text = [textView.text substringToIndex:self.textLength];
        }
        
        _charactorNumberAlert.text = [NSString stringWithFormat:@"%ld/%ld",textView.text.length,self.textLength];
    }
}

#pragma mark-保存
-(void)success:(UIBarButtonItem *)item
{
    if(self.textView.text == nil)
    {
        self.textView.text = @"";
    }
    
    
    self.block(SafeString(self.textView.text));
    
    [_textView resignFirstResponder];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBlock:(BackBlock)block{
    
    _block = block;
}


//转换字符
-(NSString *)filterHTML:(NSString *)html
{
    NSString *newStr = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    
    return newStr;
}


@end
