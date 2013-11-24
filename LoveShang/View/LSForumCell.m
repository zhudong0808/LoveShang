//
//  LLForumCell.m
//  LoveShang
//
//  Created by zhudong on 13-11-24.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSForumCell.h"
@interface LSForumCell(){}

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) UILabel *hitLabel;
@property (nonatomic,strong) UILabel *repliesLabel;
@property (nonatomic,strong) UILabel *lastpostLabel;

@end

@implementation LSForumCell

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
        
        
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 11 + 13 + 9, 100, 10)];
        _authorLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _authorLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _authorLabel.textAlignment = NSTextAlignmentLeft;
        _authorLabel.backgroundColor = [UIColor clearColor];
        
        
        _hitLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 11 + 13 + 9, 50, 10)];
        _hitLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _hitLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _hitLabel.textAlignment = NSTextAlignmentLeft;
        _hitLabel.backgroundColor = [UIColor clearColor];
        
        _repliesLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 11 + 13 + 9, 50, 10)];
        _repliesLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _repliesLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _repliesLabel.textAlignment = NSTextAlignmentLeft;
        _repliesLabel.backgroundColor = [UIColor clearColor];
        
        _lastpostLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 11 + 13 + 9, 50, 10)];
        _lastpostLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _lastpostLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _lastpostLabel.textAlignment = NSTextAlignmentLeft;
        _lastpostLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
        [self addSubview:_authorLabel];
        [self addSubview:_hitLabel];
        [self addSubview:_repliesLabel];
        [self addSubview:_authorLabel];
        [self addSubview:_lastpostLabel];
        
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = RGBCOLOR(0xe8, 0xe8, 0xe8);
        
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    _titleLabel.text = [data objectForKey:@"subject"];
    _authorLabel.text = [NSString stringWithFormat:@"作者：%@",[data objectForKey:@"author"]];
    _hitLabel.text = [NSString stringWithFormat:@"%@ 浏览",[data objectForKey:@"hits"]];
    _repliesLabel.text = [NSString stringWithFormat:@"%@ 回复",[data objectForKey:@"replies"]];
    _lastpostLabel.text = [data objectForKey:@"lastpost"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
