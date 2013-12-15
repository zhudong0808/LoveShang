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
@property (nonatomic,strong) NSMutableArray *btnWidthArray;
@end

@implementation LSForumNavBar
@synthesize delegate = _delegate;
@synthesize navTitles = _navTitles;
@synthesize navKeys = _navKeys;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
        _sv.backgroundColor = [UIColor whiteColor];
        _sv.delegate = self;
        _sv.contentSize = CGSizeMake(640, 30);
        _btnWidthArray = [[NSMutableArray alloc] init];
        
        
        
        _navKeys = [NSArray arrayWithObjects:@"516",@"595",@"516",@"465",@"92",@"486",@"131",@"293",@"294",nil];
        _navTitles = [NSArray arrayWithObjects:@"街巷",@"美食",@"婚嫁",@"妈宝",@"房产",@"汽车",@"装修讨论",@"装修日记",@"新家", nil];
        float x = 0;
        for (NSInteger i = 0; i < _navKeys.count; i++) {
            NSInteger btnWidth = 13 * [[_navTitles objectAtIndex:i] length] + 10;
            [_btnWidthArray addObject:[NSString stringWithFormat:@"%d",btnWidth]];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, btnWidth, 30)];
            x = x + btnWidth;
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i;
            [btn setTitle:[_navTitles objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR(0x87, 0x87, 0x87) forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR(0x8c, 0xaa, 0x3b) forState:UIControlStateHighlighted];
            [btn setTitleColor:RGBCOLOR(0x8c, 0xaa, 0x3b) forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:13]];
            [btn addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
            [_sv addSubview:btn];
        }
        _border = [[UIView alloc] initWithFrame:CGRectMake(0, _sv.contentSize.height-3 , [[_btnWidthArray objectAtIndex:0]intValue], 3)];
        _border.backgroundColor = [UIColor redColor];
        [_sv addSubview:_border];
        [self addSubview:_sv];
        //底部分割线
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 31, self.frame.size.width, 1)];
        bottomLine.backgroundColor = [LSColorStyleSheet colorWithName:LSColorGrayLine];
        [self addSubview:bottomLine];
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
        NSString *btnWidth = [_btnWidthArray objectAtIndex:btn.tag];
        CGRect newFrame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+30-3, [btnWidth intValue], 3);
        _border.frame = newFrame;
    }];
    
    if ([_delegate respondsToSelector:@selector(doActionWithBtn:)]) {
        [_delegate doActionWithBtn:btn];
    }
}
@end
