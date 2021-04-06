//
//  Person.m
//  Ekoo
//
//  Created by liuyalu on 2020/8/27.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "Person.h"
@interface Person ()

@property (nonatomic, copy) NSString * name;

@end

@implementation Person




-(void)creatName:(NSString *)mName{
    self.name = mName;
}
@end
