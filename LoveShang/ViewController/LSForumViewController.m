//
//  LSForumViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSForumViewController.h"
#import "LSErrorViewCell.h"
#import "LSForumCell.h"
#import "LSActivityLabel.h"
#import "LSReadViewController.h"
#import "LSPostViewController.h"

@interface LSForumViewController(){

}
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSString *navType;
@property (nonatomic,strong) NSString *forumTitle;
@property (nonatomic,strong) LSForumView *fourmView;
@property (nonatomic,strong) NSString *viewOrder;


@end

@implementation LSForumViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarList;
    self.showCommonBar = YES;
    self.showForumNavBar = YES;
    self.forumNavBar.delegate = self;
    self.commonBar.delegate = self;
    _navType = @"516";
    _forumTitle = @"街巷";
    _viewOrder = @"lastpost";
    
    _page = 1;
    _tableData = [[NSMutableArray alloc] init];
    
    _fourmView = [[LSForumView alloc] initWithSuperView:self.cView];
    _fourmView.delegate = self;
    _fourmView.forumTableView.delegate = self;
    _fourmView.forumTableView.dataSource = self;
    __block __unsafe_unretained id blockSelf = self;
    [_fourmView.forumTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [blockSelf loadDataWithMore:NO isRefresh:YES];
        });
    }];
    // setup infinite scrolling
    [_fourmView.forumTableView addInfiniteScrollingWithActionHandler:^{
        __strong LSForumViewController *strongSelf = blockSelf;
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(!strongSelf.isLoadingData){
                if (strongSelf.totalCount > [strongSelf.tableData count]) {
                    [strongSelf loadDataWithMore:YES isRefresh:NO];
                }else{
                    if (strongSelf.fourmView.forumTableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                        [strongSelf.fourmView.forumTableView.infiniteScrollingView stopAnimating];
                    }
                }
            }else if (strongSelf.fourmView.forumTableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                [strongSelf.fourmView.forumTableView.infiniteScrollingView stopAnimating];
            }
        });
    }];
    [self showLoading:YES];
    [self loadDataWithMore:NO isRefresh:YES];
    
    
    
    //test get fontName
//    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    for (NSString *familyName in familyNames) {
//        NSLog(@"familyName=%@",familyName);
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for (NSString *fontName in fontNames) {
//            NSLog(@"fontName=%@",fontName);
//        }
//    }
}

#pragma mark -
#pragma mark 接口获取数据
-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    _page = isRefresh == YES ? 1 : _page;
    NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=list&type=%@&vieworder=%@&page=%d",_navType,_viewOrder,_page];
    __unsafe_unretained __block LSForumViewController *blockSelf = self;
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            NSLog(@"%@",responseObject);
            _totalCount = [[responseObject objectForKey:@"count"] intValue];
            if (more && !isRefresh) {
                [blockSelf.tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                [blockSelf.fourmView.forumTableView.infiniteScrollingView stopAnimating];
                blockSelf.page = blockSelf.page + 1;
            } else {
                [blockSelf.tableData removeAllObjects];
                [blockSelf.tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                blockSelf.page = 2;
                [blockSelf.fourmView.forumTableView.pullToRefreshView stopAnimating];
            }
        } else {
            [blockSelf.fourmView.forumTableView.pullToRefreshView stopAnimating];
            [blockSelf.tableData removeAllObjects];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
            [blockSelf.tableData addObject:[NSError errorWithDomain:@"" code:-1 userInfo:@{@"NSLocalizedDescription":errorMsg}]];
        }
        [blockSelf showLoading:NO];
        [blockSelf.fourmView.forumTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        blockSelf.isLoadingData = NO;
//        NSLog(@"%@",error);
    }];
    
}

-(void)doActionWithBtn:(UIButton *)btn{
    _navType = [self.forumNavBar.navKeys objectAtIndex:btn.tag];
    _forumTitle = [self.forumNavBar.navTitles objectAtIndex:btn.tag];
    [self showPullToRefresh];
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.3];
}

-(void)reload{
    [self loadDataWithMore:NO isRefresh:YES];
}

-(void)showPullToRefresh{
    [_fourmView.forumTableView.pullToRefreshView startAnimating];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [_tableData objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[NSError class]]) {
        return [LSErrorViewCell tableView:tableView rowHeightForObject:object];
    } else {
        NSString *subject = [[_tableData objectAtIndex:indexPath.row]objectForKey:@"subject"];
        CGSize subjectSize = [subject sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:13] constrainedToSize:CGSizeMake(284, 30)];
        if (subjectSize.height>13) {
            return 50+13;
        } else {
            return 50.0f;
        }
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
    static NSString *LSForumCellInd = @"LSForumCell";
    LSForumCell *cell = [tableView dequeueReusableCellWithIdentifier:LSForumCellInd];
    if (cell == nil) {
        cell = [[LSForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LSForumCellInd];
    }
    [cell setData:cellData];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
    } else {
        cell.backgroundColor = RGBCOLOR(0xf2, 0xf2, 0xf2);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellData = [_tableData objectAtIndex:indexPath.row];
    LSReadViewController *vc = [[LSReadViewController alloc] initWithTid:[cellData objectForKey:@"tid"]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showLoading:(BOOL)show{
    if (show == YES) {
        LSActivityLabel *loadingView = [[LSActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhiteBox];
        loadingView.frame = _fourmView.forumTableView.frame;
        loadingView.text = @"载入中...";
        _fourmView.forumTableView.tableHeaderView = loadingView;
        _fourmView.forumTableView.scrollEnabled = NO;
    } else {
        _fourmView.forumTableView.tableHeaderView = nil;
        _fourmView.forumTableView.scrollEnabled = YES;
    }
}

-(void)showActionBox:(BOOL)isShow{
    if (isShow == YES) {
        _fourmView.actionBox.hidden = NO;
    } else if(isShow == NO) {
        _fourmView.actionBox.hidden = YES;
    }
}


#pragma LSForumViewDelegate
-(void)postdateAction{
    [self closeAction];
    [self.commonBar.centerBtn setTitle:@"最新发表" forState:UIControlStateNormal];
    _viewOrder = @"postdate";
    [self showPullToRefresh];
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.3];
}

-(void)replydateAction{
    [self closeAction];
    [self.commonBar.centerBtn setTitle:@"最后回复" forState:UIControlStateNormal];
    _viewOrder = @"lastpost";
    [self showPullToRefresh];
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.3];
}

-(void)closeAction{
    [self.commonBar showActionBox];
}

-(void)postAction{
    LSPostViewController *vc = [[LSPostViewController alloc] initWithFid:_navType forumTitle:_forumTitle];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}

-(void)dealloc{
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}
@end
