//
//  LSRegisterView.m
//  LoveShang
//
//  Created by zhudong on 14-1-13.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSRegisterView.h"
#import "LSViewUtil.h"

@implementation LSRegisterView

-(LSRegisterView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        UIImageView *mainInfoBox = [[UIImageView alloc] initWithFrame:CGRectMake(9, 44+12, 320 - 9*2, 133)];
        mainInfoBox.image = [UIImage imageNamed:@"_0004_圆角矩形-4.png"];
        [superView addSubview:mainInfoBox];
        
        UIView *usernameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        usernameView.backgroundColor = [UIColor clearColor];
        [mainInfoBox addSubview:usernameView];
        
        UILabel *usernameTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"账      号"];
        [usernameView addSubview:usernameTitleLabel];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 43, 300, 1)];
        line1.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [usernameView addSubview:line1];
        
        
        UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 300, 44)];
        passwordView.backgroundColor = [UIColor clearColor];
        [mainInfoBox addSubview:passwordView];
        
        UILabel *passwordTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"密      码"];
        [passwordView addSubview:passwordTitleLabel];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 43, 300, 1)];
        line2.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [passwordView addSubview:line2];
        
        UIView *checkPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 44*2, 300, 44)];
        checkPasswordView.backgroundColor = [UIColor clearColor];
        [mainInfoBox addSubview:checkPasswordView];
        
        UILabel *checkPasswordTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"确认密码"];
        [checkPasswordView addSubview:checkPasswordTitleLabel];
        
    }
    return self;
}

@end
