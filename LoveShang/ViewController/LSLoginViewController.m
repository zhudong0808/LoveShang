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
#import "SFHFKeychainUtils.h"
#import "LSMyViewController.h"
#import "LSRegisterViewController.h"

@interface LSLoginViewController(){

}
@property (nonatomic,strong) LSLoginView *loginView;

@end

@implementation LSLoginViewController

@synthesize completion = _completion;

-(void)viewDidLoad{
    self.commonToolBarType = LSCommonToolbarLogin;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    _loginView = [[LSLoginView alloc] initWithSuperView:self.cView];
    [_loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)loginAction{
    [_loginView.loginBtn setEnabled:NO];
    if ([self checkField] == false) {
        return;
    }
    NSString *urlPath = [NSString stringWithFormat:@"user.php?action=login&username=%@&password=%@",[LSGlobal encodeWithString:_loginView.userNameField.text],[LSGlobal encodeWithString:_loginView.passwordField.text]];
    __unsafe_unretained __block LSLoginViewController *blockSelf = self;
    [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            [SFHFKeychainUtils storeUsername:keyChainEncryptString andPassword:[[responseObject objectForKey:@"info"] objectForKey:@"encryptString"] forServiceName:keyChainServiceName updateExisting:YES error:nil];
            blockSelf.loginView.loginBtn.enabled = YES;
            blockSelf.completion(YES);
        } else {
            [blockSelf.loginView.loginBtn setEnabled:YES];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"登录失败";
            [LSGlobal showFailedView:errorMsg];
            LSMyViewController *vc = [[LSMyViewController alloc] init];
            [blockSelf.navigationController popViewControllerAnimated:NO];
            [blockSelf.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        [_loginView.loginBtn setEnabled:YES];
//        [LSGlobal showFailedView:@"登录失败"];
    }];
}

#pragma LSCommonToolbarDelegate
-(void)backAction{
    [_loginView.loginBtn setEnabled:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)registerAction{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registerNotification" object:nil];
    }];
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

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}

-(void)dealloc{
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}
@end
