//
//  LSForumViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSForumViewController.h"
#import "LSErrorViewCell.h"

@interface LSForumViewController(){

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSString *navType;

@end

@implementation LSForumViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarIndex;
    self.showCommonBar = YES;
    self.showForumNavBar = YES;
    _navType = @"516";
    
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
        __strong LSForumViewController *strongSelf = blockSelf;
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

#pragma mark -
#pragma mark 接口获取数据
-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=list&type=%@",_navType];
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            if (more && !isRefresh) {
                [_tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                [_tableView.infiniteScrollingView stopAnimating];
                _page = _page + 1;
            } else {
                [_tableData removeAllObjects];
                [_tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                _page = 2;
                [_tableView.pullToRefreshView stopAnimating];
            }
        } else {
            [_tableData removeAllObjects];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
            [_tableData addObject:[NSError errorWithDomain:@"" code:-1 userInfo:@{@"NSLocalizedDescription":errorMsg}]];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        _isLoadingData = NO;
        NSLog(@"%@",error);
    }];
    
}

-(void)doActionWithBtn:(UIButton *)btn{
    _navType = [self.forumNavBar.navKeys objectAtIndex:btn.tag];
    [self loadDataWithMore:NO isRefresh:YES];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [_tableData objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[NSError class]]) {
        return [LSErrorViewCell tableView:tableView rowHeightForObject:object];
    } else {
        return 75.0;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellData = [_tableData objectAtIndex:indexPath.row];
    if ([cellData isKindOfClass:[NSError class]]) {
        static NSString *errorCell = @"errorCell";
        LSErrorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:errorCell];
        if (!cell) {
            cell = [[LSErrorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:errorCell];
        }
        [cell setObject:cellData];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 11, self.view.frame.size.width - 24, 15)];
    titleLabel.text = [cellData objectForKey:@"subject"];
    titleLabel.textColor = [LSColorStyleSheet colorWithName:LSColorGrayText];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    

    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 11 + 15, 100, 12)];
    authorLabel.text = [cellData objectForKey:@"author"];
    authorLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    authorLabel.font = [UIFont systemFontOfSize:12];
    authorLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *hitLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 11 + 15, 50, 12)];
    hitLabel.text = [NSString stringWithFormat:@"%@ 浏览",[cellData objectForKey:@"hits"]];
    hitLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    hitLabel.font = [UIFont systemFontOfSize:12];
    hitLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *repliesLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 11 + 15, 50, 12)];
    repliesLabel.text = [cellData objectForKey:@"replies"];
    repliesLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    repliesLabel.font = [UIFont systemFontOfSize:12];
    repliesLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *lastpostLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 11 + 15, 50, 12)];
    lastpostLabel.text = [cellData objectForKey:@"lastpost"];
    lastpostLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    lastpostLabel.font = [UIFont systemFontOfSize:12];
    lastpostLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell addSubview:titleLabel];
    [cell addSubview:authorLabel];
    [cell addSubview:repliesLabel];
    [cell addSubview:authorLabel];
    [cell addSubview:lastpostLabel];
    return cell;
}

@end
