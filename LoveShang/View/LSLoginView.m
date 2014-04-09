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
@synthesize passwordView = _passwordView;
@synthesize showAccountBtn = _showAccountBtn;
@synthesize accountInfoView = _accountInfoView;

-(LSLoginView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        superView.backgroundColor = [UIColor whiteColor];
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0003_爱上网logo(不带张家港).png"]];
        logoView.frame = CGRectMake(320/2 - 215/4, 44+23, 215/2, 83/2);
        [superView addSubview:logoView];
        
        _userNameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0005_账号.png"]];
        _userNameView.frame = CGRectMake(17/2, logoView.bottom+33/2, 303, 87/2);
        _userNameView.userInteractionEnabled = YES;
        [superView addSubview:_userNameView];
        
        UILabel *userNameLabel = [LSViewUtil simpleLabel:CGRectMake(10, 44/2-22/2, 40, 22) f:17 tc:RGBCOLOR(0x9d, 0x9d, 0x9d) t:@"账号"];
        [_userNameView addSubview:userNameLabel];
        
        _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(userNameLabel.right + 10, userNameLabel.top, 320 - userNameLabel.right-30, 22)];
        _userNameField.font = [UIFont systemFontOfSize:17];
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_userNameView addSubview:_userNameField];
        
        _showAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showAccountBtn.frame = CGRectMake(_userNameView.width-37, _userNameView.height/2-23/4, 37/2, 23/2);
        [_showAccountBtn setImage:[UIImage imageNamed:@"_0000_图层-7.png"] forState:UIControlStateNormal];
        _showAccountBtn.hidden = YES;
        [_userNameView addSubview:_showAccountBtn];
        
        _passwordView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0000_登陆密码.png"]];
        _passwordView.frame = CGRectMake(17/2, _userNameView.bottom, 312, 101/2);
        _passwordView.userInteractionEnabled = YES;
        [superView addSubview:_passwordView];
        
        
        _accountInfoView = [[UITableView alloc] initWithFrame:CGRectMake(17/2, _userNameView.bottom, 303, 0)];
        _accountInfoView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _accountInfoView.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
        _accountInfoView.hidden = YES;
        [superView insertSubview:_accountInfoView belowSubview:_passwordView];
        
        UILabel *passwordLabel = [LSViewUtil simpleLabel:CGRectMake(10, 44/2-22/2, 40, 22) f:17 tc:RGBCOLOR(0x9d, 0x9d, 0x9d) t:@"密码"];
        [_passwordView addSubview:passwordLabel];
        
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right + 10 , passwordLabel.top, 320 - passwordLabel.right - 30, 22)];
        _passwordField.font = [UIFont systemFontOfSize:17];
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordField.secureTextEntry = YES;
        [_passwordView addSubview:_passwordField];
        
        _forgetPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(320 - 90, _passwordView.bottom +13, 90, 13)];
        [_forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:RGBCOLOR(0x87, 0x87, 0x87) forState:UIControlStateNormal];
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [superView addSubview:_forgetPasswordBtn];
        
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(17/2, _passwordView.bottom + 54, 147, 42)];
        [_registerBtn setImage:[UIImage imageNamed:@"_0002_注册.png"] forState:UIControlStateNormal];
        [superView addSubview:_registerBtn];
        
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(_registerBtn.right + 8, _registerBtn.top, 147, 42)];
        [_loginBtn setImage:[UIImage imageNamed:@"_0001_登陆.png"] forState:UIControlStateNormal];
        [superView addSubview:_loginBtn];
        
    }
    return self;
}
@end
