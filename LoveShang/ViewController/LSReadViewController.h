//
//  LSReadViewControllerCell.h
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSBaseViewController.h"

@interface LSReadViewController : LSBaseViewController<LSCommonToolbarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIWebViewDelegate>

-(id)initWithTid:(NSString *)tid;

@end
