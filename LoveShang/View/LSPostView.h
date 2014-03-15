//
//  LSPostView.h
//  LoveShang
//
//  Created by zhudong on 14-3-9.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPGrowingTextView.h"

@interface LSPostView : NSObject

@property (nonatomic,strong) UIView *forumNavView;
@property (nonatomic,strong) UIView *titleTextView;
@property (nonatomic,strong) UITextField *titleTextField;
@property (nonatomic,strong) HPGrowingTextView *contentTextField;
@property (nonatomic,strong) UIView *postBar;
@property (nonatomic,strong) UIButton *uploadBtn;
@property (nonatomic,strong) UIButton *keyboardBtn;
@property (nonatomic,strong) UIButton *postBtn;
@property (nonatomic,strong) UIScrollView *uploadImageScrollView;
@property (nonatomic,strong) UILabel *forumTitleLabel;

-(LSPostView *)initWithSuperView:(UIView *)superView;

@end
