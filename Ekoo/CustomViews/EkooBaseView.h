//
//  EkooBaseView.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/14.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkooBaseView : UIView

- (id)initWithFrame:(CGRect)frame;

- (id)initWithDefaultFrame;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mContentViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mContentViewHeightConstraint;

@end

NS_ASSUME_NONNULL_END
