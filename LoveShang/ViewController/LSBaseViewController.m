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

-(void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)setShowCommonBar:(BOOL)showCommonBar {
    _showCommonBar = showCommonBar;
    if (_showCommonBar && !_commonBar) {
        _commonBar = [[LSCommonToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
        [self.view addSubview:_commonBar];
    } else if (!_showCommonBar && _commonBar) {
        [_commonBar removeFromSuperview];
    }
}

- (void)setShowNavBar:(BOOL)showNavBar{
    _showNavBar = showNavBar;
    if (_showNavBar && !_navBar) {
        _navBar = [[LSNavBar alloc] init];
        [self.view addSubview:_navBar.view];
    } else if (!_showNavBar && _navBar) {
        [_navBar.view removeFromSuperview];
    }
}
@end
