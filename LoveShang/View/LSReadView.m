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
@synthesize headerView = _headerView;
@synthesize landlordIconView = _landlordIconView;
@synthesize landlordNameLabel = _landlordNameLabel;
@synthesize landlordPostdateLabel = _landlordPostdateLabel;

-(id)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        _readTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, 320, superView.height - 43 - 44) style:UITableViewStylePlain];
        _readTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _readTableView.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
        [superView addSubview:_readTableView];
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 76)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [LSViewUtil simpleLabel:CGRectMake(15, 0, 320-30, 40) bf:15 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@""];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 2;
        [_headerView addSubview:_titleLabel];
        
        UIView *landlordInfoView = [[UIView alloc] initWithFrame:CGRectMake(15, _titleLabel.bottom, 320-30, 36)];
        landlordInfoView.backgroundColor = [UIColor clearColor];
        [_headerView addSubview:landlordInfoView];
        
        _landlordIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
        _landlordIconView.frame = CGRectMake(0, 0, 36, 36);
        [landlordInfoView addSubview:_landlordIconView];
        
        _landlordNameLabel = [LSViewUtil simpleLabel:CGRectMake(42, 0, 100, 20) f:15 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@""];
        [landlordInfoView addSubview:_landlordNameLabel];
        
        _landlordPostdateLabel = [LSViewUtil simpleLabel:CGRectMake(42, 26, 200, 10) f:10 tc:RGBCOLOR(0x6d, 0x6e, 0x71) t:@""];
        [landlordInfoView addSubview:_landlordPostdateLabel];
        
        UILabel *landlordLabel = [LSViewUtil simpleLabel:CGRectMake(320-30-20, 36/2-10/2, 20, 10) f:10 tc:RGBCOLOR(0x9c, 0xbd, 0x4b) t:@"楼主"];
        [landlordInfoView addSubview:landlordLabel];
        
        
    }
    return self;
}

@end
