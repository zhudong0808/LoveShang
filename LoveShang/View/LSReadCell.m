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
        
        _userFloorLabel = [LSViewUtil simpleLabel:CGRectMake(320-30-20, 36/2-10/2, 20, 10) f:10 tc:RGBCOLOR(0x9c, 0xbd, 0x4b) t:@""];
        [userInfoView addSubview:_userFloorLabel];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, 58, 320-30, 10)];
        _webView.backgroundColor = [UIColor redColor];
        _webView.alpha = 0;
        [self.contentView addSubview:_webView];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    [_userIconView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[data objectForKey:@"faceurl"]]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    _userNameLabel.text = [data objectForKey:@"author"];
    _userPostdateLabel.text = [data objectForKey:@"postdate"];
    [_webView loadHTMLString:[data objectForKey:@"content"] baseURL:nil];
}


@end
