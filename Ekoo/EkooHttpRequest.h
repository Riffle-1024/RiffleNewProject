//
//  EkooHttpRequest.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface UploadParams : NSObject
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;

@end

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface EkooHttpRequest : NSObject
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@property (nonatomic, copy) NSString * errorStr;
+ (instancetype)sharedInstance;

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)URLString
parameters:(id)parameters
   headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
    parameters:(id)parameters
       headers:(nullable NSDictionary <NSString *, NSString *> *)headers
withHeaderType:(NSString *)headerType andAcceptableContentTypes:(NSString *)acceptType
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure ;









@end

NS_ASSUME_NONNULL_END
