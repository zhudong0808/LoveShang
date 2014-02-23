//
//  LSReadView.h
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSReadView : NSObject

-(id)initWithSuperView:(UIView *)superView;

@property (nonatomic,strong) UITableView *readTableView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIImageView *landlordIconView;
@property (nonatomic,strong) UILabel *landlordNameLabel;
@property (nonatomic,strong) UILabel *landlordPostdateLabel;

@end
