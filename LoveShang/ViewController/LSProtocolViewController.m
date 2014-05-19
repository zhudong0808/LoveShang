//
//  LSProtocolViewController.m
//  LoveShang
//
//  Created by zhudong on 14-5-19.
//  Copyright (c) 2014年 zhudong. All rights reserved.
//

#import "LSProtocolViewController.h"

@interface LSProtocolViewController ()

@end

@implementation LSProtocolViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonToolBarType = LSCommonToolBarProtocol;
    self.showCommonBar = YES;
    self.commonBar.delegate = self;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(12, 70, 320-12, APP_CONTENT_HEIGHT)];
    textView.font = [UIFont systemFontOfSize:12];
    textView.text = @"请新注册爱上网友填写完整，所有用户都需手机号码实名认证。若有问题请联系商务热线：0512-58792363 客服热线：0512-58795805。\n当您申请用户时，表示您已经同意遵守本规章。\n欢迎您入住“爱上网”，爱上网为公共论坛，为维护网上公共秩序和社会稳定，请您自觉遵守以下条款：\n一、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息：\n（一）煽动抗拒、破坏宪法和法律、行政法规实施的；\n（二）煽动颠覆国家政权，推翻社会主义制度的；\n（三）煽动分裂国家、破坏国家统一的；\n（四）煽动民族仇恨、民族歧视，破坏民族团结的；\n（五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；\n（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；\n（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；\n（八）损害国家机关信誉的；\n（九）其他违反宪法和法律行政法规的；\n（十）进行非认证商业广告行为的。\n二、互相尊重，对自己的言论和行为负责。\n三、禁止在申请用户时使用相关本站的词汇，或是带有侮辱、毁谤、造谣类的或是有其含义的各种语言进行注册用户，否则我们会将其删除。\n四、禁止以任何方式对本站进行各种破坏行为。\n五、如果您有违反国家相关法律法规的行为，本站概不负责，您的登录论坛信息均被记录无疑，必要时，我们会向相关的国家管理部门提供此类信息。";
    [self.view addSubview:textView];
}

#pragma LSCommonToolbarDelegate
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissProtocolNotification" object:nil];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
