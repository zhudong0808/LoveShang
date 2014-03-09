//
//  LSAuthenticateCenter.m
//  LoveShang
//
//  Created by zhudong on 14-2-16.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSAuthenticateCenter.h"
#import "SFHFKeychainUtils.h"
#import "LSAppDelegate.h"
#import "LSLoginViewController.h"

@interface LSAuthenticateCenter(){
}

@property (nonatomic,strong) LSLoginViewController *loginViewController;

@end

@implementation LSAuthenticateCenter

+(LSAuthenticateCenter *)shareInstance{
    static LSAuthenticateCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LSAuthenticateCenter alloc] init];
    });
    return instance;
}

-(void)authenticateWithBlock:(LSAuthenticateCompletion)completion{
    LSAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    if (![self isLogined]) {
        __block __unsafe_unretained LSAuthenticateCenter *blockSelf = self;
        self.loginViewController.completion = ^(BOOL success){
            if (success) {
                [blockSelf authenticateWithBlock:completion];
            }
        };
        if (!window.rootViewController.presentedViewController) {
            [window.rootViewController presentViewController:self.loginViewController animated:YES completion:nil];
        } else {
            [window.rootViewController dismissViewControllerAnimated:YES completion:^{
                [window.rootViewController presentViewController:self.loginViewController animated:YES completion:nil];
            }];
        }
    } else {
        [window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        completion(YES);
    }
}

-(BOOL)isLogined{
    if ([[SFHFKeychainUtils getPasswordForUsername:keyChainEncryptString andServiceName:keyChainServiceName error:nil] length] > 0) {
        return YES;
    }
    return NO;
}

-(void)loginout{
    [SFHFKeychainUtils deleteItemForUsername:keyChainEncryptString andServiceName:keyChainServiceName error:nil];
}

+(NSString *)getEncryptString{
    if ([[SFHFKeychainUtils getPasswordForUsername:keyChainEncryptString andServiceName:keyChainServiceName error:nil] length] > 0) {
        return [SFHFKeychainUtils getPasswordForUsername:keyChainEncryptString andServiceName:keyChainServiceName error:nil];
    }
    return @"";
}


-(LSLoginViewController *)loginViewController{
    if (!_loginViewController) {
        _loginViewController = [[LSLoginViewController alloc] init];
    }
    return _loginViewController;
}

@end
