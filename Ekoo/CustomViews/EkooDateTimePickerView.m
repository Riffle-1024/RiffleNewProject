//
//  EkooDateTimePickerView.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/17.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooDateTimePickerView.h"

@interface EkooDateTimePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger currentYear;//当年
    NSInteger currentMonth;//当月
    NSInteger currentDay;//当天
    NSInteger yearRange;//年范围
    NSInteger dayRange;//天范围
    NSInteger monthRange;//月范围
    
    NSInteger startYear;//开始的年份
    //选择的时间
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    NSCalendar *calendar;
    //要展示的时间
    NSInteger showYear;
    NSInteger showMonth;
    NSInteger showDay;
    NSInteger showdHour;
    NSInteger showMinute;
    NSInteger showSecond;
    //左边退出按钮
    UIButton *cancelButton;
    //右边的确定按钮
    UIButton *chooseButton;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UIView *bgView;


@end


@implementation EkooDateTimePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        self.alpha = 0;
        
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, 220)];
        contentV.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentV];
        self.contentV = contentV;
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 180)];
        self.pickerView.backgroundColor = [UIColor whiteColor]
        ;
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        self.pickerViewMode = DatePickerViewDateYearMonthDay;
        [contentV addSubview:self.pickerView];
        //盛放按钮的View
        UIView *upVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        upVeiw.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:upVeiw];
        //左边的取消按钮
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(12, 0, 40, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelButton setTitleColor:COLOR_EKOO_GRAY forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:cancelButton];
        
        //右边的确定按钮
        chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 52, 0, 40, 40);
        [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
        chooseButton.backgroundColor = [UIColor clearColor];
        chooseButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [chooseButton setTitleColor:COLOR_EKOO forState:UIControlStateNormal];
        [chooseButton addTarget:self action:@selector(configButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:chooseButton];
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame), 0, VIEW_WIDTH-104, 40)];
        [upVeiw addSubview:_titleL];
        _titleL.textColor = UIColorFromRGB(0x3f4548);
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textAlignment = NSTextAlignmentCenter;
        
        //分割线
        UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 0.5)];
        splitView.backgroundColor = UIColorFromRGB(0xe6e6e6);
        [upVeiw addSubview:splitView];
        
        
        NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
        NSInteger year=[comps year];
        
        startYear = year - 100;
        yearRange = 100;
        showYear = year - 18;
        showMonth= 10;
        showDay = 27;
//        [self setCurrentDateAndShowPickerView];
    }
    return self;
}


#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        return 6;
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        return 5;
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        return 3;
    }else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        return 2;
    } else if (self.pickerViewMode == DatePickerViewDateHourMinute) {
        return 2;
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        return 1;
    }
    return 0;
}


//确定每一列返回的东西
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return monthRange;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            case 3:
            {
                return 24;
            }
                break;
            case 4:
            {
                return 60;
            }
                break;
            case 5:
            {
                return 60;
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return monthRange;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
            case 3:
            {
                return 24;
            }
                break;
            case 4:
            {
                return 60;
            }
                break;
                
            default:
                break;
        }
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return monthRange;
            }
                break;
            case 2:
            {
                return dayRange;
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        switch (component) {
            case 0:
            {
                return yearRange;
            }
                break;
            case 1:
            {
                return monthRange;
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateHourMinute){
        switch (component) {
            case 0:
            {
                return 24;
            }
                break;
            case 1:
            {
                return 60;
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        switch (component) {
            case 0:
                return yearRange;
                break;
                
            default:
                break;
        }
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate
// 默认时间的处理
- (void)setCurrentDateAndShowPickerView
{
    
    NSDate * currentDate = [NSDate date];
   
    NSLog(@"dddddd = %@", currentDate);
    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar0 components:unitFlags fromDate:currentDate];
    NSInteger year = [comps year];
    currentYear = year;
    NSInteger month = [comps month];
    currentMonth = month;
    NSInteger day = [comps day];
    currentDay = day;
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    
//        selectedYear = year;
//        selectedMonth = month;
//        selectedDay = day;
//        selectedHour = hour;
//        selectedMinute = minute;
//        selectedSecond = second;
    
        //有需要展示的时间，进行处理
    
        dayRange = [self isAllDay:year andMonth:month];
       [self.pickerView reloadAllComponents];
    
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
//        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
//        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
//        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
//        [self.pickerView selectRow:hour inComponent:3 animated:NO];
//        [self.pickerView selectRow:minute inComponent:4 animated:NO];
//        [self.pickerView selectRow:second inComponent:5 animated:NO];
        
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        [self.pickerView selectRow:minute inComponent:4 animated:NO];
        [self.pickerView selectRow:second inComponent:5 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
        [self pickerView:self.pickerView didSelectRow:second inComponent:5];
        
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        [self.pickerView selectRow:minute inComponent:4 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
        
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
       [self.pickerView selectRow:showYear - startYear inComponent:0 animated:YES];
        [self.pickerView selectRow:showMonth inComponent:1 animated:YES];
        [self.pickerView selectRow:showDay inComponent:2 animated:YES];
        
        [self pickerView:self.pickerView didSelectRow:showYear - startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:showMonth inComponent:1];
        [self pickerView:self.pickerView didSelectRow:showDay inComponent:2];
    } else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        [self.pickerView selectRow:year - startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
    }   else if (self.pickerViewMode == DatePickerViewDateHourMinute) {
        [self.pickerView selectRow:hour inComponent:0 animated:NO];
        [self.pickerView selectRow:minute inComponent:1 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:hour inComponent:0];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:1];
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        [self.pickerView selectRow:year - startYear inComponent:0 animated:NO];
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
    }
     
}




-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDTH*component/6.0, 0,VIEW_WIDTH/6.0, 30)];
    label.font=[UIFont systemFontOfSize:15.0];
    label.tag=component*100+row;
    label.textAlignment=NSTextAlignmentCenter;
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 4:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
            case 5:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 4:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
            case 5:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
            }
                break;
                
            default:
                break;
        }
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        switch (component) {
            case 0:
            {
                label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:
            {
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:
            {
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateHourMinute){
        switch (component) {
            case 0:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 1:
            {
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
                
            default:
                break;
        }
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        switch (component) {
            case 0:
                label.text = [NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
                break;
                
            default:
                break;
        }
    }
    
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        return ([UIScreen mainScreen].bounds.size.width-40)/6;
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        return ([UIScreen mainScreen].bounds.size.width-40)/5;
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        return ([UIScreen mainScreen].bounds.size.width-40)/3;
    } else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        return ([UIScreen mainScreen].bounds.size.width-40)/2;
    } else if (self.pickerViewMode == DatePickerViewDateHourMinute){
        return ([UIScreen mainScreen].bounds.size.width-40)/2;
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        return [UIScreen mainScreen].bounds.size.width - 40;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange = [self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth = row+1;
                dayRange = [self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
            case 3:
            {
                selectedHour=row;
            }
                break;
            case 4:
            {
                selectedMinute=row;
            }
                break;
            case 5:
            {
                selectedSecond = row;
            }
                break;
                
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute,selectedSecond];
    } else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
            }
                break;
            case 3:
            {
                selectedHour=row;
            }
                break;
            case 4:
            {
                selectedMinute=row;
            }
                break;
                
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        switch (component) {
            case 0:
            {
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:1];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:
            {
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:
            {
                selectedDay=row+1;
                [self.pickerView reloadComponent:2];
            }
                break;
                
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",selectedYear,selectedMonth,selectedDay];
    } else if (self.pickerViewMode == DatePickerViewDateYearMonth) {
        switch (component) {
            case 0:
            {
                selectedYear = startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:0];
            }
                break;
            case 1:
            {
                selectedMonth = row + 1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:1];
            }
                break;
                
            default:
                break;
        }
        _string =[NSString stringWithFormat:@"%ld-%.2ld",selectedYear,selectedMonth];
    } else if (self.pickerViewMode == DatePickerViewDateHourMinute) {
        switch (component) {
            case 0:
            {
                selectedHour=row;
            }
                break;
            case 1:
            {
                selectedMinute=row;
            }
                break;
                
            default:
                break;
        }
        
        _string =[NSString stringWithFormat:@"%.2ld:%.2ld",selectedHour,selectedMinute];
    } else if (self.pickerViewMode == DatePickerViewDateYear) {
        switch (component) {
            case 0:
                selectedYear = startYear + row;
                dayRange = [self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:0];
                break;
                
            default:
                break;
        }
        _string = [NSString stringWithFormat:@"%ld", selectedYear];
    }
}


-(void)setStartTime:(NSString *)startTime{
    startYear = [startTime intValue];
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar0 components:unitFlags fromDate:[NSDate now]];
    NSInteger year = [comps year];
    yearRange = year - startYear + 1;
    showYear = year - 18;

}


-(void)setShowTime:(NSString *)showTime{
    _showTime = showTime;

    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar0 components:unitFlags fromDate:[NSDate now]];
    NSInteger year = [comps year];
    currentYear = year;
    NSInteger month = [comps month];
    currentMonth = month;
    NSInteger day = [comps day];
    NSArray  *timeArray = [showTime componentsSeparatedByString:@"-"];
    if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinuteSecond) {
        selectedYear =  [[timeArray objectAtIndex:0] intValue];
        selectedMonth = [[timeArray objectAtIndex:1] intValue];
        selectedDay = [[timeArray objectAtIndex:2] intValue];
        selectedHour = [[timeArray objectAtIndex:3] intValue];
        selectedMinute = [[timeArray objectAtIndex:4] intValue];
        selectedSecond = [[timeArray objectAtIndex:5] intValue];
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDayHourMinute) {
        selectedYear = [[timeArray objectAtIndex:0] intValue];
        selectedMonth = [[timeArray objectAtIndex:1] intValue];
        selectedDay = [[timeArray objectAtIndex:2] intValue];
        selectedHour = [[timeArray objectAtIndex:3] intValue];
        selectedMinute = [[timeArray objectAtIndex:4] intValue];
    }else if (self.pickerViewMode == DatePickerViewDateYearMonthDay){
        showYear =  [[timeArray objectAtIndex:0] intValue];
        showMonth = [[timeArray objectAtIndex:1] intValue] - 1;
        showDay = [[timeArray objectAtIndex:2] intValue] - 1;
    }else if (self.pickerViewMode == DatePickerViewDateYearMonth){
        selectedYear = [[timeArray objectAtIndex:0] intValue];
        selectedMonth = [[timeArray objectAtIndex:1] intValue];
    }else if (self.pickerViewMode == DatePickerViewDateHourMinute){
        selectedDay = [[timeArray objectAtIndex:0] intValue];
        selectedHour = [[timeArray objectAtIndex:1] intValue] - 1;
        selectedMinute = [[timeArray objectAtIndex:2] intValue] - 1;
    }else if (self.pickerViewMode == DatePickerViewDateYear){
        selectedYear = [[timeArray objectAtIndex:0] intValue];

    }
}
    

#pragma mark -- show and hidden
- (void)showDateTimePickerViewWithTime:(NSString *)time {

    if (self.showTime) {
//        [self performSelector:@selector(setCurrentDateAndShowPickerView) withObject:nil afterDelay:3];
        
    }else{
        [self setCurrentDateAndShowPickerView];
    }
    [self setCurrentDateAndShowPickerView];
    self.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
        self->_contentV.frame = CGRectMake(0, VIEW_HEIGHT - 220, VIEW_WIDTH, 220);
    } completion:^(BOOL finished) {
    }];
   
}

-(void)delayFrelshPickerView{
    
}

- (void)hideDateTimePickerView {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0;
        self->_contentV.frame = CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, 220);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT);
    }];
}
#pragma mark - private
// 取消的隐藏
- (void)cancelButtonClick
{
    [self hideDateTimePickerView];
}

//确认的隐藏
- (void)configButtonClick
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickFinishDateTimePickerView:)]) {
        [self.delegate didClickFinishDateTimePickerView:_string];
    }
    [self hideDateTimePickerView];
}

- (NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    if (year == currentYear) {
           monthRange =  currentMonth;
       }else{
           monthRange =  12;
       }
    if (year == currentYear && month == currentMonth) {
        return currentDay;
    }
    
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideDateTimePickerView];
}


@end
