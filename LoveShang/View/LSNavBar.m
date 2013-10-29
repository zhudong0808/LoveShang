//
//  LSNavBar.m
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSNavBar.h"

@interface LSNavBar(){

}
@property (nonatomic,strong) UIView *border;
@property (nonatomic,strong) UIScrollView *sv;
@end

@implementation LSNavBar
@synthesize delegate = _delegate;

-(void)viewDidLoad{
    [super viewDidLoad];
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 32)];
    _sv.backgroundColor = [UIColor whiteColor];
    _sv.delegate = self;
    _sv.contentSize = CGSizeMake(640, 30);
    
    NSArray *navTitle = @[@"头条",@"活动",@"论坛",@"房产",@"装修"];
    float x = 0;
    for (NSInteger i = 0; i < navTitle.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 60, 30)];
        x = x + 60;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 1 << i;
        [btn setTitle:[navTitle objectAtIndex:i] forState:UIControlStateNormal];
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
