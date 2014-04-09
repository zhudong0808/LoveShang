//
//  LSLoginView.h
//  LoveShang
//
//  Created by zhudong on 14-2-7.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLoginView : NSObject

@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UIButton *forgetPasswordBtn;
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIView *userNameView;
@property (nonatomic,strong) UIView *passwordView;
@property (nonatomic,strong) UIButton *showAccountBtn;
@property (nonatomic,strong) UITableView *accountInfoView;

-(LSLoginView *)initWithSuperView:(UIView *)superView;

@end
