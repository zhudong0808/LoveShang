//
//  LSForumView.h
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSForumViewDeleate <NSObject>

-(void)postdateAction;
-(void)replydateAction;
-(void)closeAction;

@end

@interface LSForumView : NSObject

@property (nonatomic,strong) UITableView *forumTableView;
@property (nonatomic,strong) UIView *actionBox;
@property (nonatomic,assign) id<LSForumViewDeleate> delegate;

-(id)initWithFrame:(UIView *)superView;

@end
