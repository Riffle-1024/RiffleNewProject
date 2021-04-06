//
//  FouthView.m
//  Ekoo
//
//  Created by liuyalu on 2020/8/31.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "FouthView.h"

@implementation FouthView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"hitTest:%@",NSStringFromClass([self class]));
    UIView * hitTextView = [super hitTest:point withEvent:event];
    NSLog(@"hitTest:%@,UIView:%@",NSStringFromClass([self class]),hitTextView);
    return hitTextView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:%@",NSStringFromClass([self class]));
}


@end
