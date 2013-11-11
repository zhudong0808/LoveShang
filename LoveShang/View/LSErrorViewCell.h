//
//  LSErrorViewCell.h
//  LoveShang
//
//  Created by zhudong on 13-11-11.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSErrorViewCell : UITableViewCell{
}

@property (nonatomic,strong) UIImageView *errorImageView;
@property (nonatomic,strong) UILabel *errorLabel;

- (void)setObject:(id)object;
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;
@end
