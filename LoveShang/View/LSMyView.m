//
//  LSMyView.m
//  LoveShang
//
//  Created by zhudong on 14-2-13.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSMyView.h"
#import "LSViewUtil.h"

@implementation LSMyView

@synthesize userIconView = _userIconView;
@synthesize userNameLabel = _userNameLabel;
@synthesize userMobileLabel = _userMobileLabel;
@synthesize btn1 = _btn1;
@synthesize btn2 = _btn2;
@synthesize btn3 = _btn3;
@synthesize loginoutBtn = _loginoutBtn;


-(LSMyView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        UIImageView *userInfoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0011_圆角矩形-1.png"]];
        userInfoView.frame = CGRectMake(9, 59, 302, 89);
        [superView addSubview:userInfoView];
        
        UIImageView *userIconBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0003_圆角矩形-2.png"]];
        userIconBGView.frame = CGRectMake(15, 89/2-66/2, 66, 66);
        [userInfoView addSubview:userIconBGView];
        
        _userIconView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 60, 60)];
        [userIconBGView addSubview:_userIconView];
        
        _userNameLabel = [LSViewUtil simpleLabel:CGRectMake(userIconBGView.right + 10, 20, 100, 20) f:15 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@""];
        [userInfoView addSubview:_userNameLabel];
        
        _userMobileLabel = [LSViewUtil simpleLabel:CGRectMake(userIconBGView.right + 10 , 20+20+10, 302-(userIconBGView.right + 10), 15) f:13 tc:RGBCOLOR(0x00,0x00, 0x00) t:@""];
        [userInfoView addSubview:_userMobileLabel];
        
        UIImageView *messageBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0010_圆角矩形-3.png"]];
        messageBGView.frame = CGRectMake(9, userInfoView.bottom+15, 302, 44);
        [superView addSubview:messageBGView];
        
        UIImageView *messageIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0001_Bell.png"]];
        messageIcon.frame = CGRectMake(13, 44/2 - 20/2, 20, 20);
        [messageBGView addSubview:messageIcon];
        
        UILabel *messageTitleLabel = [LSViewUtil simpleLabel:CGRectMake(messageIcon.right + 14, 44/2 - 13/2, 80, 13) f:13 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"消息推送"];
        [messageBGView addSubview:messageTitleLabel];
        
        UIImageView *linkInfoBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0009_圆角矩形-4.png"]];
        linkInfoBGView.frame = CGRectMake(9, messageBGView.bottom + 13, 301, 132);
        linkInfoBGView.userInteractionEnabled = YES;
        [superView addSubview:linkInfoBGView];
        
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.frame = CGRectMake(0, 0, 301, 43);
        [linkInfoBGView addSubview:_btn1];
        
        UIImageView *iconView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0001_圆角矩形-5.png"]];
        iconView1.frame = CGRectMake(10, 43/2 - 22/2, 22, 22);
        [_btn1 addSubview:iconView1];
        
        UILabel *titleLabel1 = [LSViewUtil simpleLabel:CGRectMake(iconView1.right+13, 43/2-16/2, 150, 15) f:15 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"关于爱上网"];
        [_btn1 addSubview:titleLabel1];
        
        UIImageView *arrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0004_图层-7-副本-4.png"]];
        arrow1.frame = CGRectMake(302 - 8 - 10, 43/2 - 13/2, 8, 13);
        [_btn1 addSubview:arrow1];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 42, 300, 1)];
        line1.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [_btn1 addSubview:line1];
        
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(0, 43, 301, 43);
        [linkInfoBGView addSubview:_btn2];
        
        UIImageView *iconView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0000_图层-8-副本-2.png"]];
        iconView2.frame = CGRectMake(10, 43/2 - 22/2, 22, 22);
        [_btn2 addSubview:iconView2];
        
        UILabel *titleLabel2 = [LSViewUtil simpleLabel:CGRectMake(iconView2.right+13, 43/2-16/2, 150, 15) f:15 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"联系我们"];
        [_btn2 addSubview:titleLabel2];
        
        UIImageView *arrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0004_图层-7-副本-4.png"]];
        arrow2.frame = CGRectMake(302 - 8 - 10, 43/2 - 13/2, 8, 13);
        [_btn2 addSubview:arrow2];
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 42, 300, 1)];
        line2.image = [UIImage imageNamed:@"_0001_分割线-副本-2.png"];
        [_btn2 addSubview:line2];
        
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3.frame = CGRectMake(0, 43+43, 301, 43);
        [linkInfoBGView addSubview:_btn3];
        
        UIImageView *iconView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0006_013.png"]];
        iconView3.frame = CGRectMake(10, 43/2 - 22/2, 22, 22);
        [_btn3 addSubview:iconView3];
        
        UILabel *titleLabel3 = [LSViewUtil simpleLabel:CGRectMake(iconView3.right+13, 43/2-16/2, 150, 15) f:15 tc:RGBCOLOR(0x00, 0x00, 0x00) t:@"给爱上网加油"];
        [_btn3 addSubview:titleLabel3];
        
        UIImageView *arrow3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0004_图层-7-副本-4.png"]];
        arrow3.frame = CGRectMake(302 - 8 - 10, 43/2 - 13/2, 8, 13);
        [_btn3 addSubview:arrow3];
        
        
        _loginoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginoutBtn setBackgroundImage:[UIImage imageNamed:@"_0002_退出.png"] forState:UIControlStateNormal];
        _loginoutBtn.frame = CGRectMake(8, linkInfoBGView.bottom+15, 304, 95/2);
        [superView addSubview:_loginoutBtn];
    }
    return self;
}

@end
