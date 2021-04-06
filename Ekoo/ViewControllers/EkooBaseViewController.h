//
//  EkooBaseViewController.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EkooNavigationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EkooBaseViewController : UIViewController

@property(nonatomic, strong) EkooNavigationView *mNavigationView;
@property(nonatomic, strong) NSDate *mToastDate;
@property(nonatomic, strong) NSString *mToastString;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNavigationViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNavigationButtonTop;

#pragma mark - 导航按钮设置
/**
 *  设置导航
 *
 *  @param title               导航按钮的标题
 *  @param iconImageName       按钮图标
 *  @param selectedIconImageName    按钮选中时的图标
 *  @param buttonType          导航按钮类型
 */
- (void)setNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted;


/**
 *  设置导航
 *
 *  @param navTitle                导航按钮的标题
 *  @param rightIconNormal         按钮图标
 *  @param rightIconHighlighted    按钮选中时的图标
 *  @param rightButtonTitle        按钮的标题
 */
- (void)setNavigationBarTitle:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightButtonTitle:(NSString *)title;

/// 设置带红点的导航
/// @param navTitle 导航标题
/// @param rightIconNormal 按钮图标
/// @param rightIconHighlighted 按钮选中图标
/// @param rightUnread 是否显示小红点
-(void)setNavigationBarTitleUnread:(NSString *)navTitle rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightUnread:(BOOL)rightUnread;
/**
 *  设置导航
 *
 *  @param navTitle                导航按钮的标题
 *  @param leftIconNormal          左边按钮图标
 *  @param leftIconHighlighted     左边按钮选中时的图标
 *  @param leftButtonFrame         左边按钮大小
 *  @param rightIconNormal         右边按钮图标
 *  @param rightIconHighlighted    右边按钮选中时的图标
 *  @param rightButtonFrame        右边按钮大小
 *  @param rightButtonTitle        右边按钮的标题
 */
- (void)setNavigationBarTitle:(NSString *)navTitle leftIconNormal:(NSString *)leftIconNormal leftIconHighlighted:(NSString *)leftIconHighlighted leftButtonFrame:(CGRect)leftButtonFrame rightIconNormal:(NSString *)rightIconNormal rightIconHighlighted:(NSString *)rightIconHighlighted rightButtonFrame:(CGRect)rightButtonFrame rightButtonTitle:(NSString *)title;

/// 设置左边取消，右边确认的Navigation
/// @param title 标题
- (void)setNavigationCancleConfirmView:(NSString *)title;
/**
 *默认行为是返回
 */
-(void)navLeftButtonClick:(UIButton*)button;

-(void)navRightButtonClick:(UIButton*)button;

/**
 *默认行为是返回
 */
-(IBAction)actionLeftButtonClick:(UIButton*)button;

-(IBAction)actionRightButtonClick:(UIButton*)button;

#pragma mark -  初始化方法
/*
 功能:使用默认的nib初始化
 */
- (id)initWithDefaultNib;

/*
 功能:view初始设置
 */
- (void)setupViews;


/*
 功能:view文字本地化设置
 */
- (void)setTextAndFonts;

/*
 功能:刷新数据
 */
- (void)refreshData;

#pragma mark 弹框
/*
 功能:在界面底部弹出Toast消息，2秒自动隐藏
 参数:弹框内容
 */
- (void)toastShow:(NSString *)message;

/*
 功能:弹出Toast消息，显示时间和位置自定义
 参数:弹框内容
 */
-(void)toastShow:(NSString *)message duration:(NSTimeInterval)duration position:(id)position;

@end

NS_ASSUME_NONNULL_END
