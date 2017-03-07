//
//  XJXFriendTrendViewController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/24.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXFriendTrendViewController.h"
#import "XJXLoginRegisterViewController.h"
@interface XJXFriendTrendViewController ()

@end

@implementation XJXFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self setupNavBar];
}

// 设置 导航栏
-(void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsComment)];
    
    // title
    self.navigationItem.title = @"我的关注";
}


-(void)friendsComment
{
    NSLog(@"薛娇贤我爱你");
}


// 登录注册按钮点击
// 推进登录注册页面控制器
- (IBAction)loginRegisterBtnClick:(id)sender{
    XJXLoginRegisterViewController *loginRegisterVC = [[XJXLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
