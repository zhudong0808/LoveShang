//
//  LSNavBar.m
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSForumNavBar.h"

@interface LSForumNavBar(){
    
}
@property (nonatomic,strong) UIView *border;
@property (nonatomic,strong) UIScrollView *sv;
@end

@implementation LSForumNavBar
@synthesize delegate = _delegate;
@synthesize navTitles = _navTitles;
@synthesize navKeys = _navKeys;

-(void)viewDidLoad{
    [super viewDidLoad];
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 32)];
    _sv.backgroundColor = [UIColor whiteColor];
    _sv.delegate = self;
    _sv.contentSize = CGSizeMake(640, 30);
    
    
    _navKeys = [NSArray arrayWithObjects:@"516",@"595",@"516",@"465",@"92",@"486",@"131",@"293",@"294",nil];
    _navTitles = [NSArray arrayWithObjects:@"街巷",@"美食",@"婚嫁",@"妈宝",@"房产",@"汽车",@"装修讨论",@"装修日记",@"新家", nil];
    float x = 0;
    for (NSInteger i = 0; i < _navKeys.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 60, 30)];
        x = x + 60;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn setTitle:[_navTitles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[LSColorStyleSheet colorWithName:LSColorBlack] forState:UIControlStateNormal];
        [btn setTitleColor:[LSColorStyleSheet colorWithName:LSColorNavText] forState:UIControlStateHighlighted];
        [btn setTitleColor:[LSColorStyleSheet colorWithName:LSColorNavText] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Arail" size:16]];
        [btn addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sv addSubview:btn];
    }
    _border = [[UIView alloc] initWithFrame:CGRectMake(0, _sv.contentSize.height-3 , 60, 3)];
    _border.backgroundColor = [UIColor redColor];
    [_sv addSubview:_border];
    [self.view addSubview:_sv];
    //底部分割线
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 25+31, self.view.frame.size.width, 1)];
    bottomLine.backgroundColor = [LSColorStyleSheet colorWithName:LSColorGrayLine];
    [self.view addSubview:bottomLine];
    
    
}

-(void)doAction:(UIButton *)btn{
    for (UIButton *sub in [_sv subviews]) {
        if ([sub isKindOfClass:[UIButton class]]) {
            sub.selected = NO;
        }
    }
    btn.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+30-3, 60, 3);
        _border.frame = newFrame;
    }];
    
    if ([_delegate respondsToSelector:@selector(doActionWithBtn:)]) {
        [_delegate doActionWithBtn:btn];
    }
}
@end
