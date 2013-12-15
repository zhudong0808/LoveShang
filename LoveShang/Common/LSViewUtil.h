//
//  LSViewUtil.h
//  LoveShang
//
//  Created by zhudong on 13-12-15.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSViewUtil : NSObject

+(UILabel *)simpleLabel:(CGRect)frame f:(int)size tc:(UIColor *)color t:(NSString *)text;
+(UILabel *)simpleLabel:(CGRect)frame bf:(int)size tc:(UIColor *)color t:(NSString *)text;

@end
