//
//  NSArray+Addtion.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "NSArray+Addtion.h"

@implementation NSArray (Addtion)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    
    id object = [self objectAtIndex:index];
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    return object;
}

@end
