//
//  EkooCardModel.h
//  Ekoo
//
//  Created by 刘亚录 on 2021/4/6.
//  Copyright © 2021 liuyalu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkooCardModel : NSObject

@property (nonatomic, copy) NSString *uid;//用户id
@property (nonatomic, copy) NSArray *images;//相册
@property (nonatomic, copy) NSString *nickname;//#昵称
@property (nonatomic, copy) NSString *info_done;//#是否显示资料图标 0 ：否 1：显示
@property (nonatomic, copy) NSString *is_online;//#是否显示在线图标 0：否 1：显示
@property (nonatomic, copy) NSString *text1;//#展示文字1
@property (nonatomic, copy) NSString *text2;//#展示文字2
@property (nonatomic, copy) NSString *is_love;//#是否喜欢 0：否 1：是

@end

NS_ASSUME_NONNULL_END
