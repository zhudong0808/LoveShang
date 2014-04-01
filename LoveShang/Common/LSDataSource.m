//
//  LSDataSource.m
//  LoveShang
//
//  Created by zhudong on 14-3-26.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSDataSource.h"
#import "LSErrorViewCell.h"


@interface LSDataSource(){
}

@property (nonatomic,strong) NSArray *tableData;
@property (nonatomic,strong) NSString *indetifier;

@end

@implementation LSDataSource


-(id)initWithData:(NSArray *)data indetifier:(NSString *)indetifier{
    if (self == [super init]) {
        _tableData = data;
        _indetifier = indetifier;
    }
    return  self;
}


#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellData = [_tableData objectAtIndex:indexPath.row];
//    if ([cellData isKindOfClass:[NSError class]]) {
        static NSString *errorCell = @"errorCell";
        LSErrorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:errorCell];
        if (!cell) {
            cell = [[LSErrorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:errorCell];
        }
        [cell setObject:cellData];
        return cell;
//    }
    
//    static NSString *CellHeadLineIndetifier = nil;
//    CellHeadLineIndetifier = _indetifier;
//    LSHeadlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellHeadLineIndetifier];
//    if (!cell) {
//        cell = [[LSHeadlineViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellHeadLineIndetifier];
//        [cell setData:cellData];
//    }
//    return cell;
}

@end
