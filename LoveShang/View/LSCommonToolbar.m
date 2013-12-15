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
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,assign) BOOL isActionBoxShow;
@end

@implementation LSCommonToolbar

-(id)initWithFrame:(CGRect)frame type:(NSInteger)type{
    _isActionBoxShow = NO;
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        backgroundView.image = [UIImage imageNamed:@"common_toolbar_background.png"];
        [self addSubview:backgroundView];
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44/2 - 33/2, 87, 33)];
        logoView.image = [UIImage imageNamed:@"logo.png"];
        [self addSubview:logoView];
    }
    if (type == LSCommonToolbarList) {
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
    return self;
}

-(void)showActionBox{
    if (_isActionBoxShow == NO) {
        [_centerBtn setTitle:@"最新发表" forState:UIControlStateNormal];
        _centerBtnArrow.image = [UIImage imageNamed:@"upArrow.png"];
        _isActionBoxShow = YES;
    } else if(_isActionBoxShow == YES) {
        [_centerBtn setTitle:@"最后回复" forState:UIControlStateNormal];
        _centerBtnArrow.image = [UIImage imageNamed:@"downArrow.png"];
        _isActionBoxShow = NO;
    }
}

@end
