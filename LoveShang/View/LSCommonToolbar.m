//
//  LSCommonToolbar.m
//  LoveShang
//
//  Created by zhudong on 13-10-21.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSCommonToolbar.h"

@implementation LSCommonToolbar

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        logoView.image = [UIImage imageNamed:@"logo1.png"];
        [self addSubview:logoView];
    }
    return self;
}

@end
