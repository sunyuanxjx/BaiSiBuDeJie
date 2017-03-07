//
//  BSLoginRegisterViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSLoginRegisterViewController.h"


#import "BSLoginRegisterView.h"

#import "BSFastLoginView.h"

#import "BSIoginRegisterField.h"
/*
    1.分析整个结构，上面，输入框，快速登录
    2.划分整体结构，然后在给分别给对应的结构添加子控件.
    3.自定义登录注册界面，用xib描述
    4.添加登录注册界面，因为登录和注册界面外观不一样，业务逻辑差不多，搞一个xib描述两个view,比较简单，如果通过属性设置比较麻烦，需要写代码.
    5.注意：设置登录注册位置时，需要在viewDidLayoutSubviews才准确.
    6.layoutIfNeeded:需要父控件调用.
 
 
 */

@interface BSLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet BSIoginRegisterField *textField;

@end

@implementation BSLoginRegisterViewController
// 点击关闭
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 点击注册账号
- (IBAction)registerBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    _leadCons.constant = _leadCons.constant == 0?-BSScreenW:0;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSLog(@"%f",_inputView.width);
    // 添加登录和注册界面
    BSLoginRegisterView *loginV = [BSLoginRegisterView loginView];
    BSLoginRegisterView *registerV = [BSLoginRegisterView registerView];
    [self.inputView addSubview:loginV];
    [self.inputView addSubview:registerV];
    
    // 添加快速登录界面
    BSFastLoginView *fastLoginV = [BSFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginV];
    
    _textField.placeholderColor = [UIColor redColor];
    _textField.placeholder = @"12323";
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.inputView.width  * 0.5;
    CGFloat h = self.inputView.height;
    
    for (int i = 0; i < self.inputView.subviews.count; i++) {
        UIView *v = self.inputView.subviews[i];
        x = i * w;
        v.frame = CGRectMake(x, y, w, h);
    }
    
    [[self.bottomView.subviews firstObject] setFrame:self.bottomView.bounds];
    
}


@end
