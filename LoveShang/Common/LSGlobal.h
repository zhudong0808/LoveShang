//
//  LSGlobal.h
//  LoveShang
//
//  Created by zhudong on 14-1-29.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface LSGlobal : NSObject

+ (void)showProgressHUD:(NSString *)aString duration:(CGFloat)duration;
+ (void)showFailedView:(NSString*)strTitle;
+ (NSString *)encodeWithString:(NSString *)encodeStr;

@end
