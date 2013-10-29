//
//  LSCommonToolbar.h
//  LoveShang
//
//  Created by zhudong on 13-10-21.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LSCommonToolbarIndex,
    LSCommonToolbarList,
    LSCommonToolbarOther
} LSCommonToolbarType;

@interface LSCommonToolbar : UIView

-(id)initWithFrame:(CGRect)frame type:(NSInteger)type;

@end
