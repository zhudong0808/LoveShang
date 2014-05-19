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
#import "LSGlobal.h"
#import "LSAuthenticateCenter.h"
#import "LSPostViewController.h"
#import "LSViewUtil.h"


@interface LSReadViewController(){
    
}
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) LSReadView *readView;
@property (nonatomic,assign) BOOL isLoadingData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSMutableDictionary *webViewHeightDict;
@property (nonatomic,strong) NSString *subjetTitle;
@property (nonatomic,strong) NSArray *threadArray;

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
    _page = 1;
    self.cView.backgroundColor = [UIColor whiteColor];
    _readView = [[LSReadView alloc] initWithSuperView:self.cView];
    _readView.readTableView.dataSource = self;
    _readView.readTableView.delegate = self;
    _readView.replyTextField.delegate = self;
    _tableData = [NSMutableArray array];
    _webViewHeightDict = [NSMutableDictionary dictionary];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.delegate = self;
    [self.cView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHideAction:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
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
    [self showLoading:YES];
    [self loadDataWithMore:NO isRefresh:YES];
}

#pragma mark -
#pragma mark 接口获取数据
-(void)loadDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    if (isRefresh == YES) {
        [self loadThreadData];
    } else {
        [self loadReplyDataWithMore:YES isRefresh:NO];
    }
}

-(void)loadThreadData{
    NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=view&tid=%@",_tid];
    __unsafe_unretained __block LSReadViewController *blockSelf = self;
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            [blockSelf.readView.readTableView.pullToRefreshView stopAnimating];
            blockSelf.readView.titleLabel.text = [[responseObject objectForKey:@"info"] objectForKey:@"subject"];
            blockSelf.subjetTitle = [[responseObject objectForKey:@"info"] objectForKey:@"subject"];
            blockSelf.threadArray = [NSArray arrayWithObject:[responseObject objectForKey:@"info"]];
            [blockSelf initButtonAction];
            [blockSelf loadReplyDataWithMore:NO isRefresh:YES];
        } else {
            [blockSelf.readView.readTableView.pullToRefreshView stopAnimating];
            [blockSelf.tableData removeAllObjects];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
            [blockSelf.tableData addObject:[NSError errorWithDomain:@"" code:-1 userInfo:@{@"NSLocalizedDescription":errorMsg}]];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        blockSelf.isLoadingData = NO;
//        NSLog(@"%@",error);
//        [LSGlobal showFailedView:@"出错啦"];
    }];
}

-(void)loadReplyDataWithMore:(BOOL)more isRefresh:(BOOL)isRefresh{
    _page = isRefresh == YES ? 1 : _page;
    NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=replaylist&tid=%@&page=%d",_tid,_page];
    __unsafe_unretained __block LSReadViewController *blockSelf = self;
    [[LSApiClientService sharedInstance]getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
            blockSelf.totalCount = [[responseObject objectForKey:@"count"] intValue];
            if (more && !isRefresh) {
                [blockSelf.tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                [blockSelf.readView.readTableView.infiniteScrollingView stopAnimating];
                blockSelf.page = blockSelf.page + 1;
            } else {
                [blockSelf.tableData removeAllObjects];
                [blockSelf.tableData addObjectsFromArray:_threadArray];
                if ([[responseObject objectForKey:@"count"] intValue] > 0) {
                    [blockSelf.tableData addObjectsFromArray:[responseObject objectForKey:@"info"]];
                    blockSelf.page = 2;
                }
                [blockSelf.readView.readTableView.pullToRefreshView stopAnimating];
            }
        } else {
            [blockSelf.readView.readTableView.pullToRefreshView stopAnimating];
            [blockSelf.tableData removeAllObjects];
            NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
            [blockSelf.tableData addObject:[NSError errorWithDomain:@"" code:-1 userInfo:@{@"NSLocalizedDescription":errorMsg}]];
        }
        [blockSelf showLoading:NO];
        [blockSelf.readView.readTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        blockSelf.isLoadingData = NO;
//        NSLog(@"%@",error);
    }];
}
-(void)keyBoardShowAction:(NSNotification *)notice{
    NSDictionary *info = [notice userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        _readView.replyView.frame = CGRectMake(0, APP_CONTENT_HEIGHT - 40 -keyboardSize.height, 320, 40);
    }];
}

-(void)keyBoardHideAction:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        _readView.replyView.frame = CGRectMake(0, APP_CONTENT_HEIGHT - 40, 320, 40);
    }];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView = [touch view];
    if ([touchView isKindOfClass:[UIButton class]] || [touchView isKindOfClass:[UITextField class]]) {
        return NO;
    }
    return YES;
}

- (void)tapGesture:(UIGestureRecognizer *)guesture {
    [_readView.replyTextField resignFirstResponder];
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    LSAuthenticateCompletion completion = ^(BOOL success){
        NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=replay&tid=%@&content=%@&encryptString=%@",_tid,[LSGlobal encodeWithString:_readView.replyTextField.text],[LSAuthenticateCenter getEncryptString]];
        [[LSApiClientService sharedInstance]postPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
                [LSGlobal showProgressHUD:@"发表回复成功" duration:0.5];
                _readView.replyTextField.text = @"";
                [_readView.replyTextField resignFirstResponder];
                [self loadDataWithMore:NO isRefresh:YES];
            } else {
                NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"出错啦";
                [LSGlobal showFailedView:errorMsg];
            }
                [_readView.readTableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//            _isLoadingData = NO;
//            [LSGlobal showFailedView:error.localizedDescription];
        }];
    };
    [[LSAuthenticateCenter shareInstance] authenticateWithBlock:completion];
    return YES;
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

#pragma initButtonAction
-(void)initButtonAction{
    [_readView.uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)uploadAction{
    LSPostViewController *vc = [[LSPostViewController alloc] initWithTid:_tid title:_subjetTitle];
    [self.navigationController pushViewController:vc animated:YES];
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
    cell.webView.frame = CGRectMake(5, 58, 320-10, 10);
    cell.identifer = [cellData objectForKey:@"lou"];
    if ([_webViewHeightDict objectForKey:[cellData objectForKey:@"lou"]]) {
        CGRect webViewFrame = cell.webView.frame;
        webViewFrame.size.height = [[_webViewHeightDict objectForKey:[cellData objectForKey:@"lou"]]intValue];
        cell.webView.frame = webViewFrame;
        cell.webView.alpha = 1;
        cell.line.frame = CGRectMake(0, cell.webView.bottom-1, 320, 1);
        cell.line.hidden = NO;
    }
    [cell setData:cellData];
    cell.delegate = self;
    cell.webView.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
    } else {
        cell.backgroundColor = RGBCOLOR(0xf2, 0xf2, 0xf2);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id cellData = [_tableData objectAtIndex:indexPath.row];
    if ([cellData isKindOfClass:[NSError class]]) {
        return [LSErrorViewCell tableView:tableView rowHeightForObject:cellData];
    } else {
        return [[_webViewHeightDict objectForKey:[[_tableData objectAtIndex:indexPath.row] objectForKey:@"lou"]] floatValue]+58;
    }
}

#pragma mark -
#pragma UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    UIView *view = webView.superview;
    while ([view isKindOfClass:[LSReadCell class]] == NO) {
        view = [view superview];
    }
    LSReadCell *viewCell = (LSReadCell *)view;
    NSIndexPath *indexPath = [_readView.readTableView indexPathForCell:viewCell];
    
    if ([_webViewHeightDict objectForKey:viewCell.identifer] == nil && indexPath != nil) {
        [_webViewHeightDict setObject:[NSNumber numberWithFloat:webView.scrollView.contentSize.height] forKey:viewCell.identifer];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [_readView.readTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}

-(void)dealloc{
    [[[LSApiClientService sharedInstance] operationQueue] cancelAllOperations];
}


#pragma mark - 
#pragma LSReadCellDelegate
-(void)report:(NSString *)pid{
    LSAuthenticateCompletion completion = ^(BOOL success){
        NSString *urlPath = [NSString stringWithFormat:@"bbs.php?action=report&encryptString=%@&tid=%@&pid=%@",[LSAuthenticateCenter getEncryptString],_tid,pid];
        [[LSApiClientService sharedInstance] getPath:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            [LSGlobal showProgressHUD:@"举报成功" duration:1.0];
        } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        }];
    };
    [[LSAuthenticateCenter shareInstance] authenticateWithBlock:completion];
}
@end
