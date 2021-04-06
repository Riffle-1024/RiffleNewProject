//
//  EkooVerifyCodeViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooVerifyCodeViewController.h"
#import "EkooInputVerCodeView.h"

@interface EkooVerifyCodeViewController ()

@property(nonatomic,strong) EkooInputVerCodeView *  inputVerCodeView;//输入验证码框

@property(nonatomic,strong) UILabel * timeLabel;//时间倒计时的显示

@property(nonatomic,assign) NSInteger recordTime;//超时时间

@property(nonatomic,strong) NSTimer * timer;//重发验证码定时器

@end

@implementation EkooVerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self creatTimer];
}


-(void)initSubViews{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(95), VIEW_FIT_TO_IPHONE6_VALUE(220), VIEW_FIT_TO_IPHONE6_VALUE(24))];
    titleLabel.textColor = COLOR_EKOO;
    titleLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(23)];
    titleLabel.text = LSTRING(@"input_verfiy_code");
    [self.view addSubview:titleLabel];
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(135), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(50), VIEW_FIT_TO_IPHONE6_VALUE(14))];
    textLabel.text = [NSString stringWithFormat:LSTRING(@"send_SMS_to%@"),self.phoneNumberStr];
    textLabel.textColor = UIColorFromRGB(0x9E9E9E);
    textLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(14)];
    [self.view addSubview:textLabel];
    
    self.inputVerCodeView = [[EkooInputVerCodeView alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(200), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(50), VIEW_FIT_TO_IPHONE6_VALUE(72.5))];
    self.inputVerCodeView.secureTextEntry = NO;
    [self.view addSubview:self.inputVerCodeView];
    [self.inputVerCodeView becomeFirstResponder];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(30), VIEW_FIT_TO_IPHONE6_VALUE(305), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(60), VIEW_FIT_TO_IPHONE6_VALUE(13))];
    self.timeLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(13)];
    self.timeLabel.textColor = COLOR_EKOO_GRAY;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = self.timeLabel.frame;
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21),VIEW_HEIGHT - VIEW_FIT_TO_IPHONE6_VALUE(90), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50));
    continueBtn.backgroundColor = COLOR_EKOO;
    [continueBtn setTitle:LSTRING(@"continue") forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.layer.masksToBounds = YES;
    continueBtn.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    [self.view addSubview:continueBtn];
    
}


-(void)creatTimer{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(recordTimeCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    self.recordTime = 60;
}

//计时

-(void)recordTimeCount{
    self.recordTime--;
    if (self.recordTime > 0) {//继续倒计时
        self.timeLabel.text = [NSString stringWithFormat:LSTRING(@"%dverify_code_time"),self.recordTime];
    }else{
        self.timeLabel.text = LSTRING(@"send_again_verify_code");
        [self.timer invalidate];
    }
}

-(void)sendBtnClick{
    if (self.recordTime > 0) {
        return;
    }else{
        [self creatTimer];
    }
    
}

-(void)continueBtnClick{
    [EkooUIEngine pushToSelectGenderVC];
}
@end
