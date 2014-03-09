//
//  LSMyView.h
//  LoveShang
//
//  Created by zhudong on 14-2-13.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMyView : NSObject

@property (nonatomic,strong) UIImageView *userIconView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userMobileLabel;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UIButton *loginoutBtn;

-(LSMyView *)initWithSuperView:(UIView *)superView;

@end
