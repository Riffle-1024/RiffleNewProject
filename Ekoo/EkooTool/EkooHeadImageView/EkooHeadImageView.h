//
//  EkooHeadImageView.h
//  Ekoo
//
//  Created by 刘亚录 on 2020/8/22.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EkooHeadImageView;

@protocol EkooHeadImageViewDelegate <NSObject>

@optional
- (void)imageView:(EkooHeadImageView *)imageView didSelectImage:(UIImage*)image imageTag:(NSInteger)tag;
- (void)imageViewDidCancleSelectImage:(EkooHeadImageView *)imageView;
- (void)returnKeyboard;

@end

@interface EkooHeadImageView : UIImageView

@property (strong , nonatomic) id<EkooHeadImageViewDelegate> delegate;

@property (nonatomic,assign) BOOL isNeedEdit;//是否需要编辑图片
//make imageview can receive action than change image
-(void)canReceiveAction:(BOOL)receiveAction;
-(BOOL)isCanReceiveAction;

//make imageview circle
-(void)makeToCircle:(BOOL)circle;
-(BOOL)makeToCircle;
@end

NS_ASSUME_NONNULL_END
