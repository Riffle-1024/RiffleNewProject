//
//  AppDelegate.h
//  ekoo
//
//  Created by liuyalu on 2020/6/4.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EkooAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property(nonatomic, strong) NSDate *mToastDate;

@property(nonatomic, strong) NSString *mToastString;

//
- (UINavigationController *)sharedNavigationController;

//全局的 toast 弹窗
- (void)toastShow:(NSString *)message;


@end

