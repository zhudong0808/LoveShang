//
//  LSLoginView.m
//  LoveShang
//
//  Created by zhudong on 14-2-7.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSLoginView.h"
#import "LSViewUtil.h"

@interface LSLoginView(){}

@end

@implementation LSLoginView

@synthesize userNameField = _userNameField;
@synthesize passwordField = _passwordField;
@synthesize forgetPasswordBtn = _forgetPasswordBtn;
@synthesize registerBtn = _registerBtn;
@synthesize loginBtn = _loginBtn;

-(LSLoginView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        superView.backgroundColor = [UIColor whiteColor];
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0003_爱上网logo(不带张家港).png"]];
        logoView.frame = CGRectMake(320/2 - 215/4, 44+23, 215/2, 83/2);
        [superView addSubview:logoView];
        
        UIImageView *userNameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0005_账号.png"]];
        userNameView.frame = CGRectMake(17/2, logoView.bottom+33/2, 303, 87/2);
        userNameView.userInteractionEnabled = YES;
        [superView addSubview:userNameView];
        
        UILabel *userNameLabel = [LSViewUtil simpleLabel:CGRectMake(10, 44/2-22/2, 40, 22) f:17 tc:RGBCOLOR(0x9d, 0x9d, 0x9d) t:@"账号"];
        [userNameView addSubview:userNameLabel];
        
        _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(userNameLabel.right + 10, userNameLabel.top, 320 - userNameLabel.right-30, 22)];
        _userNameField.font = [UIFont systemFontOfSize:17];
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [userNameView addSubview:_userNameField];
        
        UIImageView *passwordView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0000_登陆密码.png"]];
        passwordView.frame = CGRectMake(17/2, userNameView.bottom, 312, 101/2);
        passwordView.userInteractionEnabled = YES;
        [superView addSubview:passwordView];
        
        UILabel *passwordLabel = [LSViewUtil simpleLabel:CGRectMake(10, 44/2-22/2, 40, 22) f:17 tc:RGBCOLOR(0x9d, 0x9d, 0x9d) t:@"密码"];
        [passwordView addSubview:passwordLabel];
        
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right + 10 , passwordLabel.top, 320 - passwordLabel.right - 30, 22)];
        _passwordField.font = [UIFont systemFontOfSize:17];
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordField.secureTextEntry = YES;
        [passwordView addSubview:_passwordField];
        
        _forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(320 - 90, passwordView.bottom +13, 90, 13)];
        [_forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:RGBCOLOR(0x87, 0x87, 0x87) forState:UIControlStateNormal];
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [superView addSubview:_forgetPasswordBtn];
        
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(17/2, passwordView.bottom + 54, 147, 42)];
        [_registerBtn setImage:[UIImage imageNamed:@"_0002_注册.png"] forState:UIControlStateNormal];
        [superView addSubview:_registerBtn];
        
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(_registerBtn.right + 8, _registerBtn.top, 147, 42)];
        [_loginBtn setImage:[UIImage imageNamed:@"_0001_登陆.png"] forState:UIControlStateNormal];
        [superView addSubview:_loginBtn];
        
    }
    return self;
}
@end
