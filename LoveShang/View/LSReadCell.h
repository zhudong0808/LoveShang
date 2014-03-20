//
//  LSReadCell.h
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSReadCell : UITableViewCell

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSString *identifer;
@property (nonatomic,strong) UIView *line;

-(void)setData:(NSDictionary *)data;

@end
