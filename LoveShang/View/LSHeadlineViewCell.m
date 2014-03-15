//
//  LSHeadlineViewCell.m
//  LoveShang
//
//  Created by zhudong on 14-2-23.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSHeadlineViewCell.h"
#import "UIImageView+WebCache.h"
#import "LSViewUtil.h"

@interface LSHeadlineViewCell(){
}

@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation LSHeadlineViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = RGBCOLOR(0xee, 0xee, 0xee);
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 75/2 - 58/2, 85, 58)];
        _titleImageView.image = [UIImage imageNamed:@"loading.png"];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11, 320 - 110, 15)];
        _titleLabel.textColor = [LSColorStyleSheet colorWithName:LSColorGrayText];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11 + 15 + 8, 320 - 110, 30)];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 2;
        _contentLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_titleImageView];
        [self addSubview:_titleLabel];
        [self addSubview:_contentLabel];
        
        [LSViewUtil drawLine:CGRectMake(12, 74, 320-12*2, 1) onView:self color:RGBCOLOR(0xcf, 0xcf, 0xcf)];
        
    }
    return self;
}

-(void)setData:(NSDictionary *)data{
    [_titleImageView setImageWithURL:[NSURL URLWithString:[data objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    _titleLabel.text = [data objectForKey:@"subject"];
    _contentLabel.text = [data objectForKey:@"introduction"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [_titleLabel setTextColor:RGBCOLOR(0x63, 0x8c, 0x33)];
    } else {
        [_titleLabel setTextColor:RGBCOLOR(0x00, 0x00, 0x00)];
    }
}

@end
