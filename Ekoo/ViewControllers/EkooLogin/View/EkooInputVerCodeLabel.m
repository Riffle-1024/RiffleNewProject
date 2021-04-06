//
//  EkooInputVerCodeLabel.m
//  Ekoo
//
//  Created by liuyalu on 2020/7/16.
//  Copyright © 2020 liuyalu. All rights reserved.
//

#import "EkooInputVerCodeLabel.h"
//设置边框宽度，值越大，边框越粗
#define ADAPTER_RATE_WIDTH 4
//设置是否有边框，等于 1 时 是下划线  大于1 的时候随着值越大，边框越大，
#define ADAPTER_RATE_HIDTH 1

@implementation EkooInputVerCodeLabel

//重写setText方法，当text改变时手动调用drawRect方法，将text的内容按指定的格式绘制到label上
- (void)setText:(NSString *)text {
    [super setText:text];
    // 手动调用drawRect方法
    [self setNeedsDisplay];
}

// 按照指定的格式绘制验证码/密码
- (void)drawRect:(CGRect)rect1 {
    //计算每位验证码/密码的所在区域的宽和高
    CGRect rect =CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    float width = rect.size.width / (float)self.numberOfVertificationCode;
    float height = rect.size.height;
    // 将每位验证码/密码绘制到指定区域
    for (int i =0; i <self.text.length; i++) {
        // 计算每位验证码/密码的绘制区域
        CGRect tempRect =CGRectMake(i * width,0, width, height);
        if (_secureTextEntry) {//密码，显示圆点
            UIImage *dotImage = [UIImage imageNamed:@"dot"];
            // 计算圆点的绘制区域
            CGPoint securityDotDrawStartPoint =CGPointMake(width * i + (width - dotImage.size.width) /2.0, (tempRect.size.height - dotImage.size.height) / 2.0);
            // 绘制圆点
            [dotImage drawAtPoint:securityDotDrawStartPoint];
        } else {//验证码，显示数字
            // 遍历验证码/密码的每个字符
            NSString *charecterString = [NSString stringWithFormat:@"%c", [self.text characterAtIndex:i]];
            // 设置验证码/密码的现实属性
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
            attributes[NSFontAttributeName] =self.font;
            attributes[NSForegroundColorAttributeName] = COLOR_EKOO;
            // 计算每位验证码/密码的绘制起点（为了使验证码/密码位于tempRect的中部，不应该从tempRect的重点开始绘制）
            // 计算每位验证码/密码的在指定样式下的size
            CGSize characterSize = [charecterString sizeWithAttributes:attributes];
            CGPoint vertificationCodeDrawStartPoint =CGPointMake(width * i + (width - characterSize.width) /2.0, (tempRect.size.height - characterSize.height) /2.0);
            // 绘制验证码/密码
            [charecterString drawAtPoint:vertificationCodeDrawStartPoint withAttributes:attributes];
        }
    }
    //绘制底部横线
    for (int k=0; k<self.numberOfVertificationCode; k++) {
        [self drawBottomLineWithRect:rect andIndex:k];
        [self drawSenterLineWithRect:rect andIndex:k];
    }
}

//绘制底部的线条
- (void)drawBottomLineWithRect:(CGRect)rect1 andIndex:(int)k{
    CGRect rect = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    float width = rect.size.width / (float)self.numberOfVertificationCode;
    float height = rect.size.height;
    //1.获取上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //2.设置当前上下问路径
    CGFloat lineHidth =0.15 * ADAPTER_RATE_WIDTH;
    CGFloat strokHidth =0.5 * ADAPTER_RATE_HIDTH;
    CGContextSetLineWidth(context, lineHidth);
    
    if ( k<=self.text.length ) {
        CGContextSetStrokeColorWithColor(context,COLOR_EKOO.CGColor);//底部颜色
        CGContextSetFillColorWithColor(context,COLOR_EKOO.CGColor);//内容的颜色
    }else{
        CGContextSetStrokeColorWithColor(context,COLOR_EKOO.CGColor);//底部颜色
        CGContextSetFillColorWithColor(context,COLOR_EKOO.CGColor);//内容的颜色
    }
    CGRect rectangle =CGRectMake(k*width+width/10,height-lineHidth-strokHidth,width-width/5,strokHidth);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}
//绘制中间的输入的线条
- (void)drawSenterLineWithRect:(CGRect)rect1 andIndex:(int)k{
    if ( k==self.text.length ) {
        CGRect rect = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
        float width = rect.size.width / (float)self.numberOfVertificationCode;
//        float height = rect.size.height;
//        //1.获取上下文
//        CGContextRef context =UIGraphicsGetCurrentContext();
//        CGContextSetLineWidth(context,0.5);
//        /****  设置竖线的颜色 ****/
//        CGContextSetStrokeColorWithColor(context,UIColorFromRGB(0xaaaaaa).CGColor);//
//        CGContextSetFillColorWithColor(context,UIColorFromRGB(0xaaaaaa).CGColor);
//        CGContextMoveToPoint(context, width * k + (width -1.0) /2.0, height/4);
//        CGContextAddLineToPoint(context,  width * k + (width -1.0) /2.0,height-height/4);
//        CGContextStrokePath(context);
        UIImage *image = [UIImage imageNamed:@"vertical_line"];
        if (!self.imageLayer) {
            self.imageLayer = [CALayer layer];
            [self.imageLayer addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
//            self.imageLayer.contents = (__bridge id _Nullable)(image.CGImage);
            self.imageLayer.backgroundColor = COLOR_EKOO.CGColor;
            [self.layer addSublayer:self.imageLayer];
        }
//        if (self.text.length < 2) {
//            self.imageLayer.frame = CGRectMake(self.frame.size.width/2, VIEW_FIT_TO_IPHONE6_VALUE(0),VIEW_FIT_TO_IPHONE6_VALUE(2), VIEW_FIT_TO_IPHONE6_VALUE(72.5));
//            self.imageLayer.hidden = NO;
//        }else{
            self.imageLayer.frame = CGRectMake(width/2*(2*k+1) - VIEW_FIT_TO_IPHONE6_VALUE(8), VIEW_FIT_TO_IPHONE6_VALUE(6),VIEW_FIT_TO_IPHONE6_VALUE(2), VIEW_FIT_TO_IPHONE6_VALUE(60));
            self.imageLayer.hidden = NO;
//        }
        
     
    }
    if (self.text.length == self.numberOfVertificationCode) {
        self.imageLayer.hidden = YES;
    }
        
    }

- (CABasicAnimation *)opacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.9;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}

@end
