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

    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] init];
    
    LSHeadlineViewController *headlineViewController = [[LSHeadlineViewController alloc] init];
    LSForumViewController *fourmViewController = [[LSForumViewController alloc] init];
    LSNearbyViewController *nearbyViewController = [[LSNearbyViewController alloc] init];
    LSMyViewController *myViewController = [[LSMyViewController alloc] init];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
        
        headlineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"_0000_头条-原始.png"] tag:1];
        [headlineViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"_0001_头条-点击后.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"_0000_头条-原始.png"]];
        
        fourmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"_0006_论坛-原始.png"] tag:2];
        [fourmViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"_0007_论坛点击后.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"_0006_论坛-原始.png"]];
        
        nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"_0002_身边优惠-原始.png"] tag:3];
        [nearbyViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"_0003_身边优惠-点击后.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"_0002_身边优惠-原始.png"]];
        
        myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"_0004_我-原始.png"] tag:4];
        [myViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"_0005_我-点击后.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"_0004_我-原始.png"]];
    } else {
        headlineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"_0000_头条-原始"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"_0001_头条-点击后"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        headlineViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -7, 0);
        
        fourmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"_0006_论坛-原始"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"_0007_论坛点击后"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        fourmViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -7, 0);
        
        nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"_0002_身边优惠-原始"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"_0003_身边优惠-点击后"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nearbyViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -7, 0);

        myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"_0004_我-原始"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"_0005_我-点击后"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        myViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -7, 0);

    }
    
    [viewControllerArray addObject:headlineViewController];
    [viewControllerArray addObject:fourmViewController];
    [viewControllerArray addObject:nearbyViewController];
    [viewControllerArray addObject:myViewController];
    
    self.viewControllers = viewControllerArray;
}

@end
