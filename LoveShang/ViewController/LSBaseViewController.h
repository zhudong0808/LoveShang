//
//  LSBaseViewController.h
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCommonToolbar.h"

@interface LSBaseViewController : UIViewController{
}

@property (nonatomic,assign) BOOL showCommonBar;
@property (nonatomic,strong) LSCommonToolbar *commonBar;

@end
