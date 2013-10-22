//
//  LSNavBar.m
//  LoveShang
//
//  Created by zhudong on 13-10-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSNavBar.h"

@implementation LSNavBar

-(void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 30)];
    sv.backgroundColor = [UIColor whiteColor];
    sv.delegate = self;
    sv.contentSize = CGSizeMake(640, 30);
    
    NSArray *navTitle = @[@"头条",@"活动",@"房产",@"装修",@"亲子"];
    float x = 0;
    for (NSString *title in navTitle) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 50, 30)];
        x = x + 100;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.text = title;
        [sv addSubview:label];
    }
    
    [self.view addSubview:sv];
}
@end
