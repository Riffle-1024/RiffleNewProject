//
//  EkooNavigationView.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EkooNavigationView : EkooBaseView
@property (weak, nonatomic) IBOutlet UIButton *mNavLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *mNavRightButton;
@property (weak, nonatomic) IBOutlet UILabel *mNavTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *mCuttingLine;
@property (weak, nonatomic) IBOutlet UIImageView *mNavRightButtonMask;

@end

NS_ASSUME_NONNULL_END
