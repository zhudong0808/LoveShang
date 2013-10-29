//
//  LSHeadlineViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSHeadlineViewController.h"

@interface LSHeadlineViewController(){

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger totalCount;
@end

@implementation LSHeadlineViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarIndex;
    self.showCommonBar = YES;
    self.showNavBar = YES;
    self.navBar.delegate = self;
    _page = 1;
    _tableData = [[NSMutableArray alloc] init];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+32+1, self.view.frame.size.width, self.view.frame.size.height - 40 -35 - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    [self.view addSubview:_tableView];
    __block __unsafe_unretained id blockSelf = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [blockSelf loadDataWithMore:NO isRefresh:YES];
        });
     }];
    // setup infinite scrolling
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong LSHeadlineViewController *strongSelf = blockSelf;
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(!strongSelf.isLoadingData){
                if (strongSelf.totalCount > [strongSelf.tableData count]) {
                    [strongSelf loadDataWithMore:YES isRefresh:NO];
                }else{
                    if (strongSelf.tableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                        [strongSelf.tableView.infiniteScrollingView stopAnimating];
                    }
                }
            }else if (strongSelf.tableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                [strongSelf.tableView.infiniteScrollingView stopAnimating];
            }
            
        });
    }];
    [self loadDataWithMore:NO isRefresh:YES];
}

#pragma UITableViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    [self loadDataWithMore:YES isRefresh:NO];
//}

#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 75/2 - 58/2, 85, 58)];
    imageView.image = [UIImage imageNamed:@"list_default_image.png"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11, self.view.frame.size.width - 95, 15)];
    titleLabel.text = [[_tableData objectAtIndex:indexPath.row] objectForKey:@"title"];
    titleLabel.textColor = [LSColorStyleSheet colorWithName:LSColorGrayText];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = UITextAlignmentLeft;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11 + 15 + 8, self.view.frame.size.width - 95, 12)];
    contentLabel.text = [[_tableData objectAtIndex:indexPath.row] objectForKey:@"content"];
    contentLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = UITextAlignmentLeft;
    
    [cell addSubview:imageView];
    [cell addSubview:titleLabel];
    [cell addSubview:contentLabel];
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}


-(void)doActionWithBtn:(UIButton *)btn{
    [self reloadData];
}

-(void)reloadData{
    
}

-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    _isLoadingData = YES;
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",_page]};
    [[LSApiClientService sharedInstance]getPath:@"api.php" parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
        _isLoadingData = NO;
        _totalCount = 20;
        if (more && !isRefresh) {
          [_tableData addObjectsFromArray:responseObject];
          [_tableView.infiniteScrollingView stopAnimating];
           _page = _page + 1;
        } else {
            [_tableData addObjectsFromArray:responseObject];
            _page = 2;
            [_tableView.pullToRefreshView stopAnimating];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        _isLoadingData = NO;
        NSLog(@"%@",error);
    }];
    
}

@end
