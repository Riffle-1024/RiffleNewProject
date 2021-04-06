//
//  EkooHeadImageView.m
//  Ekoo
//
//  Created by 刘亚录 on 2020/8/22.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooHeadImageView.h"
#import "EkooImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Common.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#define ORIGINAL_MAX_WIDTH 640.0f

@interface EkooHeadImageView ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,EkooImageCropperDelegate,UIActionSheetDelegate>
{
    NSNotificationCenter* center;
}
@property (strong , nonatomic) UIImagePickerController* imagePickerVC;
@property (strong , nonatomic) UITapGestureRecognizer *singleTap;
@end

@implementation EkooHeadImageView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self canReceiveAction:YES];
    [self makeToCircle:YES];
}


-(instancetype)init{
    if (self=[super init]) {
        [self canReceiveAction:YES];
        [self makeToCircle:YES];
        //        if (!center) {
        //            center = [NSNotificationCenter defaultCenter];
        //            [center addObserver:self selector:@selector(editPortrait) name:@"editHeader" object:nil];
        //        }
        
    }
    
    
    return self;
    
}


-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)editPortrait {
    
    [self.delegate returnKeyboard];
    
    UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您可以在【设置】-【隐私】-【相机】中进行操作，重新授权App访问您的相机" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            self.imagePickerVC = [[UIImagePickerController alloc] init];
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            self.imagePickerVC.mediaTypes = mediaTypes;
            self.imagePickerVC.delegate = self;
            [[self viewController] presentViewController:self.imagePickerVC
                                                animated:YES
                                              completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        }
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            self.imagePickerVC = [[UIImagePickerController alloc] init];
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            self.imagePickerVC.mediaTypes = mediaTypes;
            self.imagePickerVC.delegate = self;
            [[self viewController] presentViewController:self.imagePickerVC
                                                animated:YES
                                              completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        }
    }];
    [alertControl addAction:cancle];
    [alertControl addAction:action1];
    [alertControl addAction:action2];
    [[self viewController] presentViewController:alertControl animated:YES completion:nil];
    
    //    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
    //                                                             delegate:self
    //                                                    cancelButtonTitle:@"取消"
    //                                               destructiveButtonTitle:nil
    //                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    //    [choiceSheet showInView:[self viewController].view];
    
    
}



#pragma mark -- setting and getter
-(void)makeToCircle:(BOOL)circle{
    self.layer.masksToBounds = circle;
    if (circle) {
        self.layer.cornerRadius = self.bounds.size.width/2;
    }
    
}
-(BOOL)makeToCircle{
    return self.layer.masksToBounds;
}

-(void)canReceiveAction:(BOOL)receiveAction{
    if (receiveAction) {
        self.userInteractionEnabled = YES;
        self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [self addGestureRecognizer:self.singleTap];
    }
    if (!receiveAction) {
        self.userInteractionEnabled = NO;
        [self.singleTap removeTarget:self action:@selector(editPortrait)];
        self.singleTap=nil;
    }
}
-(BOOL)isCanReceiveAction{
    return self.userInteractionEnabled;
}



#pragma mark VPImageCropperDelegate
- (void)imageCropper:(EkooImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        if (self.delegate&&[self.delegate respondsToSelector:@selector(imageView: didSelectImage: imageTag:)]) {
            [self.delegate imageView:self didSelectImage:editedImage imageTag: self.tag];
        }
    }];
}

- (void)imageCropperDidCancel:(EkooImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(imageViewDidCancleSelectImage:)]) {
            [self.delegate imageViewDidCancleSelectImage:self];
        }
        
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您可以在【设置】-【隐私】-【相机】中进行操作，重新授权App访问您的相机" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            self.imagePickerVC = [[UIImagePickerController alloc] init];
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            self.imagePickerVC.mediaTypes = mediaTypes;
            self.imagePickerVC.delegate = self;
            [[self viewController] presentViewController:self.imagePickerVC
                                                animated:YES
                                              completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            self.imagePickerVC = [[UIImagePickerController alloc] init];
            self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            self.imagePickerVC.mediaTypes = mediaTypes;
            self.imagePickerVC.delegate = self;
            [[self viewController] presentViewController:self.imagePickerVC
                                                animated:YES
                                              completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        }
    } else {
        
        
        
    }
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self.imagePickerVC dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (!self.isNeedEdit) {
            self.image = portraitImg;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(imageView: didSelectImage: imageTag:)]) {
               [self.delegate imageView:self didSelectImage:portraitImg imageTag: self.tag];
            }
            return;
        }
        //portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        UIImage *fixedImage = [UIImage fixOrientation:portraitImg];
        EkooImageCropperViewController *imgEditorVC = [[EkooImageCropperViewController alloc] initWithImage:fixedImage cropFrame:CGRectMake(0, 100.0f, [self viewController].view.frame.size.width, [self viewController].view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [[self viewController] presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
    
}

//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //模态方式退出uiimagepickercontroller
    [self.imagePickerVC dismissViewControllerAnimated:YES completion:^{}];
}
//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    
    NSLog(@"saved..");
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}



@end
