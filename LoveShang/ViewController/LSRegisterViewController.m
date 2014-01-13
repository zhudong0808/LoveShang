//
//  LSRegisterViewController.m
//  LoveShang
//
//  Created by zhudong on 13-12-29.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSRegisterViewController.h"
#import "LSRegisterView.h"

@interface LSRegisterViewController(){

}
@property (nonatomic,strong) LSRegisterView *registerView;

@end

@implementation LSRegisterViewController

-(void)viewDidLoad{
    self.commonToolBarType = LSCommonToolbarRegister;
    self.showCommonBar = YES;
    
    _registerView = [[LSRegisterView alloc] initWithSuperView:self.cView];
}

@end
