//
//  UIView+Toast.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CSToastPositionTop;
extern NSString * const CSToastPositionCenter;
extern NSString * const CSToastPositionBottom;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Toast)

// each makeToast method creates a view and displays it as toast
- (void)makeCustomToast:(NSString *)message;
- (void)makeCustomToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point
      tapCallback:(void(^)(void))tapCallback;


@end

NS_ASSUME_NONNULL_END
