//
//  LSContactUsViewController.m
//  LoveShang
//
//  Created by zhudong on 14-4-2.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSContactUsViewController.h"
#import "LSViewUtil.h"
#import "LSWebViewController.h"

@interface LSContactUsViewController ()

@end

@implementation LSContactUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarContactUs;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 70, 320-12, 90) f:20 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"爱上网手机客户端iphone版，是张家港爱上网针对iphone用户推出的一款集网站头条、论坛互动、身边优惠等功能为一体的应用。"];
    titleLabel.numberOfLines = 4;
    [self.view addSubview:titleLabel];
    UILabel *versionLabel = [LSViewUtil simpleLabel:CGRectMake(12, titleLabel.bottom + 10, 320-12, 20) f:20 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"软件版本：1.0"];
    [self.view addSubview:versionLabel];
    UILabel *phoneLabel = [LSViewUtil simpleLabel:CGRectMake(12, versionLabel.bottom + 10, 100, 20) f:20 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"客服电话："];
    [self.view addSubview:phoneLabel];
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(phoneLabel.right-30, phoneLabel.top, 200, 20);
    [phoneBtn setTitle:@"0512-58795805" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    
    UILabel *siteUrlLabel = [LSViewUtil simpleLabel:CGRectMake(12, phoneLabel.bottom + 10, 60, 20) f:20 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"网址："];
    [self.view addSubview:siteUrlLabel];
    
    UIButton *siteUrlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    siteUrlBtn.frame = CGRectMake(siteUrlLabel.right-10, siteUrlLabel.top, 200, 20);
    [siteUrlBtn setTitle:@"www.loveshang.com" forState:UIControlStateNormal];
    [siteUrlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [siteUrlBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [siteUrlBtn addTarget:self action:@selector(linkSite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:siteUrlBtn];
}

-(void)callPhone{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"拨打电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"0512-58795805" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

-(void)linkSite{
    LSWebViewController *webView = [[LSWebViewController alloc] initWithUrl:@"http://www.loveshang.com"];
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"0512-58795805"]];
    }
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
