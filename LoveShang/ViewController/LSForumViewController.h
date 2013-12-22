//
//  LSForumViewController.h
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSBaseViewController.h"
#import "LSForumView.h"

@interface LSForumViewController : LSBaseViewController<LSForumNavBarDelegate,LSCommonToolbarDelegate,UITableViewDataSource,UITableViewDelegate,LSForumViewDeleate>

@end
