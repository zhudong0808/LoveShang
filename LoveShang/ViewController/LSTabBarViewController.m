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
    
    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] init];
    
    LSHeadlineViewController *headlineViewController = [[LSHeadlineViewController alloc] init];
    LSForumViewController *fourmViewController = [[LSForumViewController alloc] init];
    LSNearbyViewController *nearbyViewController = [[LSNearbyViewController alloc] init];
//    LSMyViewController *myViewController = [[LSMyViewController alloc] init];
//    LSRegisterViewController *registerViewController = [[LSRegisterViewController alloc] init];
    LSLoginViewController *loginViewController = [[LSLoginViewController alloc] init];
    
    headlineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"头条" image:[UIImage imageNamed:@"headline_icon.png"] tag:1];
    fourmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@"fourm_icon"] tag:2];
    nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"身边优惠" image:[UIImage imageNamed:@"nearby_icon.png"] tag:3];
//    myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"my_icon.png"] tag:4];
//    registerViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"my_icon.png"] tag:4];
    loginViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"my_icon.png"] tag:4];
    
    [viewControllerArray addObject:headlineViewController];
    [viewControllerArray addObject:fourmViewController];
    [viewControllerArray addObject:nearbyViewController];
//    [viewControllerArray addObject:myViewController];
    [viewControllerArray addObject:loginViewController];
    
    self.viewControllers = viewControllerArray;
}

@end
