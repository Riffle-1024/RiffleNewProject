//
//  EkooUIEngine.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooUIEngine.h"
#import "EkooAreaCodeViewController.h"
#import "EkooNavigationViewController.h"
#import "EkooVerifyCodeViewController.h"
#import "EkooSelectGenderViewController.h"
#import "EkooImproveInfoViewController.h"

@implementation EkooUIEngine


/*
*
*地区码页面
*
*/
+(void)pushToAreaCodeVCAreaCodeBlock:(void (^)(NSString * codeStr))areaCodeBlock{
    EkooAreaCodeViewController * areaCodeVC = [[EkooAreaCodeViewController alloc]init];
    areaCodeVC.returnAreaCodeBlock = ^(NSString * _Nonnull areaCodeStr) {
        areaCodeBlock(areaCodeStr);
    };
     [selfNavigationController pushViewController:areaCodeVC animated:YES];
    
}


/**
 *输入验证码页面
 */

+(void)pushToVerifyCodeVCWithPhoneNumber:(NSString *)phoneNumber{
    EkooVerifyCodeViewController * verifyCodeVC = [[EkooVerifyCodeViewController alloc]init];
    verifyCodeVC.phoneNumberStr = phoneNumber;
    [selfNavigationController pushViewController:verifyCodeVC animated:YES];
}


/**
 *选择性别页面
 */

+(void)pushToSelectGenderVC{
    EkooSelectGenderViewController * selectGenderVC = [[EkooSelectGenderViewController alloc]init];
    [selfNavigationController pushViewController:selectGenderVC animated:YES];
}

/**
*编辑个人信息页面
*/

+(void)pushToImproveInfoVC{
    EkooImproveInfoViewController * improveInfoVC = [[EkooImproveInfoViewController alloc]init];
    [selfNavigationController pushViewController:improveInfoVC animated:YES];
}
@end
