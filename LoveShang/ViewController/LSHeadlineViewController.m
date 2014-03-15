//
//  LSHeadlineViewController.m
//  LoveShang
//
//  Created by zhudong on 13-10-17.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSHeadlineViewController.h"
#import "LSErrorViewCell.h"
#import "LSViewUtil.h"
#import "LSHeadlineViewCell.h"
#import "LSReadViewController.h"

@interface LSHeadlineViewController(){

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSMutableArray *advertData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSString *navType;
@property (nonatomic,strong) UIScrollView *slideView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *slideTitleLabel;
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
    _advertData = [[NSMutableArray alloc] init];
    
    [self loadAdvert];
    
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+30.5 + 170, self.cView.frame.size.width, APP_CONTENT_HEIGHT - 44 - 30.5 - 170 - 44) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    [self.cView addSubview:_tableView];
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
    
    //初始化幻灯片
    if (!_slideView) {
        _slideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+30.5, self.cView.frame.size.width, 170)];
        _slideView.pagingEnabled = YES;
        _slideView.delegate = self;
        _slideView.showsHorizontalScrollIndicator = NO;
        [self.cView addSubview:_slideView];
    }
    _slideView.contentSize = CGSizeMake(self.cView.frame.size.width * [_advertData count], 170);
    
    NSInteger i = 0;
    for (UIView *subView in [_slideView subviews]) {
        [subView removeFromSuperview];
    }
    if ([_advertData count] == 0) {
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
        picView.image = [UIImage imageNamed:@"loading.png"];
        [_slideView addSubview:picView];
    } else {
        for (NSDictionary *item in _advertData) {
            UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 170)];
            picView.image = [UIImage imageNamed:@"loading.png"];
            [picView setImageWithURL:[NSURL URLWithString:[item objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
            [_slideView addSubview:picView];
            i++;
        }
    }
    for (UIView *subView in [self.cView subviews]) {
        if (subView.tag == 10000) {
            [subView removeFromSuperview];
        }
    }
    if ([_advertData count] > 0) {
        UIView *slideTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 44+30.5+144, 320, 26)];
        slideTitleView.backgroundColor = [UIColor whiteColor];
        slideTitleView.alpha = 0.8;
        slideTitleView.tag = 10000;
        [self.cView addSubview:slideTitleView];
        
        _slideTitleLabel = [LSViewUtil simpleLabel:CGRectMake(12, 0, 245, 26) f:14 tc:RGBCOLOR(0x00, 0x00, 0x00) t:[[_advertData objectAtIndex:0] objectForKey:@"subject"]];
        [slideTitleView addSubview:_slideTitleLabel];
        if ([_advertData count] > 1) {
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(250, 0, 70, 26)];
            _pageControl.pageIndicatorTintColor = RGBCOLOR(0xbf, 0xc2, 0xc2);
            _pageControl.currentPageIndicatorTintColor = RGBCOLOR(0x95, 0x98, 0x9a);
            _pageControl.currentPage = 0;
            [slideTitleView addSubview:_pageControl];
        }
        _pageControl.numberOfPages = [_advertData count];
    }
}

-(void)doActionWithBtn:(UIButton *)btn{
    _navType = [self.navBar.navKeys objectAtIndex:btn.tag];
    [self loadDataWithMore:NO isRefresh:YES];
    [self loadAdvert];
}
#pragma mark -
#pragma mark 接口获取数据
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
            [_tableView.pullToRefreshView stopAnimating];
            [_tableData removeAllObjects];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
            [_tableData addObject:[NSError errorWithDomain:@"" code:-1 userInfo:@{@"NSLocalizedDescription":errorMsg}]];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        [_tableView.pullToRefreshView stopAnimating];
        _isLoadingData = NO;
        NSLog(@"%@",error);
    }];
    
}

-(void)loadAdvert{
    NSString *urlPath = [NSString stringWithFormat:@"advert.php?tag=%@",_navType];
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            [_advertData addObjectsFromArray:[responseObject objectForKey:@"info"]];
        }
        [self loadAndRenderSlideView];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        _isLoadingData = NO;
        NSLog(@"%@",error);
    }];
    
}
#pragma mark -
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = _slideView.contentOffset.x/320;
    _pageControl.currentPage = currentPage;
    _slideTitleLabel.text = [[_advertData objectAtIndex:currentPage] objectForKey:@"subject"];
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
    
    static NSString *CellHeadLineIndetifier = @"CellHeadLineIdentifier";
    LSHeadlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellHeadLineIndetifier];
    if (!cell) {
        cell = [[LSHeadlineViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellHeadLineIndetifier];
        [cell setData:cellData];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellData = [_tableData objectAtIndex:indexPath.row];
    LSReadViewController *vc = [[LSReadViewController alloc] initWithTid:[cellData objectForKey:@"tid"]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
