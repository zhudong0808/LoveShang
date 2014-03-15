//
//  LSViewUtil.m
//  LoveShang
//
//  Created by zhudong on 13-12-15.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSViewUtil.h"

@implementation LSViewUtil

+(UILabel *)simpleLabel:(CGRect)frame f:(int)size tc:(UIColor *)color t:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:size]];
    label.textColor = color;
    label.text = text;
    
    return label;
}
+(UILabel *)simpleLabel:(CGRect)frame bf:(int)size tc:(UIColor *)color t:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:size]];
    label.textColor = color;
    label.text = text;
    
    return label;
}

+(BOOL)isRetina{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4)
    {
        return  NO;
    }
    else
    {
        return [[UIScreen mainScreen] scale] > 1;
    }
}

+(void)drawLine:(CGRect)frame onView:(UIView *)pView color:(UIColor *)color{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    if (![LSViewUtil isRetina]) {
        line.width = line.width<1?1:line.width;
        line.height = line.height<1?1:line.height;
    }
    line.backgroundColor = color;
    [pView addSubview:line];
}
@end
