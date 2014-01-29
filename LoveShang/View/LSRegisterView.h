//
//  LSRegisterView.h
//  LoveShang
//
//  Created by zhudong on 14-1-13.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRegisterView : NSObject


-(LSRegisterView *)initWithSuperView:(UIView *)superView;

@property (nonatomic,strong) UIView *wapperView;
@property (nonatomic,strong) UITextField *usernameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *checkPasswordField;
@property (nonatomic,strong) UITextField *mobileField;
@property (nonatomic,strong) UIButton *mobileBtn;
@property (nonatomic,strong) UITextField *veriCodeField;
@property (nonatomic,strong) UIImageView *mainInfoBox;
@property (nonatomic,strong) UIButton *registerBtn;
@end
