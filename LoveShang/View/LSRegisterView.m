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

@synthesize wapperView = _wapperView;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize checkPasswordField = _checkPasswordField;
@synthesize mobileField = _mobileField;
@synthesize mobileBtn = _mobileBtn;
@synthesize veriCodeField = _veriCodeField;
@synthesize registerBtn = _registerBtn;
@synthesize protocolBtn = _protocolBtn;

-(LSRegisterView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        
        _wapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, APP_CONTENT_HEIGHT - 44)];
        [superView addSubview:_wapperView];
        
        _mainInfoBox = [[UIImageView alloc] initWithFrame:CGRectMake(9, 12, 320 - 9*2, 133)];
        _mainInfoBox.image = [UIImage imageNamed:@"_0004_圆角矩形-4.png"];
        _mainInfoBox.userInteractionEnabled = YES;
        [_wapperView addSubview:_mainInfoBox];
        
        UIView *usernameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        usernameView.backgroundColor = [UIColor clearColor];
        [_mainInfoBox addSubview:usernameView];
        
        UILabel *usernameTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"账      号"];
        [usernameView addSubview:usernameTitleLabel];
        
        _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(75, usernameTitleLabel.top+1, 320-75-12-20, 14)];
        _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [usernameView addSubview:_usernameField];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 43, 300, 1)];
        line1.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [usernameView addSubview:line1];
        
        
        UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 300, 44)];
        passwordView.backgroundColor = [UIColor clearColor];
        [_mainInfoBox addSubview:passwordView];
        
        UILabel *passwordTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"密      码"];
        [passwordView addSubview:passwordTitleLabel];
        
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(75, passwordTitleLabel.top, 320-75-12-20, 14)];
        _passwordField.secureTextEntry = YES;
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [passwordView addSubview:_passwordField];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 43, 300, 1)];
        line2.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [passwordView addSubview:line2];
        
        UIView *checkPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 44*2, 300, 44)];
        checkPasswordView.backgroundColor = [UIColor clearColor];
        [_mainInfoBox addSubview:checkPasswordView];
        
        UILabel *checkPasswordTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"确认密码"];
        [checkPasswordView addSubview:checkPasswordTitleLabel];
        
        _checkPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(75, checkPasswordTitleLabel.top, 320-75-12-20, 14)];
        _checkPasswordField.secureTextEntry = YES;
        _checkPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [checkPasswordView addSubview:_checkPasswordField];
        
        UIImageView *mobileView = [[UIImageView alloc] initWithFrame:CGRectMake(9, _mainInfoBox.bottom + 15, 320 - 2*9, 44)];
        mobileView.image = [UIImage imageNamed:@"_0003_圆角矩形-5.png"];
        mobileView.userInteractionEnabled = YES;
        [_wapperView addSubview:mobileView];
        
        _mobileField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, 320-2*9-82-12, 44)];
        _mobileField.keyboardType = UIKeyboardTypeNumberPad;
        _mobileField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [mobileView addSubview:_mobileField];
        
        _mobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mobileBtn.frame = CGRectMake(_mobileField.right, 0, 82, 44);
        [_mobileBtn setImage:[UIImage imageNamed:@"_0002_获取验证.png"] forState:UIControlStateNormal];
        [mobileView addSubview:_mobileBtn];
        
        UIImageView *veriCodeView = [[UIImageView alloc] initWithFrame:CGRectMake(9, mobileView.bottom +15, 320 - 2*9, 44)];
        veriCodeView.image = [UIImage imageNamed:@"_0003_圆角矩形-5.png"];
        veriCodeView.userInteractionEnabled = YES;
        [_wapperView addSubview:veriCodeView];
        
        UILabel *veriCodeTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 44/2-14/2, 56, 14) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"验 证 码"];
        [veriCodeView addSubview:veriCodeTitleLabel];
        
        _veriCodeField = [[UITextField alloc] initWithFrame:CGRectMake(75, veriCodeTitleLabel.top, 320-75-12-20, 14)];
        _veriCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [veriCodeView addSubview:_veriCodeField];
        
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(9, veriCodeView.bottom + 30, 320 - 2*9, 95/2);
        [_registerBtn setImage:[UIImage imageNamed:@"_0000_注册-.png"] forState:UIControlStateNormal];
        [_wapperView addSubview:_registerBtn];
        
        
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolBtn.frame = CGRectMake(9, _registerBtn.bottom + 10, 180, 20);
        _protocolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _protocolBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_protocolBtn setTitle:@"注册即同意爱上网用户协议" forState:UIControlStateNormal];
        [_protocolBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_wapperView addSubview:_protocolBtn];
        
    }
    return self;
}

@end
