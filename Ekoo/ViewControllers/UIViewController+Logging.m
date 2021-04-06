//
//  UIViewController+Logging.m
//  Ekoo
//
//  Created by liuyalu on 2020/8/27.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>

@implementation UIViewController (Logging)

+(void)load{
    swizzledMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
}

-(void)swizzled_viewDidAppear:(BOOL)animated{
    [self swizzled_viewDidAppear:YES];
    NSLog(@"进入页面：%@",NSStringFromClass([self class]));
}

void swizzledMethod (Class class,SEL orgiSelector,SEL swizzeldSelector){
    Method orgiMethod = class_getInstanceMethod(class, orgiSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzeldSelector);
    
    BOOL addMethod = class_addMethod(class, orgiSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (addMethod) {
        class_replaceMethod(class, swizzeldSelector, method_getImplementation(orgiMethod), method_getTypeEncoding(orgiMethod));
    }else{
        method_exchangeImplementations(orgiMethod, swizzledMethod);
    }
}


@end
