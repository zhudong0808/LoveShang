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

@implementation LSTabBarViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    [self setupCommonBar];
    
    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] init];
    
    LSHeadlineViewController *headlineViewController = [[LSHeadlineViewController alloc] init];
    LSForumViewController *fourmViewController = [[LSForumViewController alloc] init];
    LSNearbyViewController *nearbyViewController = [[LSNearbyViewController alloc] init];
    LSMyViewController *myViewController = [[LSMyViewController alloc] init];
    
    headlineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"一" image:nil tag:1];
    fourmViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"二" image:nil tag:2];
    nearbyViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"三" image:nil tag:3];
    myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"四" image:nil tag:4];
    
    [viewControllerArray addObject:headlineViewController];
    [viewControllerArray addObject:fourmViewController];
    [viewControllerArray addObject:nearbyViewController];
    [viewControllerArray addObject:myViewController];
    
    self.viewControllers = viewControllerArray;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationItem.title = @"test";
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
//    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)setupCommonBar{
    LSCommonToolbar *commonBar = [[LSCommonToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44.0f)];
    [self.view addSubview:commonBar];
}

@end
