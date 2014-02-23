//
//  LSReadViewControllerCell.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSReadViewController.h"
#import "LSReadView.h"
#import "LSActivityLabel.h"
#import "LSErrorViewCell.h"
#import "LSReadCell.h"

@interface LSReadViewController(){
    
}
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) LSReadView *readView;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSMutableArray *tableData;

@end

@implementation LSReadViewController

-(id)initWithTid:(NSString *)tid{
    if (self = [super init]) {
        _tid = tid;
    }
    return self;
}

-(void)viewDidLoad{
    self.commonToolBarType = LSCommonToolbarRead;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    
    _readView = [[LSReadView alloc] initWithSuperView:self.cView];
    _readView.readTableView.dataSource = self;
    _readView.readTableView.delegate = self;
    _tableData = [NSMutableArray array];
    
    __block __unsafe_unretained id blockSelf = self;
    [_readView.readTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [blockSelf loadDataWithMore:NO isRefresh:YES];
        });
    }];
    // setup infinite scrolling
    [_readView.readTableView addInfiniteScrollingWithActionHandler:^{
        __strong LSReadViewController *strongSelf = blockSelf;
        int64_t delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(!strongSelf.isLoadingData){
                if (strongSelf.totalCount > [strongSelf.tableData count]) {
                    [strongSelf loadDataWithMore:YES isRefresh:NO];
                }else{
                    if (strongSelf.readView.readTableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                        [strongSelf.readView.readTableView.infiniteScrollingView stopAnimating];
                    }
                }
            }else if (strongSelf.readView.readTableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading){
                [strongSelf.readView.readTableView.infiniteScrollingView stopAnimating];
            }
            
        });
    }];
    [self loadDataWithMore:NO isRefresh:YES];
}

#pragma mark -
#pragma mark 接口获取数据
-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    [self showLoading:YES];
    NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=view&tid=%@",_tid];
    NSLog(@"urlPath=%@",urlPath);
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            [_readView.readTableView.pullToRefreshView stopAnimating];
            //设置标题
            NSDictionary *threadData = [responseObject objectForKey:@"info"];
            _readView.titleLabel.text = [threadData objectForKey:@"subject"];
            [_readView.landlordIconView setImageWithURL:[NSURL URLWithString:[threadData objectForKey:@"faceurl"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
            _readView.landlordNameLabel.text = [threadData objectForKey:@"author"];
            _readView.landlordPostdateLabel.text = [threadData objectForKey:@"postdate"];
            [self showLoading:NO];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        _isLoadingData = NO;
        NSLog(@"%@",error);
    }];
}

-(void)showLoading:(BOOL)show{
    if (show == YES) {
        self.isLoadingData = YES;
        LSActivityLabel *loadingView = [[LSActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhiteBox];
        loadingView.frame = _readView.readTableView.frame;
        loadingView.text = @"载入中...";
        _readView.readTableView.tableHeaderView = loadingView;
        _readView.readTableView.scrollEnabled = NO;
    } else {
        self.isLoadingData = NO;
        _readView.readTableView.tableHeaderView = _readView.headerView;
        _readView.readTableView.scrollEnabled = YES;
    }
}


#pragma LSCommonToolbarDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


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
    static NSString *LSReadCellInd = @"LSReadCell";
    LSReadCell *cell = [tableView dequeueReusableCellWithIdentifier:LSReadCellInd];
    if (cell == nil) {
        cell = [[LSReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LSReadCellInd];
    }
    [cell setData:cellData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
