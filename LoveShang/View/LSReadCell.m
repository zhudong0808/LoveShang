//
//  LSReadCell.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSReadCell.h"

@interface LSReadCell(){
}

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation LSReadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 11, self.frame.size.width - 36, 13)];
        _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:13];
        _titleLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _titleLabel.highlightedTextColor = RGBCOLOR(0x99, 0x8c, 0x51);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    _titleLabel.text = [data objectForKey:@"subject"];
}


@end
