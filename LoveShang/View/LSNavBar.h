//
//  LSNavBar.h
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSNavBarDelegate <NSObject>

-(void)doActionWithBtn:(UIButton *)btn;

@end

@interface LSNavBar : UIView<UIScrollViewDelegate>

@property (nonatomic,assign) id<LSNavBarDelegate> delegate;
@property (nonatomic,strong) NSArray *navTitles;
@property (nonatomic,strong) NSArray *navKeys;
@property (nonatomic,strong) UIView *border;
@property (nonatomic,strong) UIScrollView *sv;


@end
