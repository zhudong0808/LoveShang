//
//  LSNavBar.m
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSNavBar.h"

#define BtnWidth 54

@interface LSNavBar(){

}
@end

@implementation LSNavBar
@synthesize delegate = _delegate;
@synthesize navTitles = _navTitles;
@synthesize navKeys = _navKeys;
@synthesize border = _border;
@synthesize sv = _sv;

-(LSNavBar *)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
        _sv.showsHorizontalScrollIndicator = NO;
        _sv.backgroundColor = RGBCOLOR(0xee, 0xee, 0xee);
        _sv.delegate = self;
        _sv.contentSize = CGSizeMake(535, 30);
        

        _navKeys = [NSArray arrayWithObjects:@"all",@"house",@"renovation",@"marry",@"auto",@"food",@"baby",@"activity",@"life",nil];
        _navTitles = [NSArray arrayWithObjects:@"全部",@"房产",@"装修",@"婚嫁",@"汽车",@"美食",@"亲子",@"活动",@"民生", nil];
        float x = 0;
        for (NSInteger i = 0; i < _navKeys.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, BtnWidth, 30)];
            x = x + BtnWidth;
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
        _border = [[UIView alloc] initWithFrame:CGRectMake(0, _sv.contentSize.height-3 , BtnWidth, 3)];
        _border.backgroundColor = [UIColor redColor];
        [_sv addSubview:_border];
        [self addSubview:_sv];
        //底部分割线
//        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 31, self.frame.size.width, 1)];
//        bottomLine.backgroundColor = [LSColorStyleSheet colorWithName:LSColorGrayLine];
//        [self addSubview:bottomLine];
    }
    return self;
}

-(void)doAction:(UIButton *)btn{
    for (UIButton *sub in [_sv subviews]) {
        if ([sub isKindOfClass:[UIButton class]]) {
            sub.selected = NO;
        }
    }
    btn.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+30-3, BtnWidth, 3);
        _border.frame = newFrame;
    }];
    
    if ([_delegate respondsToSelector:@selector(doActionWithBtn:)]) {
        [_delegate doActionWithBtn:btn];
    }
}
@end
