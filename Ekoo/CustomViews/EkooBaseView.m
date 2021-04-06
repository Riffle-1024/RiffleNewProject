//
//  EkooBaseView.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooBaseView.h"

@implementation EkooBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSString *nibName = NSStringFromClass([self class]);
        self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndexCheck:0];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.frame = frame;
        //
        DLog(@"self.frame = %@", NSStringFromCGRect(self.frame));
    }
    
    return self;
}

- (id)initWithDefaultFrame
{
    return [self initWithFrame:CGRectZero];
}

@end
