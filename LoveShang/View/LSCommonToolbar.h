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

@protocol LSCommonToolbarDelegate <NSObject>

@optional
-(void)showActionBox:(BOOL)isShow;

@end

@interface LSCommonToolbar : UIView

-(id)initWithFrame:(CGRect)frame type:(NSInteger)type;

@property (nonatomic,assign) id<LSCommonToolbarDelegate> delegate;
@property (nonatomic,assign) BOOL isActionBoxShow;
@property (nonatomic,strong) UIButton *centerBtn;

-(void)showActionBox;

@end


