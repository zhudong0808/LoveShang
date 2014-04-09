//
//  LSAccountInfoCell.m
//  LoveShang
//
//  Created by zhudong on 14-4-6.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSAccountInfoCell.h"
#import "LSViewUtil.h"

@implementation LSAccountInfoCell

@synthesize userNameLabel = _userNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _userNameLabel = [LSViewUtil simpleLabel:CGRectMake(10, 0, 283,40) f:14 tc:RGBCOLOR(0x87, 0x87, 0x87) t:@""];
        [self.contentView addSubview:_userNameLabel];
        [LSViewUtil drawLine:CGRectMake(0, 39, 303, 1) onView:self.contentView color:RGBCOLOR(0xdd, 0xdd, 0xdd)];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
