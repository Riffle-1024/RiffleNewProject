//
//  EkooInputVerCodeLabel.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkooInputVerCodeLabel : UILabel

/**验证码/密码的位数*/
@property (nonatomic,assign)NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property (nonatomic,assign)bool secureTextEntry;


@property (nonatomic,strong)CALayer *imageLayer;

@end

NS_ASSUME_NONNULL_END
