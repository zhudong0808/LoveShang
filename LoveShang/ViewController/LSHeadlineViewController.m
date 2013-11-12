//
//  LSHeadlineViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSHeadlineViewController.h"
#import "LSErrorViewCell.h"

@interface LSHeadlineViewController(){

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSString *navType;
@property (nonatomic,strong) UIScrollView *slideView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation LSHeadlineViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolbarIndex;
    self.showCommonBar = YES;
    self.showNavBar = YES;
    self.navBar.delegate = self;
    _navType = @"all";
    
    _page = 1;
    _tableData = [[NSMutableArray alloc] init];
    
    
    //初始化幻灯片
    if (!_slideView) {
        _slideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+32+1, self.view.frame.size.width, 145)];
        _slideView.contentSize = CGSizeMake(self.view.frame.size.width * 3, 145);
        _slideView.pagingEnabled = YES;
        _slideView.delegate = self;
    }
    [self.view addSubview:_slideView];
    [self loadAndRenderSlideView];
    
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+32+1 + 145, self.view.frame.size.width, self.view.frame.size.height - 40 -35 - self.tabBarController.tabBar.frame.size.height - 145) style:UITableViewStylePlain];
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

-(void)loadAndRenderSlideView{
    for (int i = 0; i < 3; i++) {
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 145)];
        picView.image = [UIImage imageNamed:@"loading.png"];
        [picView setImageWithURL:[NSURL URLWithString:@"http://img.loveshang.com/attachment/Mon_1110/92_75978_c6c69f5abe4d90c.jpg?675"] placeholderImage:[UIImage imageNamed:@"loading.png"]];
        [_slideView addSubview:picView];
    }

//    UIView *pageControlBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 145-26, 320, 26)];
//    pageControlBackGround.backgroundColor = [[UIColor whiteColor] setA]
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(220, 44+32+1+145 - 26, 100, 26)];
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPage = 0;
    }
    [self.view addSubview:_pageControl];
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 75/2 - 58/2, 85, 58)];
    imageView.image = [UIImage imageNamed:@"loading.png"];
    [imageView setImageWithURL:[NSURL URLWithString:[cellData objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11, self.view.frame.size.width - 95, 15)];
    titleLabel.text = [cellData objectForKey:@"subject"];
    titleLabel.textColor = [LSColorStyleSheet colorWithName:LSColorGrayText];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 + 12, 11 + 15 + 8, self.view.frame.size.width - 95, 12)];
    contentLabel.text = [cellData objectForKey:@"introduction"];
    contentLabel.textColor = [LSColorStyleSheet colorWithName:LSColorLightGrayText];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell addSubview:imageView];
    [cell addSubview:titleLabel];
    [cell addSubview:contentLabel];
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [_tableData objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[NSError class]]) {
        return [LSErrorViewCell tableView:tableView rowHeightForObject:object];
    } else {
       return 75.0;
    }
}


-(void)doActionWithBtn:(UIButton *)btn{
    _navType = [self.navBar.navKeys objectAtIndex:btn.tag];
    [self loadDataWithMore:NO isRefresh:YES];
}

-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    NSString *urlPath = [NSString stringWithFormat:@"top.php?tag=%@",_navType];
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
#pragma scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = _slideView.contentOffset.x/320;
    _pageControl.currentPage = currentPage;
}

@end
