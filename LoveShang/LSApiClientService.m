//
//  LSApiClientService.m
//  LoveShang
//
//  Created by zhudong on 13-10-26.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSApiClientService.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation LSApiClientService

+(LSApiClientService *)sharedInstance{
    static LSApiClientService *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.loveshang.com/mapi/"]];
    });
    return sharedInstance;
}

-(id)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    return self ;
}

@end
