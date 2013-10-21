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

@end
