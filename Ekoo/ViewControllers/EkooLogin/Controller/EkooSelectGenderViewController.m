//
//  EkooSelectGenderViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooSelectGenderViewController.h"

@interface EkooSelectGenderViewController ()

@property (nonatomic,strong) UIButton * middBtn;//传值Btn

@property(nonatomic,assign) NSInteger seletType;//选择结果，0：未选择，1：女，2：男

@end

@implementation EkooSelectGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

-(void)initSubViews{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(95), VIEW_FIT_TO_IPHONE6_VALUE(220), VIEW_FIT_TO_IPHONE6_VALUE(24))];
    titleLabel.textColor = COLOR_EKOO;
    titleLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(23)];
    titleLabel.text = @"請選擇性別";
    [self.view addSubview:titleLabel];
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(25), VIEW_FIT_TO_IPHONE6_VALUE(135), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(50), VIEW_FIT_TO_IPHONE6_VALUE(14))];
    textLabel.text = @"*性別選擇後無法修改";
    textLabel.textColor = UIColorFromRGB(0x9E9E9E);
    textLabel.font = [UIFont systemFontOfSize:FONT_FIT_TO_IPHONE6_VALUE(14)];
    [self.view addSubview:textLabel];
    
    UIButton * womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    womenBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(39), VIEW_FIT_TO_IPHONE6_VALUE(176), VIEW_FIT_TO_IPHONE6_VALUE(129), VIEW_FIT_TO_IPHONE6_VALUE(129));
    [womenBtn setImage:[UIImage imageNamed:@"select_women"] forState:UIControlStateSelected];
    [womenBtn setImage:[UIImage imageNamed:@"unselect_women"] forState:UIControlStateNormal];
    [womenBtn addTarget:self action:@selector(womenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:womenBtn];
    UIButton * manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    manBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(207), VIEW_FIT_TO_IPHONE6_VALUE(176), VIEW_FIT_TO_IPHONE6_VALUE(129), VIEW_FIT_TO_IPHONE6_VALUE(129));
    [manBtn setImage:[UIImage imageNamed:@"select_man"] forState:UIControlStateSelected];
    [manBtn setImage:[UIImage imageNamed:@"unselect_man"] forState:UIControlStateNormal];
    [manBtn addTarget:self action:@selector(manBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];
    
    UIButton * continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueBtn.frame = CGRectMake(VIEW_FIT_TO_IPHONE6_VALUE(21), VIEW_FIT_TO_IPHONE6_VALUE(343), VIEW_WIDTH - VIEW_FIT_TO_IPHONE6_VALUE(42), VIEW_FIT_TO_IPHONE6_VALUE(50));
    continueBtn.backgroundColor = COLOR_EKOO;
    [continueBtn setTitle:LSTRING(@"continue") forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.layer.masksToBounds = YES;
    continueBtn.layer.cornerRadius = VIEW_FIT_TO_IPHONE6_VALUE(25);
    [self.view addSubview:continueBtn];
}


#pragma mark - UIbuttonClick -
/**
 *点击女头像
 */
-(void)womenBtnClick:(UIButton *)sender{
    if (sender.isSelected) {
        return;
    }else{
        if (self.middBtn) {
            self.middBtn.selected = !self.middBtn.selected;
        }
        sender.selected = !sender.selected;
        self.middBtn = sender;
        self.seletType = 1;
    }
}
/**
*点击男头像
*/
-(void)manBtnBtnClick:(UIButton *)sender{
    if (sender.isSelected) {
        return;
    }else{
        if (self.middBtn) {
            self.middBtn.selected = !self.middBtn.selected;
        }
        sender.selected = !sender.selected;
        self.middBtn = sender;
        self.seletType = 2;
    }
}

-(void)continueBtnClick{
    if (self.seletType == 0) {
        [self toastShow:@"请选择性别"];
    }else{
        [EkooUIEngine pushToImproveInfoVC];
    }
}
@end
