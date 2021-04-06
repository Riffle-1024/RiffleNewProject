//
//  EkooNavigationView.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooNavigationView.h"

@implementation EkooNavigationView

- (id)initWithDefaultFrame
{
    self = [super initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, NAV_HEIGHT)];
    self.mCuttingLine.backgroundColor = COLOR_CUTTING_LINE;
    return self;
}

@end
