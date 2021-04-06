//
//  EkooNavigationViewController.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooNavigationViewController.h"

@interface EkooNavigationViewController ()<UINavigationControllerDelegate>

// 记录push标志
@property (nonatomic, getter=isPushing) BOOL pushing;

@end

@implementation EkooNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.pushing == YES) {
        NSLog(@"被拦截");
        return;
    } else {
        NSLog(@"push");
        self.pushing = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}


#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.pushing = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
