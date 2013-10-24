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
@end

@implementation LSNavBar
@synthesize delegate = _delegate;

-(void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 35)];
    sv.backgroundColor = [UIColor whiteColor];
    sv.delegate = self;
    sv.contentSize = CGSizeMake(640, 30);
    
    NSArray *navTitle = @[@"test",@"test",@"test",@"test",@"test"];
    float x = 0;
    for (NSInteger i = 0; i < navTitle.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 100, 30)];
        x = x + 100;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 1 << i;
        [btn setTitle:[navTitle objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:btn];
    }
    _border = [[UIView alloc] initWithFrame:CGRectMake(0, sv.contentSize.height-3 , 100, 3)];
    _border.backgroundColor = [UIColor redColor];
    [sv addSubview:_border];
    [self.view addSubview:sv];
}

-(void)doAction:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+30-3, 100, 3);
        _border.frame = newFrame;
    }];
    if ([_delegate respondsToSelector:@selector(doActionWithBtn:)]) {
        [_delegate doActionWithBtn:btn];
    }
}
@end
