//
//  LSPostViewController.m
//  LoveShang
//
//  Created by zhudong on 14-3-9.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSPostViewController.h"
#import "LSPostView.h"
#import "LSGlobal.h"
#import "LSReadViewController.h"
#import "LSAuthenticateCenter.h"

@interface LSPostViewController ()

@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) LSPostView *postView;
@property (nonatomic,assign) BOOL isKeyboardShow;
@property (nonatomic,strong) NSMutableDictionary *selectedImageDict;
@property (nonatomic,strong) NSString *subjectTitle;
@property (nonatomic,strong) NSString *forumTitle;

@end

@implementation LSPostViewController


-(id)initWithTid:(NSString *)tid title:(NSString *)subjectTitle{
    if (self = [super init]) {
        _tid = tid;
        _isKeyboardShow = NO;
        _subjectTitle = subjectTitle;
    }
    return self;
}


-(id)initWithFid:(NSString *)fid forumTitle:(NSString *)forumTitle{
    if (self == [super init]) {
        _fid = fid;
        _isKeyboardShow = NO;
        _forumTitle = forumTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonToolBarType = [_tid length] > 0 ? LSCommonToolbarReply : LSCommonToolbarPost;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    _selectedImageDict = [[NSMutableDictionary alloc] init];
    _postView = [[LSPostView alloc] initWithSuperView:self.cView];
    [self setupReplayView];
    [self setupPostView];
    [self initKeyboardNotification];
    [self initBtnAction];
}

-(void)setupReplayView{
    if ([_tid length] == 0) {
        return;
    }
    _postView.titleTextView.hidden = YES;
    _postView.contentTextField.frame = CGRectMake(0, _postView.titleTextView.frame.origin.y, _postView.contentTextField.frame.size.width, _postView.contentTextField.frame.size.height + 40);
    _postView.forumTitleLabel.text = _subjectTitle;
    [self performSelector:@selector(uploadAction) withObject:nil afterDelay:0.5];
}

-(void)setupPostView{
    if ([_fid length] == 0) {
        return;
    }
    _postView.forumTitleLabel.text = _forumTitle;
}

-(void)initKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideAction:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardShowAction:(NSNotification *)notice{
    _isKeyboardShow = YES;
    [_postView.keyboardBtn setImage:[UIImage imageNamed:@"post_0007_键盘-点击后.png"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        NSDictionary *userInfo = notice.userInfo;
        NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGSize size = [value CGRectValue].size;
        _postView.postBar.frame = CGRectMake(0, APP_CONTENT_HEIGHT-50-size.height, 320, 50);
    }];
}

-(void)keyboardHideAction:(NSNotification *)notice{
    _isKeyboardShow = NO;
    [_postView.keyboardBtn setImage:[UIImage imageNamed:@"post_0006_键盘.png"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _postView.postBar.frame = CGRectMake(0, APP_CONTENT_HEIGHT-50, 320, 50);
    }];
}

-(void)initBtnAction{
    [_postView.uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    [_postView.keyboardBtn addTarget:self action:@selector(keyboardAction) forControlEvents:UIControlEventTouchUpInside];
    [_postView.postBtn addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)uploadAction{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)keyboardAction{
    if (_isKeyboardShow == YES) {
        [_postView.titleTextField resignFirstResponder];
        [_postView.contentTextField resignFirstResponder];
    } else {
        [_postView.contentTextField becomeFirstResponder];
    }
}

-(void)postAction{
    [_postView.postBtn setEnabled:NO];
    if ([self checkField] == false) {
        [_postView.postBtn setEnabled:YES];
        return;
    }
    __unsafe_unretained __block LSPostViewController *blockSelf = self;
    if ([_tid length] > 0) {
        LSAuthenticateCompletion completion = ^(BOOL success){
            NSString *urlPath = [NSString stringWithFormat:@"http://www.loveshang.com/mapi/bbs.php?action=replay&tid=%@&content=%@&encryptString=%@",blockSelf.tid,[LSGlobal encodeWithString:blockSelf.postView.contentTextField.text],[LSAuthenticateCenter getEncryptString]];
            NSMutableURLRequest *request = [[LSApiClientService sharedInstance] multipartFormRequestWithMethod:@"POST" path:urlPath parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData){
                if ([blockSelf.selectedImageDict count] > 0) {
                    for (NSString *key in blockSelf.selectedImageDict.allKeys) {
                        [formData appendPartWithFileData:[blockSelf.selectedImageDict objectForKey:key] name:[NSString stringWithFormat:@"attachments_%@",key] fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    }
                }
            }];
            AFHTTPRequestOperation *operation = [[LSApiClientService sharedInstance] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation,id responseObject){
                if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
                    LSReadViewController *vc = [[LSReadViewController alloc] initWithTid:blockSelf.tid];
                    [blockSelf.navigationController pushViewController:vc animated:YES];
                } else {
                    [blockSelf.postView.postBtn setEnabled:YES];;
                    NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"回帖失败";
                    [LSGlobal showFailedView:errorMsg];
                }
            }  failure:^(AFHTTPRequestOperation *operation,NSError *error){
                [blockSelf.postView.postBtn setEnabled:YES];
                [LSGlobal showFailedView:@"回帖失败"];
            }];
            [[LSApiClientService sharedInstance] enqueueHTTPRequestOperation:operation];
        };
        [[LSAuthenticateCenter shareInstance] authenticateWithBlock:completion];
    } else {
        LSAuthenticateCompletion completion = ^(BOOL success){
            NSString *urlPath = [NSString stringWithFormat:@"http://www.loveshang.com/mapi/bbs.php?action=postnew&fid=%@&subject=%@&content=%@&encryptString=%@",blockSelf.fid,[LSGlobal encodeWithString:blockSelf.postView.titleTextField.text],[LSGlobal encodeWithString:blockSelf.postView.contentTextField.text],[LSAuthenticateCenter getEncryptString]];
            NSMutableURLRequest *request = [[LSApiClientService sharedInstance] multipartFormRequestWithMethod:@"POST" path:urlPath parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData){
                if ([blockSelf.selectedImageDict count] > 0) {
                    for (NSString *key in blockSelf.selectedImageDict.allKeys) {
                        [formData appendPartWithFileData:[blockSelf.selectedImageDict objectForKey:key] name:[NSString stringWithFormat:@"attachments_%@",key] fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
                    }
                }
            }];
            AFHTTPRequestOperation *operation = [[LSApiClientService sharedInstance] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation,id responseObject){
                if ([[responseObject objectForKey:@"state"] isEqualToString:@"success"]) {
                    LSReadViewController *vc = [[LSReadViewController alloc] initWithTid:blockSelf.tid];
                    [blockSelf.navigationController pushViewController:vc animated:YES];
                } else {
                    [blockSelf.postView.postBtn setEnabled:YES];;
                    NSString *errorMsg = [[responseObject objectForKey:@"message"] length] > 0 ? [responseObject objectForKey:@"message"] : @"发帖失败";
                    [LSGlobal showFailedView:errorMsg];
                }
            }  failure:^(AFHTTPRequestOperation *operation,NSError *error){
                [blockSelf.postView.postBtn setEnabled:YES];
                [LSGlobal showFailedView:@"发帖失败"];
            }];
            [[LSApiClientService sharedInstance] enqueueHTTPRequestOperation:operation];
        };
        [[LSAuthenticateCenter shareInstance] authenticateWithBlock:completion];
    }
}

-(NSMutableDictionary *)getAttachDict{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if ([_selectedImageDict count] > 0) {
        for (NSString *key in _selectedImageDict.allKeys) {
            [parameters setObject:[_selectedImageDict objectForKey:key] forKey:[NSString stringWithFormat:@"attachments_%@",key]];
        }
    }
    return parameters;
}

-(BOOL)checkField{
    if ([_tid length] == 0 && [_postView.titleTextField.text length] == 0) {
        [LSGlobal showFailedView:@"请输入标题"];
        return false;
    }
    if ([_postView.contentTextField.text length] == 0) {
        [LSGlobal showFailedView:@"请输入内容"];
    }
    return true;
}


#pragma UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self pickImageFromCamera];
            break;
        case 1:
            [self pickImageFromPhotoLibrary];
        default:
            break;
    }
}

-(void)pickImageFromCamera{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)pickImageFromPhotoLibrary{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSInteger selectImageCount = [_selectedImageDict count];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image.size.width < image.size.height) {
        if (image.size.width>600) {
            image = [self scaleFromImage:image toSize:CGSizeMake(600,600/image.size.width*image.size.height)];
        }
    } else {
        if (image.size.height>600) {
            image = [self scaleFromImage:image toSize:CGSizeMake(600/image.size.height*image.size.width,600)];
        }
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 0.15);
    
    UIImageView *uploadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"post_0001_图片.png"]];
    uploadImageView.frame = CGRectMake(13+77*[_selectedImageDict count], 80/2-64/2, 64, 64);
    uploadImageView.userInteractionEnabled = YES;
    [_postView.uploadImageScrollView addSubview:uploadImageView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(64/2-55/2, 64/2-55/2, 55, 55);
    [uploadImageView addSubview:imageView];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.contentMode = UIViewContentModeCenter;
    [delBtn setImage:[UIImage imageNamed:@"post_0000_删除图片.png"] forState:UIControlStateNormal];
    delBtn.imageEdgeInsets = UIEdgeInsetsMake(40/2-21/2, 40/2-21/2, 40/2-21/2, 40/2-21/2);
    delBtn.frame = CGRectMake(-19, -19, 40, 40);
    delBtn.tag = selectImageCount + 1;
    [delBtn addTarget:self action:@selector(delImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [uploadImageView addSubview:delBtn];
    
    [_selectedImageDict setObject:imageData forKey:[NSString stringWithFormat:@"%d",selectImageCount+1]];
    [self resizeScrollWidth];
}

-(void)delImageAction:(id)sender{
    UIButton *delBtn = (UIButton *)sender;
    NSInteger tag = delBtn.tag;
    UIView *uploadImageView = [delBtn superview];
    [uploadImageView removeFromSuperview];
    [self reloadSelectedImageDict:tag];
    [self reloadSelectedImageFrame];
    [self resizeScrollWidth];
}

-(void)reloadSelectedImageDict:(NSInteger)tag{
    NSMutableDictionary *newSelectedImageDict = [[NSMutableDictionary alloc] init];
    [_selectedImageDict removeObjectForKey:[NSString stringWithFormat:@"%d",tag]];
    NSInteger newDictKey = 1;
    for (NSString *btnKey in _selectedImageDict.allKeys) {
        [newSelectedImageDict setObject:[_selectedImageDict objectForKey:btnKey] forKey:[NSString stringWithFormat:@"%d",newDictKey]];
        newDictKey++;
    }
    [_selectedImageDict removeAllObjects];
    [_selectedImageDict setDictionary:newSelectedImageDict];
}

-(void)reloadSelectedImageFrame{
    NSInteger imageCount = 0;
    for (UIView *subView in [_postView.uploadImageScrollView subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            subView.frame = CGRectMake(13+77*imageCount, 80/2-64/2, 64, 64);
            imageCount++;
            for(UIView *subView2 in [subView subviews]){
                if ([subView2 isKindOfClass:[UIButton class]]) {
                    subView2.tag = imageCount;
                }
            }
        }
    }
}

-(void)resizeScrollWidth{
    if ([_selectedImageDict count] > 4) {
        CGSize scrollContentSize = _postView.uploadImageScrollView.contentSize;
        _postView.uploadImageScrollView.contentSize = CGSizeMake(scrollContentSize.width+([_selectedImageDict count]-4)*77, scrollContentSize.height);
    }
}

#pragma mark 缩放图片
-(UIImage *)scaleFromImage: (UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma LSCommonToolbarDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
