//
//  LSTabBarViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSTabBarViewController.h"
#import "LSHeadlineViewController.h"
#import "LSForumViewController.h"
#import "LSNearbyViewController.h"
#import "LSMyViewController.h"
#import "LSCommonToolbar.h"
//#import "LSRegisterViewController.h"
#import "LSLoginViewController.h"

@implementation LSTabBarViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    backgroundView.backgroundColor = RGBCOLOR(108, 111, 113);
    [self.tabBar insertSubview:backgroundView atIndex:0];
    
    [[UITabBar appearance] setSelectedImageTintColor:RGBCOLOR(156, 189, 75)];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       RGBCOLOR(156, 189, 75), UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] init];
    
    LSHeadlineViewController *headlineViewController = [[LSHeadlineViewController alloc] init];
    LSForumViewController *fourmViewController = [[LSForumViewController alloc] init];
    LSNearbyViewController *nearbyViewController = [[LSNearbyViewController alloc] init];
    LSMyViewController *myViewController = [[LSMyViewController alloc] init];
    
    headlineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"头条" image:[UIImage imageNamed:@"headline_icon.png"] tag:1];
    headlineViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(15, 9, 9, 9);
    fourmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@"fourm_icon"] tag:2];
    fourmViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(15, 11, 9, 11);
    nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"身边优惠" image:[UIImage imageNamed:@"nearby_icon.png"] tag:3];
    nearbyViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(15, 11, 9, 11);
    myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"my_icon.png"] tag:4];
    myViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(15, 11, 9, 11);
    
    [viewControllerArray addObject:headlineViewController];
    [viewControllerArray addObject:fourmViewController];
    [viewControllerArray addObject:nearbyViewController];
    [viewControllerArray addObject:myViewController];
    
    self.viewControllers = viewControllerArray;
}

@end
