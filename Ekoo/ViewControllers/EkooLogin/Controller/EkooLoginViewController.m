//
//  EkooLoginViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooLoginViewController.h"
#import "Person+category.h"
#import <objc/runtime.h>
#import "TestViewController.h"

@interface EkooLoginViewController ()

@property (nonatomic,strong)UIButton * codeBtn;//选择手机号区号的按钮

@property (nonatomic,strong)UITextField * phoneTextField;//s输入手机号码框

@property (nonatomic,strong)NSString * areaCodeStr;

@end

@implementation EkooLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self initSubViews];
    
}

-(void)initSubViews{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(27.5), VIEW_FIT_TO_IPHONE6_VALUE(94.5), VIEW_FIT_TO_IPHONE6_VALUE(200), VIEW_FIT_TO_IPHONE6_VALUE(23))];
    titleLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(22)];
    titleLabel.text = LSTRING(@"input_phone_number");
    titleLabel.textColor = COLOR_EKOO;
    [self.view addSubview:titleLabel];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(152.5), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    backView.layer.borderWidth = VIEW_FIT_TO_IPHONE6_VALUE(1);
    backView.layer.borderColor = COLOR_EKOO.CGColor;
    [self.view addSubview:backView];
    
    self.areaCodeStr = @"+86";
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeBtn.frame = CGRectMake(0, 0, VIEW_FIT_TO_IPHONE6_VALUE(60), VIEW_FIT_TO_IPHONE6_VALUE(50));
    [self.codeBtn setTitle:self.areaCodeStr forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:UIColorFromRGB(0x231815) forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:self.codeBtn];
    
    UIView * linView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(60), VIEW_FIT_TO_IPHONE6_VALUE(11), VIEW_FIT_TO_IPHONE6_VALUE(1.5), VIEW_FIT_TO_IPHONE6_VALUE(28))];
    linView.backgroundColor = COLOR_EKOO_GRAY;
    [backView addSubview:linView];
    
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(VIEW_FIT_TO_IPHONE6_VALUE(89)), 0, VIEW_FIT_TO_IPHONE6_VALUE(244), VIEW_FIT_TO_IPHONE6_VALUE(50))];
    self.phoneTextField.placeholder = LSTRING(@"phone_number");
    [backView addSubview:self.phoneTextField];
    
    UIButton * continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(222), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50));
    continueBtn.backgroundColor = COLOR_EKOO;
    [continueBtn setTitle:LSTRING(@"continue") forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.layer.masksToBounds = YES;
    continueBtn.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    [self.view addSubview:continueBtn];
    
    /**
     *底部的服务条款
     */
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT - TABBAR_HEIGHT - VIEW_FIT_TO_IPHONE6_VALUE(48), VIEW_WIDTH, VIEW_FIT_TO_IPHONE6_VALUE(11))];
    textLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(10)];
    textLabel.text = LSTRING(@"regist_text");
    textLabel.textColor = UIColorFromRGB(0x9E9E9E);
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
     
    UIButton * serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    serviceBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(132), VIEW_HEIGHT - TABBAR_HEIGHT - VIEW_FIT_TO_IPHONE6_VALUE(32), VIEW_FIT_TO_IPHONE6_VALUE(111), VIEW_FIT_TO_IPHONE6_VALUE(12));
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(10)];
    [serviceBtn setTitle:LSTRING(@"regist_service") forState:UIControlStateNormal];
    [serviceBtn setTitleColor:COLOR_EKOO forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    [serviceBtn addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    Person * person = [[Person alloc]init];
    [person creatName:@"我使用了runtime"];
    Ivar ivar = class_getInstanceVariable([Person class], "_name");
    NSString * string = object_getIvar(person, ivar);
    
    NSLog(@"name:%@",string);
}

#pragma mark - UIButtonClick -

//
-(void)codeBtnClick{
    [EkooUIEngine pushToAreaCodeVCAreaCodeBlock:^(NSString * _Nonnull codeStr) {
        self.areaCodeStr = codeStr;
        [self.codeBtn setTitle:self.areaCodeStr forState:UIControlStateNormal];
    }];
}

/*
 *
 *x先判断号码是否为空，再正则判断号码的准确性
 *
 */

-(void)continueBtnClick{
    if (self.phoneTextField.text.length == 0) {
        [self toastShow:LSTRING(@"input_phone_number_error1")];
    }else if (![self isNum:self.phoneTextField.text]){
        [self toastShow:LSTRING(@"input_phone_number_error2")];
    }else{
        [EkooUIEngine pushToVerifyCodeVCWithPhoneNumber:[NSString stringWithFormat:@"%@%@",self.areaCodeStr,self.phoneTextField.text]];
    }
}

//查看服务条款
-(void)serviceBtnClick{
    
}


/**
 *判断是否是纯数字号码
 */

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

#pragma mark - 点击空白 -

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

[self.view endEditing:YES];

}




@end
