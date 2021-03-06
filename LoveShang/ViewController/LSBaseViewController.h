//
//  LSBaseViewController.h
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCommonToolbar.h"
#import "LSNavBar.h"
#import "SVPullToRefresh.h"
#import "LSApiClientService.h"
#import "UIImageView+WebCache.h"
#import "LSForumNavBar.h"

@interface LSBaseViewController : UIViewController{
}
@property (nonatomic,strong) UIView *cView;
@property (nonatomic,assign) BOOL hiddenCView;
@property (nonatomic,assign) BOOL showCommonBar;
@property (nonatomic,strong) LSCommonToolbar *commonBar;
@property (nonatomic,assign) BOOL showNavBar;
@property (nonatomic,strong) LSNavBar *navBar;
@property (nonatomic,assign) BOOL showForumNavBar;
@property (nonatomic,strong) LSForumNavBar *forumNavBar;
@property (nonatomic,assign) NSInteger commonToolBarType;

@end
