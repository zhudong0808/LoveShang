//
//  LSDataSource.h
//  LoveShang
//
//  Created by zhudong on 14-3-26.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDataSource : NSObject<UITableViewDataSource>

-(id)initWithData:(NSArray *)data indetifier:(NSString *)indetifier;

@end
