//
//  LSErrorViewCell.m
//  LoveShang
//
//  Created by zhudong on 13-11-11.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSErrorViewCell.h"

@implementation LSErrorViewCell

@synthesize errorImageView = _errorImageView;
@synthesize errorLabel = _errorLabel;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return tableView.frame.size.height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _errorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_errorImageView];
        
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _errorLabel.font = [UIFont boldSystemFontOfSize:14];
        _errorLabel.textColor = RGBCOLOR(204, 204, 204);
        _errorLabel.shadowColor = [UIColor colorWithWhite:1 alpha:0.7];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.shadowOffset = CGSizeMake(0, 1);
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.numberOfLines = 0;
        [self.contentView addSubview:_errorLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    _errorImageView.frame = CGRectMake((frame.size.width - 213) / 2, (frame.size.height - 127) / 2 - 30, 213, 127);
    _errorLabel.frame = CGRectMake(0, _errorImageView.frame.origin.y + _errorImageView.frame.size.height + 15, frame.size.width, 30);
}

- (void)setObject:(id)object {
    if ([object isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)object;
        _errorImageView.image = [UIImage imageNamed:error.code == -1 ? @"ErrorEmpty" : @"ErrorDataEmpty"];
        _errorLabel.text = error.localizedDescription;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
