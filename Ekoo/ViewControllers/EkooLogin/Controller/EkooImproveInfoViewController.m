//
//  EkooImproveViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooImproveInfoViewController.h"
#import "EkooDateTimePickerView.h"
#import "EkooHeadImageView.h"

@interface EkooImproveInfoViewController ()<EkooDateTimePickerViewDelegate,EkooHeadImageViewDelegate>

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,strong)UIButton * seletDateBtn;

@property (nonatomic, strong) EkooDateTimePickerView *datePickerView;

@end

@implementation EkooImproveInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

-(void)initSubViews{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(95), VIEW_FIT_TO_IPHONE6_VALUE(220), VIEW_FIT_TO_IPHONE6_VALUE(24))];
    titleLabel.textColor = COLOR_EKOO;
    titleLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(23)];
    titleLabel.text = @"請完善資料信息";
    [self.view addSubview:titleLabel];
  
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(153), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42),VIEW_FIT_TO_IPHONE6_VALUE(50))];
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    self.textField.layer.borderWidth = VIEW_FIT_TO_IPHONE6_VALUE(1);
    self.textField.layer.borderColor = COLOR_EKOO.CGColor;
//    self.textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textField];
    
    self.seletDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.seletDateBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(222), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50));
    self.seletDateBtn.layer.masksToBounds = YES;
    self.seletDateBtn.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    self.seletDateBtn.layer.borderWidth = VIEW_FIT_TO_IPHONE6_VALUE(1);
    self.seletDateBtn.layer.borderColor = COLOR_EKOO.CGColor;
    [self.seletDateBtn setTitle:@"請選擇生日" forState:UIControlStateNormal];
    [self.seletDateBtn setTitleColor:COLOR_EKOO_GRAY forState:UIControlStateNormal];
    [self.seletDateBtn addTarget:self action:@selector(selectDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seletDateBtn];
    //添加图片的lable
    UILabel * addImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(26), VIEW_FIT_TO_IPHONE6_VALUE(307), VIEW_FIT_TO_IPHONE6_VALUE(150), VIEW_FIT_TO_IPHONE6_VALUE(23))];
    addImageLabel.text = @"添加照片";
    addImageLabel.font = [UIFont systemFontOfSize:VIEW_FIT_TO_IPHONE6_VALUE(23)];
    addImageLabel.textColor = COLOR_EKOO;
    [self.view addSubview:addImageLabel];
    
    EkooHeadImageView * imageView = [EkooHeadImageView new];
    imageView.tag = 102;
    imageView.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(120), VIEW_FIT_TO_IPHONE6_VALUE(363),VIEW_FIT_TO_IPHONE6_VALUE(135), VIEW_FIT_TO_IPHONE6_VALUE(150));
    imageView.backgroundColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.0];
    imageView.image = [UIImage imageNamed:@"add_heahimage"];
    imageView.delegate = self;
    [self.view addSubview:imageView];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(548), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50));
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:COLOR_EKOO];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    [self.view addSubview:confirmBtn];
    
    
    
}




#pragma mark - UIButtonClick -

-(void)selectDateBtnClick{
    self.datePickerView =  [[EkooDateTimePickerView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT - VIEW_FIT_TO_IPHONE6_VALUE(200), VIEW_WIDTH, VIEW_FIT_TO_IPHONE6_VALUE(200))];
    self.datePickerView.delegate = self;
    // 此处更改所要显示的日期样式
    self.datePickerView.pickerViewMode = DatePickerViewDateYearMonthDay;
    //        _datePickerView.titleL.text = @"日期选择";
    [self.view.window addSubview:_datePickerView];
    self.datePickerView.startTime = @"1900";
    self.datePickerView.showTime = @"1993-11-28";
    [self.datePickerView showDateTimePickerViewWithTime:@"1993-11-28"];
}

-(void)confirmBtnClick{
    
}

#pragma mark - DateTimePickerViewDelegate
- (void)didClickFinishDateTimePickerView:(NSString *)date
{
    NSLog(@"选中的日期：date = %@", date);
    [self.seletDateBtn setTitle:date forState:UIControlStateNormal];
}

#pragma mark -EkooHeadImageViewDelegate -
- (void)returnKeyboard {
    [self.textField resignFirstResponder];

}
@end
