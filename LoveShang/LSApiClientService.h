//
//  LSApiClientService.h
//  LoveShang
//
//  Created by zhudong on 13-10-26.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface LSApiClientService : AFHTTPClient

+(LSApiClientService *)sharedInstance;

@end
