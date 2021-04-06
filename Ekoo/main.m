//
//  main.m
//  ekoo
//
//  Created by liuyalu on 2020/6/4.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EkooAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([EkooAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
