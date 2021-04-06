//
//  Person+category.m
//  Ekoo
//
//  Created by liuyalu on 2020/8/27.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "Person+category.h"
#import <objc/runtime.h>

static NSString * headerKey = @"headerKey";

@implementation Person (category)

-(void)setHeader:(NSString *)header{
    objc_setAssociatedObject(self, &headerKey, header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)header{
    return objc_getAssociatedObject(self, &headerKey);
}

@end
