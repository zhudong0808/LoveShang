//
//  LSCommonToolbar.m
//  LoveShang
//
//  Created by zhudong on 13-10-21.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSCommonToolbar.h"

@implementation LSCommonToolbar

-(id)initWithFrame:(CGRect)frame type:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        backgroundView.image = [UIImage imageNamed:@"common_toolbar_background.png"];
        [self addSubview:backgroundView];
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44/2 - 33/2, 87, 33)];
        logoView.image = [UIImage imageNamed:@"logo.png"];
        [self addSubview:logoView];
    }
    return self;
}

@end
