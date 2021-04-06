//
//  EkooAreaCodeViewController.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/15.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnAreaCodeBlcok)(NSString * areaCodeStr);

@interface EkooAreaCodeViewController : EkooBaseViewController

@property(nonatomic, copy) ReturnAreaCodeBlcok returnAreaCodeBlock;

@end

NS_ASSUME_NONNULL_END
