//
//  LSActivityLabel.m
//  LoveShang
//
//  Created by zhudong on 13-11-24.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSActivityLabel.h"

@implementation LSActivityLabel

- (id)initWithFrame:(CGRect)frame style:(TTActivityLabelStyle)style text:(NSString *)text {
    if (self = [super initWithFrame:frame style:style text:text]) {
        _label.font = [UIFont boldSystemFontOfSize:18];
        _label.textColor = RGBCOLOR(183, 183, 183);
        _label.shadowColor = [UIColor colorWithWhite:1 alpha:0.7];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.shadowOffset = CGSizeMake(0, 1);
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
