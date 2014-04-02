//
//  LSMyViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSMyViewController.h"
#import "LSMyView.h"
#import "LSApiClientService.h"
#import "LSAuthenticateCenter.h"
#import "LSGlobal.h"
#import "LSWebViewController.h"
#import "LSContactUsViewController.h"
#import "LSAboutUsViewController.h"
#import "LSRegisterViewController.h"

@interface LSMyViewController(){
}

@property (nonatomic,strong) LSMyView *myView;

@end

@implementation LSMyViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarMy;
    self.showCommonBar = YES;
    _myView = [[LSMyView alloc] initWithSuperView:self.cView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentRegisterVC) name:@"registerNotification" object:nil];
    [self setBtnAction];
    [self loadData];
}

-(void)loadData{
    LSAuthenticateCompletion completion = ^(BOOL success){
        NSString *urlPath = [NSString stringWithFormat:@"user.php?action=my&encryptString=%@",[LSAuthenticateCenter getEncryptString]];
        __unsafe_unretained __block LSMyViewController *blockSelf = self;
        [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
                [blockSelf.myView.userIconView setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"info"] objectForKey:@"face"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
                blockSelf.myView.userNameLabel.text = [[responseObject objectForKey:@"info"] objectForKey:@"username"];
                blockSelf.myView.userMobileLabel.text = [NSString stringWithFormat:@"认证手机号码：%@",[[responseObject objectForKey:@"info"] objectForKey:@"mobile"]];
            } else {
                NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"获取用户信息失败";
                [LSGlobal showFailedView:errorMsg];
            }
        } failure:^(AFHTTPRequestOperation *operation,NSError *error){
            [LSGlobal showFailedView:@"获取用户信息失败"];
        }];
    };
    [[LSAuthenticateCenter shareInstance] authenticateWithBlock:completion];
}

-(void)setBtnAction{
    [_myView.btn1 addTarget:self action:@selector(linkActionOne) forControlEvents:UIControlEventTouchUpInside];
    [_myView.btn2 addTarget:self action:@selector(linkActionTwo) forControlEvents:UIControlEventTouchUpInside];
    [_myView.btn3 addTarget:self action:@selector(linkActionSecond) forControlEvents:UIControlEventTouchUpInside];
    [_myView.loginoutBtn addTarget:self action:@selector(loginoutAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)linkActionOne{
    LSAboutUsViewController *vc = [[LSAboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)linkActionTwo{
    LSContactUsViewController *vc = [[LSContactUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)linkActionSecond{
    LSWebViewController *webView = [[LSWebViewController alloc] initWithUrl:@"http://www.loveshang.com/"];
    [self.navigationController pushViewController:webView animated:YES];
}

-(void)loginoutAction{
    [[LSAuthenticateCenter shareInstance] loginout];
    [LSGlobal showProgressHUD:@"退出成功" duration:1.0];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
}

-(void)presentRegisterVC{
    LSRegisterViewController *vc = [[LSRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
