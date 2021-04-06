//
//  AppDelegate.m
//  ekoo
//
//  Created by liuyalu on 2020/6/4.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooAppDelegate.h"
#import "EkooNavigationViewController.h"
#import "EkooLoginViewController.h"

@interface EkooAppDelegate ()

@end

@implementation EkooAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    EkooLoginViewController * loginVC = [[EkooLoginViewController alloc]init];
    EkooNavigationViewController * navi = [[EkooNavigationViewController alloc] initWithRootViewController:loginVC];
    self.navigationController = navi;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];

    return YES;
}




- (UINavigationController *)sharedNavigationController
{
    return self.navigationController;
}

- (void)toastShow:(NSString *)message {
    
    if (self.mToastDate == nil
        || ![message isEqualToString:self.mToastString]
        || ([message isEqualToString:self.mToastString] && -[self.mToastDate timeIntervalSinceNow] > 3) )
    {
        [self.window makeCustomToast:message];
        self.mToastString = message;
        self.mToastDate = [NSDate date];
    }
}
@end
