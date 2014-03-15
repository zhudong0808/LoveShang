//
//  LSLoginViewController.h
//  LoveShang
//
//  Created by zhudong on 14-2-7.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSBaseViewController.h"

typedef void(^LSLoginCompletion)(BOOL success);

@interface LSLoginViewController : LSBaseViewController<LSCommonToolbarDelegate>

@property (nonatomic,copy) LSLoginCompletion completion;

@end
