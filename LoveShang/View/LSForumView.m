//
//  LSForumView.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSForumView.h"
#import "LSViewUtil.h"

@implementation LSForumView

@synthesize forumTableView = _forumTableView;
@synthesize actionBox = _actionBox;

-(id)initWithFrame:(UIView *)superView{
    if (self = [super init]) {
        _forumTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+32, 320, superView.height - 44 - 32 - 44) style:UITableViewStylePlain];
        [superView addSubview:_forumTableView];
        _actionBox = [[UIView alloc] initWithFrame:CGRectMake(15,44, 293, 80)];
        _actionBox.backgroundColor = [UIColor clearColor];
        _actionBox.layer.borderWidth = 1;
        _actionBox.layer.borderColor = [RGBCOLOR(0x99, 0x8c, 0x51) CGColor];
        [self setupPostdateView];
        [self setupReplydateView];
        [self setupCloseBtnView];
        
        [superView addSubview:_actionBox];
        _actionBox.hidden = YES;
    }
    return self;
}

-(void)setupPostdateView{
    UIButton *postdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postdateBtn.frame = CGRectMake(0, 0, 293, 32);
    postdateBtn.titleLabel.font =  [UIFont systemFontOfSize:13];
    postdateBtn.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
    [postdateBtn setTitle:@"按最新发表显示" forState:UIControlStateNormal];
    [postdateBtn setTitleColor:RGBCOLOR(0x99, 0x8c, 0x51) forState:UIControlStateNormal];
    [postdateBtn setTitleColor:RGBCOLOR(0x99, 0x8c, 0x51) forState:UIControlStateHighlighted];
    [postdateBtn addTarget:self action:@selector(postdateAction) forControlEvents:UIControlEventTouchUpInside];
    [_actionBox addSubview:postdateBtn];
}

-(void)setupReplydateView{
    UIButton *replydateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    replydateBtn.frame = CGRectMake(0, 32, 293, 24);
    replydateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    replydateBtn.backgroundColor = RGBCOLOR(0xa0, 0xa0, 0xa0);
    replydateBtn.alpha = 0.9;
    [replydateBtn setTitle:@"按最后回复显示" forState:UIControlStateNormal];
    [replydateBtn setTitleColor:RGBCOLOR(0x6d, 0x6e, 0x71) forState:UIControlStateNormal];
    [replydateBtn setTitleColor:RGBCOLOR(0x6d, 0x6e, 0x71) forState:UIControlStateHighlighted];
    [replydateBtn addTarget:self action:@selector(replydateAction) forControlEvents:UIControlEventTouchUpInside];
    [_actionBox addSubview:replydateBtn];
}

-(void)setupCloseBtnView{
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 56, 293, 24);
    closeBtn.backgroundColor = RGBCOLOR(0xa0, 0xa0, 0xa0);
    closeBtn.alpha = 0.9;
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *closeBtnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(293/2 - 7.5/2, 24/2 - 14.5/2, 7.5, 14.5)];
    [closeBtnImageView setImage:[UIImage imageNamed:@"close_btn"]];
    [closeBtn addSubview:closeBtnImageView];
    [_actionBox addSubview:closeBtn];
}

-(void)postdateAction{
    [self.delegate postdateAction];
}

-(void)replydateAction{
    [self.delegate replydateAction];
}

-(void)closeAction{
    [self.delegate closeAction];
}




@end
