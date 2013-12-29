//
//  LSReadView.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSReadView.h"
#import "LSViewUtil.h"

@implementation LSReadView

@synthesize readTableView = _readTableView;
@synthesize titleLabel = _titleLabel;

-(id)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        _readTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, superView.height - 44 - 44) style:UITableViewStylePlain];
        _readTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _readTableView.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
        [superView addSubview:_readTableView];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        headerView.backgroundColor = [UIColor redColor];
        _readTableView.tableHeaderView = headerView;

        _titleLabel = [LSViewUtil simpleLabel:CGRectMake(15, 0, 320-30, 40) f:15 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@""];
        _titleLabel.backgroundColor = [UIColor redColor];
        [headerView addSubview:_titleLabel];
    }
    return self;
}

@end
