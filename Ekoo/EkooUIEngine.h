//
//  EkooUIEngine.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkooUIEngine : NSObject

/*
 *
 *地区码页面
 *
 */
+(void)pushToAreaCodeVCAreaCodeBlock:(void (^)(NSString * codeStr))areaCodeBlock;

/**
 *输入验证码页面
 */

+(void)pushToVerifyCodeVCWithPhoneNumber:(NSString *)phoneNumber;

/**
 *选择性别页面
 */

+(void)pushToSelectGenderVC;

/**
*编辑个人信息页面
*/

+(void)pushToImproveInfoVC;
@end

NS_ASSUME_NONNULL_END
