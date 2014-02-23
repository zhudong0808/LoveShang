//
//  LSWebViewController.m
//  LoveShang
//
//  Created by zhudong on 14-2-18.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSWebViewController.h"

@interface LSWebViewController ()

@property (nonatomic,strong) NSString *url;

@end

@implementation LSWebViewController

-(id)initWithUrl:(NSString *)url{
    if (self = [super init]) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarWebView;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, APP_CONTENT_HEIGHT-44)];
    [self.cView addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
}

#pragma LSCommonToolBarDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
