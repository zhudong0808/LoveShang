//
//  LSPostView.m
//  LoveShang
//
//  Created by zhudong on 14-3-9.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSPostView.h"
#import "LSViewUtil.h"

@implementation LSPostView

@synthesize forumNavView = _forumNavView;
@synthesize titleTextView = _titleTextView;
@synthesize titleTextField = _titleTextField;
@synthesize contentTextField = _contentTextField;
@synthesize postBar = _postBar;
@synthesize uploadBtn = _uploadBtn;
@synthesize keyboardBtn = _keyboardBtn;
@synthesize postBtn = _postBtn;
@synthesize forumTitleLabel = _forumTitleLabel;

-(LSPostView *)initWithSuperView:(UIView *)superView{
    if (self = [super init]) {
        superView.backgroundColor = RGBCOLOR(0xf2, 0xf2, 0xf2);
        _forumNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 30)];
        _forumNavView.backgroundColor = [UIColor whiteColor];
        [superView addSubview:_forumNavView];
        
        UIImageView *forumNavIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"post_0002_分类icon.png"]];
        forumNavIcon.frame = CGRectMake(15, 30/2-15/2, 15, 15);
        [_forumNavView addSubview:forumNavIcon];
        
        UILabel *postTitleLabel = [LSViewUtil simpleLabel:CGRectMake(forumNavIcon.right + 12, 30/2-14/2, 70, 14) f:14 tc:RGBCOLOR(156,189,75) t:@"发帖到 >"];
        [_forumNavView addSubview:postTitleLabel];
        
        _forumTitleLabel = [LSViewUtil simpleLabel:CGRectMake(postTitleLabel.right-10, 30/2-20/2, 320-30-15-12-60, 20) f:14 tc:RGBCOLOR(156, 189, 75) t:@""];
        [_forumNavView addSubview:_forumTitleLabel];
        
        
        _titleTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, 320, 40)];
        _titleTextView.backgroundColor = RGBCOLOR(0xe6, 0xe6, 0xe6);
        [superView addSubview:_titleTextView];
        
        _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 40/2-25/2, 320-30, 25)];
        _titleTextField.font = [UIFont systemFontOfSize:20];
        _titleTextField.textAlignment = NSTextAlignmentLeft;
        _titleTextField.placeholder = @"输入标题";
        _titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _titleTextField.backgroundColor = [UIColor clearColor];
        [_titleTextView addSubview:_titleTextField];
        
        _contentTextField = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(8, _titleTextView.bottom, 304, 200)];
//        _contentTextField.maxHeight = 200;
        _contentTextField.backgroundColor = RGBCOLOR(0xf2, 0xf2, 0xf2);
        _contentTextField.placeholder = @"输入内容";
        _contentTextField.placeholderColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        [superView addSubview:_contentTextField];
        
        _postBar = [[UIView alloc] initWithFrame:CGRectMake(0, APP_CONTENT_HEIGHT - 50, 320, 50)];
        _postBar.backgroundColor = RGBCOLOR(0x6d, 0x6e, 0x71);
        [superView addSubview:_postBar];
        
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uploadBtn.frame = CGRectMake(20, 50/2-23/2, 27, 23);
        [_uploadBtn setImage:[UIImage imageNamed:@"post_0008_photo.png"] forState:UIControlStateNormal];
        [_postBar addSubview:_uploadBtn];
        
        _keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _keyboardBtn.frame = CGRectMake(_uploadBtn.right + 10, 50/2-23/2, 27, 23);
        [_keyboardBtn setImage:[UIImage imageNamed:@"post_0006_键盘.png"] forState:UIControlStateNormal];
        [_postBar addSubview:_keyboardBtn];
        
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.frame = CGRectMake(320-70, 50/2-20/2, 40, 20);
        [_postBtn setImage:[UIImage imageNamed:@"post_0005_发布.png"] forState:UIControlStateNormal];
        [_postBar addSubview:_postBtn];
        
        UIView *uploadImageView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_CONTENT_HEIGHT - 50 -80, 320, 80)];
        uploadImageView.backgroundColor = [UIColor clearColor];
        [superView addSubview:uploadImageView];
        [LSViewUtil drawLine:CGRectMake(0, 0, 320, 1) onView:uploadImageView color:RGBCOLOR(0xe6, 0xe6, 0xe6)];
        
        _uploadImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 1, 320, 79)];
        _uploadImageScrollView.showsHorizontalScrollIndicator = NO;
        _uploadImageScrollView.showsVerticalScrollIndicator = NO;
        _uploadImageScrollView.contentSize = CGSizeMake(320, 79);
        [uploadImageView addSubview:_uploadImageScrollView];
    }
    return self;
}
@end
