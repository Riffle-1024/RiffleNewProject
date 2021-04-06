//
//  TestViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/8/31.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "TestViewController.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "FouthView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    FirstView * firstView = [[FirstView alloc]initWithFrame:CGRectMake(0, 40, 200, 400)];
    firstView.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstView];
    
    ThirdView * thirdView = [[ThirdView alloc]initWithFrame:CGRectMake(0, 40, 100, 400)];
    thirdView.backgroundColor = [UIColor blueColor];
    [firstView addSubview:thirdView];
    SecondView * secondView = [[SecondView alloc]initWithFrame:CGRectMake(40, 40, 60, 300)];
    secondView.backgroundColor = [UIColor greenColor];
    [firstView addSubview:secondView];
    FouthView * fouthView = [[FouthView alloc]initWithFrame:CGRectMake(0, 40, 60, 60)];
    fouthView.backgroundColor = [UIColor orangeColor];
    [thirdView addSubview:fouthView];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:%@",NSStringFromClass([self class]));
}

@end
