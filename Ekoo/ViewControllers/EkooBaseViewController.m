//
//  EkooBaseViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooBaseViewController.h"

@interface EkooBaseViewController ()

@end

@implementation EkooBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//      [self setupViews];
//
//      [self setTextAndFonts];
//
      if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
          self.automaticallyAdjustsScrollViewInsets = NO;
      }
      
      // IPHONE_X 导航栏
      if (DEVICE_IS_IPHONE_X){
          // 导航栏自定义界面请使用mNavigationViewHeight
          self.mNavigationViewHeight.constant = self.mNavigationViewHeight.constant + 24;
          // 少量导航栏自定义界面没有mNavigationViewHeight,使用mNavigationButtonTop
          self.mNavigationButtonTop.constant = self.mNavigationButtonTop.constant + 24;
      }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mNavigationView.mNavLeftButton.userInteractionEnabled = YES;
    
  
}

-(void)setNavigationBarTitleUnread:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightUnread:(BOOL)rightUnread
{
    [self setCustomNavigationBarTitle:navTitle rightIconNormal:rightIconNormal rightIconHighlighted:rightIconHighlighted rightUnread:rightUnread];
}
- (void)setNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString * )rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted
{
    [self setNavigationBarTitle:navTitle rightIconNormal:rightIconNormal rightIconHighlighted:rightIconHighlighted rightButtonTitle:nil];
}

- (void)setNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightButtonTitle:(NSString *)title
{
    [self setCustomNavigationBarTitle:navTitle rightIconNormal:rightIconNormal rightIconHighlighted:rightIconHighlighted];
    
//        [self setNavigationBarTitle:navTitle leftIconNormal:@"backward_0" leftIconHighlighted:@"backward_1" leftButtonFrame:CGRectMake(0, 0, 44, 44) rightIconNormal:rightIconNormal rightIconHighlighted:rightIconHighlighted rightButtonFrame:CGRectMake(0, 0, 44, 44) rightButtonTitle:title];
}

- (void)setNavigationBarTitle:(NSString *)navTitle leftIconNormal:(NSString *)leftIconNormal leftIconHighlighted:(NSString *)leftIconHighlighted leftButtonFrame:(CGRect)leftButtonFrame rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightButtonFrame:(CGRect)rightButtonFrame rightButtonTitle:(NSString *)title
{
    [self setCustomNavigationBarTitle:navTitle rightIconNormal:rightIconNormal rightIconHighlighted:rightIconHighlighted];
    
    if (leftIconNormal != nil) {
        [self.mNavigationView.mNavLeftButton setImage:[UIImage imageNamed:leftIconNormal] forState:UIControlStateNormal];
        [self.mNavigationView.mNavLeftButton setImage:[UIImage imageNamed:leftIconHighlighted] forState:UIControlStateHighlighted];
        [self.mNavigationView.mNavLeftButton setImage:[UIImage imageNamed:leftIconHighlighted] forState:UIControlStateSelected];
    } else {
        [self.mNavigationView.mNavLeftButton setHidden:YES];
    }
}

- (void)setNavigationCancleConfirmView:(NSString *)title {
    int title_Y = NAV_HEIGHT - 5 - 35;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, NAV_HEIGHT)];
    titleView.backgroundColor = COLOR_NAVIGATION_BAR;
    [self.view addSubview:titleView];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, title_Y, 55, 35);
    [cancelButton setTitle:LSTRING(@"Cancel") forState:UIControlStateNormal];
    [cancelButton setTitleColor:COLOR_NAVIGATION_BUTTON_NORMAL forState:UIControlStateNormal];
    [cancelButton setTitleColor:COLOR_NAVIGATION_BUTTON_DISABLED forState:UIControlStateSelected];
    [cancelButton setTitleColor:COLOR_NAVIGATION_BUTTON_DISABLED forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:FONT_NAVIGATION_LFET_RIGHT_TITLE];
    [cancelButton addTarget:self action:@selector(navLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancelButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2, title_Y, 200, 35)];
    titleLabel.text = title;
    titleLabel.textColor = COLOR_NAVIGATION_TITLE;
    titleLabel.font = MYFONT_SIZE_NAV_TITLE;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(VIEW_WIDTH - 10 - 55, title_Y, 55, 35);
    [confirmButton setTitle:LSTRING(@"OK") forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_NAVIGATION_BUTTON_NORMAL forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_NAVIGATION_BUTTON_DISABLED forState:UIControlStateSelected];
    [confirmButton setTitleColor:COLOR_NAVIGATION_BUTTON_DISABLED forState:UIControlStateHighlighted];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:FONT_NAVIGATION_LFET_RIGHT_TITLE];
    [confirmButton addTarget:self action:@selector(navRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:confirmButton];
    UIView * mCuttingLine = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, VIEW_WIDTH, 0.5)];
    mCuttingLine.backgroundColor = COLOR_CUTTING_LINE;
    [titleView addSubview:mCuttingLine];
}

- (void)setCustomNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted
{
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    EkooNavigationView *navigationView = [[EkooNavigationView alloc] initWithDefaultFrame];
    navigationView.backgroundColor = COLOR_NAVIGATION_BAR;
    [self.view addSubview:navigationView];
    
    self.mNavigationView = navigationView;
    
    [navigationView.mNavTitleLabel setText:navTitle];
    [navigationView.mNavTitleLabel setFont:MYFONT_SIZE_NAV_TITLE];
    [navigationView.mNavTitleLabel setTextColor:COLOR_EKOO];
    
    [navigationView.mNavLeftButton addTarget:self action:@selector(navLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (rightIconNormal != nil) {
        
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconNormal] forState:UIControlStateNormal];
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconHighlighted] forState:UIControlStateHighlighted];
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconHighlighted] forState:UIControlStateHighlighted];
        
        [navigationView.mNavRightButton addTarget:self action:@selector(navRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [navigationView.mNavRightButton setHidden:YES];
    }
    
}

- (void)setCustomNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightUnread:(BOOL)rightUnread
{
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    EkooNavigationView *navigationView = [[EkooNavigationView alloc] initWithDefaultFrame];
    navigationView.backgroundColor = COLOR_NAVIGATION_BAR;
    [self.view addSubview:navigationView];
    
    self.mNavigationView = navigationView;
    if(rightUnread){
        navigationView.mNavRightButtonMask.hidden = NO;
    }else{
        navigationView.mNavRightButtonMask.hidden = YES;
    }
    [navigationView.mNavTitleLabel setText:navTitle];
    [navigationView.mNavTitleLabel setFont:MYFONT_SIZE_NAV_TITLE];
    [navigationView.mNavTitleLabel setTextColor:COLOR_NAVIGATION_TITLE];
    
    [navigationView.mNavLeftButton addTarget:self action:@selector(navLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (rightIconNormal != nil) {
        
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconNormal] forState:UIControlStateNormal];
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconHighlighted] forState:UIControlStateHighlighted];
        [navigationView.mNavRightButton setImage:[UIImage imageNamed:rightIconHighlighted] forState:UIControlStateHighlighted];
        
        [navigationView.mNavRightButton addTarget:self action:@selector(navRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [navigationView.mNavRightButton setHidden:YES];
    }
    
}

/**
 *默认行为是返回
 */
-(void)navLeftButtonClick:(UIButton*)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.mNavigationView.mNavLeftButton.userInteractionEnabled = NO;
    
}

-(void)navRightButtonClick:(UIButton*)button
{
    
}

/**
 *默认行为是返回
 */
-(IBAction)actionLeftButtonClick:(UIButton*)button
{
    [self navLeftButtonClick:button];
}

-(IBAction)actionRightButtonClick:(UIButton*)button
{
    [self navRightButtonClick:button];
}

#pragma mark -  初始化方法
/*
 功能:使用默认的nib初始化
 */
- (id)initWithDefaultNib
{
    NSString *nibName = NSStringFromClass([self class]);
    return [self initWithNibName:nibName bundle:nil];
}

/*
 功能:view初始设置
 */
- (void)setupViews
{
    
}


/*
 功能:文字本地化和字体设置
 */
- (void)setTextAndFonts
{
    
}

/*
 功能:刷新数据
 */
- (void)refreshData
{
    
}

/*
 功能:在界面底部弹出Toast消息，2秒自动隐藏
 参数:弹框内容
 */
- (void)toastShow:(NSString *)message
{
    // 10秒内去除相同的提示
    if (self.mToastDate == nil
        || ![message isEqualToString:self.mToastString]
        || ([message isEqualToString:self.mToastString] && -[self.mToastDate timeIntervalSinceNow] > 3) )
    {
        [self.view makeCustomToast:message];
        self.mToastString = message;
        self.mToastDate = [NSDate date];
    }
}

-(void)toastShow:(NSString *)message duration:(NSTimeInterval)duration position:(id)position{
    // 10秒内去除相同的提示
    if (self.mToastDate == nil
        || ![message isEqualToString:self.mToastString]
        || ([message isEqualToString:self.mToastString] && -[self.mToastDate timeIntervalSinceNow] > 3) )
    {
        [self.view makeCustomToast:message duration:duration position:position];
        self.mToastString = message;
        self.mToastDate = [NSDate date];
    }
}

//点击键盘回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    DLog(@"EkooBaseViewController回收键盘");
}
@end
