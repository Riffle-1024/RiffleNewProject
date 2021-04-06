//
//  EkooHttpRequest.m
//  Ekoo
// 基于AFNetWorking的再封装
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooHttpRequest.h"

@implementation UploadParams

@end

@implementation EkooHttpRequest

static id _instance = nil;
+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"未识别的网络");
                    [EkooHttpRequest sharedInstance].errorStr = @"";
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                    [[EkooHttpRequest sharedInstance].manager.operationQueue cancelAllOperations];
                    [EkooHttpRequest sharedInstance].errorStr = @"您已经关闭了网络!";
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                    [EkooHttpRequest sharedInstance].errorStr = @"";
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                     NSLog(@"当前使用的是2G/3G/4G网络");
                    [EkooHttpRequest sharedInstance].errorStr = @"";
                }
            }
        }];
    });
    return _instance;
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
//    NSData *cookiesData = [[NSUserDefaults standardUserDefaults]objectForKey:@"Set-Cookie"];
//    if ([cookiesData length]) {
//        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
//        NSHTTPCookie *cookie;
//        for (cookie in cookies) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookie];
//        }
//    }

    [EkooHttpRequest sharedInstance].manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    [EkooHttpRequest sharedInstance].manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /**
     *  请求队列的最大并发数
     */
//    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    [EkooHttpRequest sharedInstance].manager.requestSerializer.timeoutInterval = 60;
    [[EkooHttpRequest sharedInstance].manager GET:URLString parameters:nil headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

#pragma mark -- POST请求 - -
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  headers:(nullable NSDictionary <NSString *, NSString *> *)headers
           withHeaderType:(NSString *)headerType andAcceptableContentTypes:(NSString *)acceptType
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    [EkooHttpRequest sharedInstance].manager = [AFHTTPSessionManager manager];
    [EkooHttpRequest sharedInstance].manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [EkooHttpRequest sharedInstance].manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置请求超时时间
    [[EkooHttpRequest sharedInstance].manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [EkooHttpRequest sharedInstance].manager.requestSerializer.timeoutInterval = 60.f;
     [[EkooHttpRequest sharedInstance].manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [[EkooHttpRequest sharedInstance].manager.requestSerializer setValue:headerType forHTTPHeaderField:@"Content-Type"];
    [EkooHttpRequest sharedInstance].manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:acceptType];
    NSData *cookiesData = [[NSUserDefaults standardUserDefaults]objectForKey:@"Set-Cookie"];
    if ([cookiesData length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookie];
        }
    }
    [[EkooHttpRequest sharedInstance].manager POST:URLString parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                 success(responseObject);
             }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
                   failure(error);
               }
    }];


}

@end
