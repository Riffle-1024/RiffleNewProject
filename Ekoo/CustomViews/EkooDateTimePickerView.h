//
//  EkooDateTimePickerView.h
//  Ekoo
//
//  Created by liuyalu on 2020/7/17.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DatePickerViewDateYearMonthDayHourMinuteSecond, // 年月日,时分秒
    DatePickerViewDateYearMonthDayHourMinute,//年月日,时分 DatePickerViewDateTimeMode
    DatePickerViewDateYearMonthDay, //年月日 DatePickerViewDateMode
    DatePickerViewDateYearMonth, // 年月
    DatePickerViewDateHourMinute, // 时分
    DatePickerViewDateYear  // 年
} DatePickerViewMode;

@protocol EkooDateTimePickerViewDelegate <NSObject>
@optional
/**
 * 确定按钮
 */
- (void)didClickFinishDateTimePickerView:(NSString*)date;

@end


@interface EkooDateTimePickerView : UIView

/**
 * 设置当前时间
 */
@property(nonatomic, strong) NSDate *currentDate;

/**
* 设置开始时间
*/

@property(nonatomic, copy) NSString * startTime;

@property(nonatomic, copy) NSString * selectTime;

/**
* 设置显示时间
*/

@property(nonatomic, copy) NSString * showTime;


/**
 * 设置中心标题文字
 */
@property(nonatomic, strong)UILabel *titleL;

@property(nonatomic, strong)id<EkooDateTimePickerViewDelegate>delegate;
/**
 * 模式
 */
@property (nonatomic, assign) DatePickerViewMode pickerViewMode;



/**
 * 显示
 */
- (void)showDateTimePickerViewWithTime:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
