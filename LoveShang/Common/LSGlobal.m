//
//  LSGlobal.m
//  LoveShang
//
//  Created by zhudong on 14-1-29.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSGlobal.h"

UIWindow *mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

static MBProgressHUD  *s_progressHUD = nil;

@implementation LSGlobal

+ (void)showProgressHUD:(NSString *)aString duration:(CGFloat)duration {
    [self hideProgressHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:mainWindow()];
    [mainWindow() addSubview:progressHUD];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.labelText = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.opacity = 0.5;
    [progressHUD show:NO];
    [progressHUD hide:YES afterDelay:duration];
}

+ (void)showFailedView:(NSString*)strTitle{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:strTitle
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

+ (void)hideProgressHUD {
    if (s_progressHUD) {
        [s_progressHUD hide:YES];
    }
}

@end
