//
//  LSLoginViewController.m
//  LoveShang
//
//  Created by zhudong on 14-2-7.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSLoginViewController.h"
#import "LSLoginView.h"
#import "LSGlobal.h"

@interface LSLoginViewController(){

}
@property (nonatomic,strong) LSLoginView *loginView;

@end

@implementation LSLoginViewController

-(void)viewDidLoad{
    self.commonToolBarType = LSCommonToolbarLogin;
    self.showCommonBar = YES;
    _loginView = [[LSLoginView alloc] initWithSuperView:self.cView];
    [_loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)loginAction{
    if ([self checkField] == false) {
        return;
    }
    NSString *urlPath = [NSString stringWithFormat:@"user.php?action=login&username=%@&password=%@",[LSGlobal encodeWithString:_loginView.userNameField.text],[LSGlobal encodeWithString:_loginView.passwordField.text]];
    [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[responseObject objectForKey:@"encryptString"] forKey:@"encryptString"];
            //TODO 调转至登录成功页面
        } else {
            NSLog(@"%@",responseObject);
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"登录失败";
            [LSGlobal showFailedView:errorMsg];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        [LSGlobal showFailedView:@"登录失败"];
    }];
}

-(void)registerAction{

}

-(void)forgetPasswordAction{
    
}

-(BOOL)checkField{
    if ([_loginView.userNameField.text length] == 0) {
        [LSGlobal showFailedView:@"用户名不能为空"];
        return false;
    }
    if ([_loginView.passwordField.text length] == 0) {
        [LSGlobal showFailedView:@"密码不能为空"];
        return false;
    }
    return true;
}
@end
