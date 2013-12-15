//
//  LSBaseViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSBaseViewController.h"

@implementation LSBaseViewController

@synthesize showCommonBar = _showCommonBar;
@synthesize commonBar = _commonBar;
@synthesize showNavBar = _showNavBar;
@synthesize navBar = _navBar;
@synthesize showForumNavBar = _showForumNavBar;
@synthesize forumNavBar = _forumNavBar;
@synthesize commonToolBarType = _commonToolBarType;

-(void)viewDidLoad{
    [super viewDidLoad];
    
}

-(id)cView{
    if (!_cView) {
        int h = 0;
        if (!_hiddenCView && [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            h =20;
            UIView *wView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, h)];
            wView.backgroundColor = RGBCOLOR(0xFA, 0xFA, 0xFA);
            [self.view addSubview:wView];
        }
        _cView = [[UIView alloc] initWithFrame:CGRectMake(0, h , self.view.width, self.view.height-h)];
        _cView.backgroundColor = [UIColor clearColor];
        _cView.clipsToBounds = YES;
        [self.view addSubview:_cView];
    }
    return _cView;
}

- (void)setShowCommonBar:(BOOL)showCommonBar {
    _showCommonBar = showCommonBar;
    if (_showCommonBar && !_commonBar) {
        _commonBar = [[LSCommonToolbar alloc] initWithFrame:CGRectMake(0, 0, self.cView.frame.size.width, 44.0f) type:_commonToolBarType];
        [self.cView addSubview:_commonBar];
    } else if (!_showCommonBar && _commonBar) {
        [_commonBar removeFromSuperview];
    }
}

- (void)setShowNavBar:(BOOL)showNavBar{
    _showNavBar = showNavBar;
    if (_showNavBar && !_navBar) {
        _navBar = [[LSNavBar alloc] initWithFrame:CGRectMake(0,44,320,32)];
        [self.cView addSubview:_navBar];
    } else if (!_showNavBar && _navBar) {
        [_navBar removeFromSuperview];
    }
}

- (void)setShowForumNavBar:(BOOL)showForumNavBar{
    _showForumNavBar = showForumNavBar;
    if (_showForumNavBar && !_forumNavBar) {
        _forumNavBar = [[LSForumNavBar alloc] initWithFrame:CGRectMake(0, 44, 320, 32)];
        [self.cView addSubview:_forumNavBar];
    } else if (!_showForumNavBar && _forumNavBar) {
        [_forumNavBar removeFromSuperview];
    }
}
@end
