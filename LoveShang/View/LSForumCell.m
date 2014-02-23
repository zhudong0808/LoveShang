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
@property (nonatomic,strong) UIView *bottomInfoView;

@end

@implementation LSForumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 11, self.frame.size.width - 36, 13)];
        _titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:13];
        _titleLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.numberOfLines = 2;
        
        
        _bottomInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 11+13+9, 320, 10)];
        [self addSubview:_bottomInfoView];
        
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 100, 10)];
        _authorLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _authorLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _authorLabel.textAlignment = NSTextAlignmentLeft;
        _authorLabel.backgroundColor = [UIColor clearColor];
        
        
        _hitLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 50, 10)];
        _hitLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _hitLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _hitLabel.textAlignment = NSTextAlignmentLeft;
        _hitLabel.backgroundColor = [UIColor clearColor];
        
        _repliesLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 50, 10)];
        _repliesLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _repliesLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _repliesLabel.textAlignment = NSTextAlignmentLeft;
        _repliesLabel.backgroundColor = [UIColor clearColor];
        
        _lastpostLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 70, 10)];
        _lastpostLabel.textColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        _lastpostLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:10];
        _lastpostLabel.textAlignment = NSTextAlignmentLeft;
        _lastpostLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
        [_bottomInfoView addSubview:_authorLabel];
        [_bottomInfoView addSubview:_hitLabel];
        [_bottomInfoView addSubview:_repliesLabel];
        [_bottomInfoView addSubview:_authorLabel];
        [_bottomInfoView addSubview:_lastpostLabel];
        
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = RGBCOLOR(0xe8, 0xe8, 0xe8);
        
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    _titleLabel.text = [data objectForKey:@"subject"];
    CGSize subjectSize = [[data objectForKey:@"subject"] sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:13] constrainedToSize:CGSizeMake(284, 30)];
    if (subjectSize.height > 13) {
        _titleLabel.size = CGSizeMake(284, 26);
        _bottomInfoView.frame = CGRectMake(0, 11+13+9+13, 320, 10);
    } else {
        _titleLabel.size = CGSizeMake(284, 13);
        _bottomInfoView.frame = CGRectMake(0, 11+13+9, 320, 10);
    }
    _authorLabel.text = [NSString stringWithFormat:@"作者：%@",[data objectForKey:@"author"]];
    _hitLabel.text = [NSString stringWithFormat:@"%@ 浏览",[data objectForKey:@"hits"]];
    _repliesLabel.text = [NSString stringWithFormat:@"%@ 回复",[data objectForKey:@"replies"]];
    _lastpostLabel.text = [data objectForKey:@"lastpost"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:highlighted];
    if (highlighted) {
        [_titleLabel setTextColor:RGBCOLOR(0x63, 0x8c, 0x33)];
    } else {
        [_titleLabel setTextColor:RGBCOLOR(0x6d, 0x6e, 0x71)];
    }
}

@end
