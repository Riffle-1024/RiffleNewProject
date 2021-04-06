//
//  EkooInputVerCodeView.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkooInputVerCodeView : UIView

/**背景图片*/
@property (nonatomic,copy)NSString *backgroudImageName;
/**验证码/密码的位数*/
@property (nonatomic,assign)NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property (nonatomic,assign)bool secureTextEntry;
/**验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容*/
@property (nonatomic,copy)NSString *vertificationCode;

-(void)becomeFirstResponder;

-(void)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
