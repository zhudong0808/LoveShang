//
//  LSNavBar.h
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSForumNavBarDelegate <NSObject>

-(void)doActionWithBtn:(UIButton *)btn;

@end

@interface LSForumNavBar : UIView<UIScrollViewDelegate>

@property (nonatomic,assign) id<LSForumNavBarDelegate> delegate;
@property (nonatomic,strong) NSArray *navTitles;
@property (nonatomic,strong) NSArray *navKeys;

@end
