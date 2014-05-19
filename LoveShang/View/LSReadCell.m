//
//  LSReadCell.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSReadCell.h"
#import "LSViewUtil.h"
#import "UIImageView+WebCache.h"

@interface LSReadCell(){
}

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *userIconView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userPostdateLabel;
@property (nonatomic,strong) UILabel *userFloorLabel;
@property (nonatomic,strong) NSDictionary *contentData;
@property (nonatomic,strong) UIButton *reportBtn;

@end

@implementation LSReadCell

@synthesize webView = _webView;
@synthesize identifer = _identifer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        
//        UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0005_分割线.png"]];
//        lineView.frame = CGRectMake(0, 99, 320, 1);
//        [self.contentView addSubview:lineView];
        
        UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(15, 11, 320-30, 36)];
        userInfoView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:userInfoView];
        
        _userIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
        _userIconView.frame = CGRectMake(0, 0, 36, 36);
        [userInfoView addSubview:_userIconView];
        
        _userNameLabel = [LSViewUtil simpleLabel:CGRectMake(42, 0, 100, 20) f:15 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@""];
        [userInfoView addSubview:_userNameLabel];
        
        _userPostdateLabel = [LSViewUtil simpleLabel:CGRectMake(42, 26, 200, 10) f:10 tc:RGBCOLOR(0x6d, 0x6e, 0x71) t:@""];
        [userInfoView addSubview:_userPostdateLabel];
        
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportBtn.frame = CGRectMake(320-30-20, 0, 30, 10);
        _reportBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [_reportBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        [_reportBtn addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];
        [userInfoView addSubview:_reportBtn];
        
        
        _userFloorLabel = [LSViewUtil simpleLabel:CGRectMake(320-30-20, 36/2-10/2, 30, 10) f:10 tc:RGBCOLOR(0x9c, 0xbd, 0x4b) t:@"111"];
        [userInfoView addSubview:_userFloorLabel];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 58, 320-10, 10)];
        _webView.backgroundColor = [UIColor clearColor];
        [_webView setOpaque:NO];
        _webView.scrollView.scrollEnabled = NO;
        _webView.allowsInlineMediaPlayback = YES;
        _webView.alpha = 0;
        [self.contentView addSubview:_webView];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height-1, 320, 1)];
        _line.backgroundColor = RGBCOLOR(0xcf, 0xcf, 0xcf);
        _line.hidden = YES;
        [self.contentView addSubview:_line];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    _contentData = data;
    [_userIconView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[data objectForKey:@"faceurl"]]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    _userNameLabel.text = [data objectForKey:@"author"];
    _userPostdateLabel.text = [data objectForKey:@"postdate"];
    _userFloorLabel.text = [data objectForKey:@"lou"];
    NSString *imagePath = [[NSBundle mainBundle] resourcePath];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *baseUrl = [NSURL URLWithString:
                      [NSString stringWithFormat:@"file:/%@//",imagePath]];
    [_webView loadHTMLString:[data objectForKey:@"content"] baseURL:baseUrl];
}

-(void)report{
    NSString *pid = [_contentData objectForKey:@"pid"] ? : @"0";
    [self.delegate report:pid];
}


@end
