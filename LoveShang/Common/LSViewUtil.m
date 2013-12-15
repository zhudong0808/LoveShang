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
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.text = text;
    
    return label;
}
+(UILabel *)simpleLabel:(CGRect)frame bf:(int)size tc:(UIColor *)color t:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = color;
    label.text = text;
    
    return label;
}

@end
