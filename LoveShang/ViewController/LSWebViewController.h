//
//  LSWebViewController.h
//  LoveShang
//
//  Created by zhudong on 14-2-18.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBaseViewController.h"

@interface LSWebViewController : LSBaseViewController<LSCommonToolbarDelegate>

-(id)initWithUrl:(NSString *)url;

@end
