//
//  LSErrorViewController.m
//  LoveShang
//
//  Created by zhudong on 13-11-9.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSErrorViewController.h"

@interface LSErrorViewController ()

@end

@implementation LSErrorViewController

@synthesize errorView = _errorView;
@synthesize errorLabel = _errorLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 2*44)];
        _errorView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_errorView];
        
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.width - 2* 44)/2, self.view.frame.size.width, 50)];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        [_errorView addSubview:_errorLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
