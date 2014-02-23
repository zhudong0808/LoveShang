//
//  LSAuthenticateCenter.h
//  LoveShang
//
//  Created by zhudong on 14-2-16.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LSAuthenticateCompletion)(BOOL success);

@interface LSAuthenticateCenter : NSObject


+(LSAuthenticateCenter *)shareInstance;

-(void)authenticateWithBlock:(LSAuthenticateCompletion)completion;
-(BOOL)isLogined;
+(NSString *)getEncryptString;

@end
