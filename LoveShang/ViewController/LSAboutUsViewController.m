//
//  LSAboutUsViewController.m
//  LoveShang
//
//  Created by zhudong on 14-4-2.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSAboutUsViewController.h"

@interface LSAboutUsViewController ()

@end

@implementation LSAboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarAboutUs;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(12, 70, 320-12, 200)];
    textView.font = [UIFont systemFontOfSize:20];
    textView.text = @"Q：密码忘记了这么办？\nA：目前手机客户端不支持找回密码功能，请到网页版爱上网通过注册手机号找回，或联系客户QQ:2355665550";
    [self.view addSubview:textView];
}

#pragma LSCommonToolbarDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
