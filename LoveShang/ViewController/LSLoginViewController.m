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
#import "LSAccountInfoCell.h"

@interface LSLoginViewController(){

}
@property (nonatomic,strong) LSLoginView *loginView;
@property (nonatomic,strong) NSDictionary *accountInfo;
@property (nonatomic,strong) NSMutableArray *userNameArray;
@property (nonatomic,assign) BOOL isAccountViewShow;
@property (nonatomic,assign) NSInteger tableHeight;
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
    _loginView.accountInfoView.dataSource = self;
    _loginView.accountInfoView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self initAccountInfo];
}

-(void)initAccountInfo{
    _isAccountViewShow = NO;
    _accountInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"accountInfo"];
    if ([_accountInfo count] == 1) {
        _loginView.userNameField.text = [[_accountInfo allKeys] objectAtIndex:0];
        _loginView.passwordField.text = [_accountInfo objectForKey:[[_accountInfo allKeys] objectAtIndex:0]];
    } else if ([_accountInfo count] > 1) {
        
        _loginView.userNameField.frame = CGRectMake(_loginView.userNameField.left, _loginView.userNameField.top, 200,_loginView.userNameField.height);
        [_loginView.showAccountBtn addTarget:self action:@selector(showAccountAction) forControlEvents:UIControlEventTouchUpInside];
        _loginView.showAccountBtn.hidden = NO;
        NSInteger i = 0;
        _userNameArray = [[NSMutableArray alloc] init];
        for (NSString *key in [_accountInfo allKeys]) {
            if (i == 0){
                i++;
                continue;
            }
            [_userNameArray addObject:key];
        }
        _tableHeight = [_userNameArray count] == 1 ? 40 : 80;
        [_loginView.accountInfoView reloadData];
    }
}

-(void)showAccountAction{
    if (_isAccountViewShow == NO) {
        _isAccountViewShow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _loginView.accountInfoView.hidden = NO;
            _loginView.accountInfoView.frame = CGRectMake(17/2, _loginView.userNameView.bottom, 303, _tableHeight);
            _loginView.passwordView.frame = CGRectMake(17/2, _loginView.userNameView.bottom+_loginView.accountInfoView.height, 312, 101/2);
            _loginView.forgetPasswordBtn.frame = CGRectMake(320 - 90, _loginView.passwordView.bottom +13, 90, 13);
            _loginView.registerBtn.frame = CGRectMake(17/2, _loginView.passwordView.bottom + 54, 147, 42);
            _loginView.loginBtn.frame = CGRectMake(_loginView.registerBtn.right + 8, _loginView.registerBtn.top, 147, 42);
        }];
    } else {
        _isAccountViewShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _loginView.accountInfoView.frame = CGRectMake(17/2, _loginView.userNameView.bottom, 303, 0);
            _loginView.passwordView.frame = CGRectMake(17/2, _loginView.userNameView.bottom, 312, 101/2);
            _loginView.forgetPasswordBtn.frame = CGRectMake(320 - 90, _loginView.passwordView.bottom +13, 90, 13);
            _loginView.registerBtn.frame = CGRectMake(17/2, _loginView.passwordView.bottom + 54, 147, 42);
            _loginView.loginBtn.frame = CGRectMake(_loginView.registerBtn.right + 8, _loginView.registerBtn.top, 147, 42);
        }];
        [self performSelector:@selector(hiddenAccountInfoView) withObject:nil afterDelay:0.5];
    }
    _loginView.showAccountBtn.transform = CGAffineTransformMakeScale(1.0,_isAccountViewShow?-1.0:1.0);
}

-(void)hiddenAccountInfoView{
    _loginView.accountInfoView.hidden = YES;
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
            NSDictionary *accountInfos = [[NSUserDefaults standardUserDefaults] objectForKey:@"accountInfo"];
            NSMutableDictionary *updateAccountInfos = [[NSMutableDictionary alloc] init];
            if ([accountInfos count] > 0) {
                for (NSString *key in [accountInfos allKeys]) {
                    if ([key isEqualToString:_loginView.userNameField.text]) {
                        continue;
                    } else {
                        [updateAccountInfos setObject:[accountInfos objectForKey:key] forKey:key];
                    }
                }
            }
            [updateAccountInfos setObject:_loginView.passwordField.text forKey:_loginView.userNameField.text];
            [[NSUserDefaults standardUserDefaults] setObject:updateAccountInfos forKey:@"accountInfo"];
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


#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_userNameArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"accountCell";
    LSAccountInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LSAccountInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.userNameLabel.text =  [_userNameArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma UITableVeiwDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _loginView.userNameField.text = [_userNameArray objectAtIndex:indexPath.row];
    _loginView.passwordField.text = [_accountInfo objectForKey:[_userNameArray objectAtIndex:indexPath.row]];
    [self showAccountAction];
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
