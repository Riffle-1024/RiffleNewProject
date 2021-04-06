//
//  EkooImageCropperViewController.h
//  Ekoo
//
//  Created by 刘亚录 on 2020/8/22.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

 
NS_ASSUME_NONNULL_BEGIN

@class EkooImageCropperViewController;
@protocol EkooImageCropperDelegate <NSObject>

- (void)imageCropper:(EkooImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(EkooImageCropperViewController *)cropperViewController;

@end

@interface EkooImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) id<EkooImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;


@end

NS_ASSUME_NONNULL_END
