//
//  LSCommonToolbar.m
//  LoveShang
//
//  Created by zhudong on 13-10-21.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSCommonToolbar.h"
#import "LSViewUtil.h"

@interface LSCommonToolbar(){

}
@property (nonatomic,strong) UIImageView *centerBtnArrow;
@property (nonatomic,assign) NSInteger type;
@end

@implementation LSCommonToolbar
@synthesize isActionBoxShow = _isActionBoxShow;
@synthesize centerBtn = _centerBtn;

-(id)initWithFrame:(CGRect)frame type:(NSInteger)type{
    _isActionBoxShow = NO;
    _type = type;
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        backgroundView.image = [UIImage imageNamed:@"common_toolbar_background.png"];
        [self addSubview:backgroundView];
        [self setupLogoView];
        [self setupBackView];
        [self setupActionBoxView];
        [self setupTitleView];
        [self setupShareView];
    }
    return self;
}

-(void)setupLogoView{
    if (_type == LSCommonToolbarRead) {
        return;
    }
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44/2 - 33/2, 87, 33)];
    logoView.image = [UIImage imageNamed:@"logo.png"];
    [self addSubview:logoView];
}

-(void)setupBackView{
    if (_type == LSCommonToolbarRead) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(15, 44/2 - 21/2, 24, 21);
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }
}

-(void)setupTitleView{
    if (_type == LSCommonToolbarRead) {
        UILabel *titleLabel = [LSViewUtil simpleLabel:CGRectMake(320/2 - 20, 44/2 - 17/2, 40, 17) f:17 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@"话题"];
        [self addSubview:titleLabel];
    }
}

-(void)setupShareView{
    if (_type == LSCommonToolbarRead) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(320-15-25, 44/2-43/4, 25, 43/2);
        [shareBtn setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateHighlighted];
        [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }
}

-(void)setupActionBoxView{
    if (_type == LSCommonToolbarList) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(130, 0, 60, 44);
        _centerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_centerBtn setTitleColor:RGBCOLOR(00, 140, 51) forState:UIControlStateNormal];
        [_centerBtn setTitle:@"最后回复" forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(showActionBox) forControlEvents:UIControlEventTouchUpInside];
        _centerBtnArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downArrow.png"]];
        _centerBtnArrow.frame = CGRectMake(_centerBtn.right+2, 44/2 - 11/2, 11, 11);
        [self addSubview:_centerBtnArrow];
        [self addSubview:_centerBtn];
    }
}

-(void)showActionBox{
    if (_isActionBoxShow == NO) {
        _centerBtnArrow.image = [UIImage imageNamed:@"upArrow.png"];
        _isActionBoxShow = YES;
        [self.delegate showActionBox:YES];
    } else if(_isActionBoxShow == YES) {
        _centerBtnArrow.image = [UIImage imageNamed:@"downArrow.png"];
        _isActionBoxShow = NO;
        [self.delegate showActionBox:NO];
    }
}

-(void)backAction{
    [self.delegate backAction];
}

-(void)shareAction{
    //TODO
}

@end
