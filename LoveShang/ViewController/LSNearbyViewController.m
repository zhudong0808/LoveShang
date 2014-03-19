//
//  LSNearbyViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSNearbyViewController.h"

@implementation LSNearbyViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarIndex;
    self.showCommonBar = YES;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"身边优惠-切片.jpg"]];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundView.frame = CGRectMake(0, 44, APP_CONTENT_WIDTH, APP_CONTENT_HEIGHT-44-49);
    [self.cView addSubview:backgroundView];
}

@end
