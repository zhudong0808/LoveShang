//
//  LSReadView.m
//  LoveShang
//
//  Created by zhudong on 13-12-22.
//  Copyright (c) 2013年 zhudong. All rights reserved.
//

#import "LSReadView.h"
#import "LSViewUtil.h"

@implementation LSReadView

@synthesize readTableView = _readTableView;
@synthesize titleLabel = _titleLabel;
@synthesize headerView = _headerView;
@synthesize landlordIconView = _landlordIconView;
@synthesize landlordNameLabel = _landlordNameLabel;
@synthesize landlordPostdateLabel = _landlordPostdateLabel;
@synthesize replyTextField = _replyTextField;
@synthesize uploadBtn = _uploadBtn;
@synthesize replyView = _replyView;

-(id)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        _readTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, superView.height - 44 - 40) style:UITableViewStylePlain];
        _readTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _readTableView.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
        [superView addSubview:_readTableView];
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [LSViewUtil simpleLabel:CGRectMake(15, 0, 320-30, 40) bf:15 tc:RGBCOLOR(0x99, 0x8c, 0x51) t:@""];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 2;
        [_headerView addSubview:_titleLabel];
        
        _replyView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_CONTENT_HEIGHT - 40, 320, 40)];
        _replyView.backgroundColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        [superView addSubview:_replyView];
        
        UIImageView *replyLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0000_logo.png"]];
        replyLogo.frame = CGRectMake(6, 3, 31, 31);
        [_replyView addSubview:replyLogo];
        
        UIImageView *textFieldBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0004_输入对话框.png"]];
        textFieldBG.frame = CGRectMake(replyLogo.right + 7, 40/2-67/4, 269, 33.5);
        textFieldBG.userInteractionEnabled = YES;
        [_replyView addSubview:textFieldBG];
        
        _replyTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 33.5/2- 20/2, 200, 20)];
        [textFieldBG addSubview:_replyTextField];
        _replyTextField.placeholder = @"写回帖";
        _replyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _replyTextField.font = [UIFont systemFontOfSize:13];
        _replyTextField.returnKeyType = UIReturnKeySend;
        
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uploadBtn.frame = CGRectMake(269-35, 33.5/2 - 17.5/2, 20, 17.5);
        [_uploadBtn setImage:[UIImage imageNamed:@"_0003_photo.png"] forState:UIControlStateNormal];
        [textFieldBG addSubview:_uploadBtn];
        
    }
    return self;
}

@end
