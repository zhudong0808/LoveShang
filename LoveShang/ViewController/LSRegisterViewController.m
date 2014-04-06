//
//  LSRegisterViewController.m
//  LoveShang
//
//  Created by zhudong on 13-12-29.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSRegisterViewController.h"
#import "LSRegisterView.h"
#import "LSGlobal.h"

@interface LSRegisterViewController(){

}
@property (nonatomic,strong) LSRegisterView *registerView;

@end

@implementation LSRegisterViewController

-(void)viewDidLoad{
    self.commonToolBarType = LSCommonToolbarRegister;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _registerView = [[LSRegisterView alloc] initWithSuperView:self.cView];
    _registerView.mobileField.delegate = self;
    _registerView.veriCodeField.delegate = self;
    
    [_registerView.mobileBtn addTarget:self action:@selector(getVeriCode) forControlEvents:UIControlEventTouchUpInside];
    [_registerView.registerBtn addTarget:self action:@selector(submitRegister) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (self.registerView.mainInfoBox.hidden == YES) {
        __block __unsafe_unretained LSRegisterViewController *blockSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            blockSelf.registerView.wapperView.frame = CGRectMake(0, 44, 320, APP_CONTENT_HEIGHT - 44);
        }];
        [self performSelector:@selector(showMainInfoBox) withObject:nil afterDelay:0.3];
    }
}

-(void)showMainInfoBox{
    self.registerView.mainInfoBox.hidden = NO;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    __block __unsafe_unretained LSRegisterViewController *blockSelf = self;
    if (textField == _registerView.mobileField || textField == _registerView.veriCodeField) {
        [UIView animateWithDuration:0.3 animations:^{
            blockSelf.registerView.mainInfoBox.hidden = YES;
            blockSelf.registerView.wapperView.frame = CGRectMake(0, -101, 320, blockSelf.registerView.wapperView.height);
        }];
    }
}

-(void)getVeriCode{
    NSString *urlPath = [NSString stringWithFormat:@"user.php?action=registerSms&mobile=%@&debug=1",_registerView.mobileField.text];
    [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            [LSGlobal showProgressHUD:@"验证码发送成功" duration:2.0];
        } else {
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"验证码发送失败";
            [LSGlobal showFailedView:errorMsg];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        [LSGlobal showFailedView:@"验证码发送失败"];
//        NSLog(@"%@",error);
    }];
}

-(void)submitRegister{
    if ([self checkField] == false) {
        return;
    }
    NSString *urlPath = [NSString stringWithFormat:@"user.php?action=register&username=%@&password=%@&repassword=%@&mobile=%@&mobileverify=%@",[LSGlobal encodeWithString:_registerView.usernameField.text],_registerView.passwordField.text,_registerView.checkPasswordField.text,_registerView.mobileField.text,_registerView.veriCodeField.text];
    [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[responseObject objectForKey:@"encryptString"] forKey:@"encryptString"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"注册失败";
            [LSGlobal showFailedView:errorMsg];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        [LSGlobal showFailedView:@"注册失败"];
    }];
}

-(BOOL)checkField{
    if ([_registerView.usernameField.text length] == 0) {
        [LSGlobal showFailedView:@"用户名不能为空"];
        return false;
    }
    if ([_registerView.passwordField.text length] == 0) {
        [LSGlobal showFailedView:@"密码不能为空"];
        return false;
    }
    if (![_registerView.passwordField.text isEqualToString:_registerView.checkPasswordField.text]) {
        [LSGlobal showFailedView:@"密码不一致"];
        return false;
    }
    if ([_registerView.mobileField.text length] == 0) {
        [LSGlobal showFailedView:@"手机号码不能为空"];
        return false;
    }
    if ([_registerView.veriCodeField.text length] == 0) {
        [LSGlobal showFailedView:@"验证码不能为空"];
        return false;
    }
    return true;
}

#pragma LSCommonToolbarDelegate
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}

-(void)dealloc{
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}

@end
