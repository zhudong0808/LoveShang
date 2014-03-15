//
//  LSPostViewController.h
//  LoveShang
//
//  Created by zhudong on 14-3-9.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSBaseViewController.h"

@interface LSPostViewController : LSBaseViewController<LSCommonToolbarDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

-(id)initWithTid:(NSString *)tid title:(NSString *)title;
-(id)initWithFid:(NSString *)fid forumTitle:(NSString *)forumTitle;
@end
