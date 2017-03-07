//
//  XJXAdViewController.m
//  BuDeJie
//
//  Created by 孙远 on 2016/11/30.
//  Copyright © 2016年 sunyuan. All rights reserved.
//

#import "XJXAdViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "XJXAdItem.h"
#import "UIImageView+WebCache.h"
#import "XJXTabBarController.h"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface XJXAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
/**  **/
@property(nonatomic, weak) UIImageView *adView;
/**  **/
@property(nonatomic, strong) XJXAdItem *item;
/** 定时器(系统会管理,用weak指针) **/
@property(nonatomic, weak) NSTimer *timer;
// 跳转按钮
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@end

@implementation XJXAdViewController

// 点击跳转做的事情
- (IBAction)jumpBtnClick:(UIButton *)sender {
    
    // 销毁广告界面,进入主框架界面
    XJXTabBarController *tabBar = [[XJXTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    // 干掉定时器
    [_timer invalidate];
}

-(UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContainView addSubview:imageView];
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        
        _adView = imageView;
    }
    return _adView;
}

-(void)tap
{
    // 点击广告界面跳转 => safari
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载广告数据 => 拿到活时间 => 服务器 => 查看接口文档 1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转广告界面,w,h) => 请求数据(AFN)
    
    // 导入AFN框架:cocopods
    // cocodpods:管理第三方库,cocodpods做的事情 :导入一个 框架,会把这个框架依赖的所有框架都导入
    // cocodpods步骤:podfile:描述需要导入哪些框架
    
    [self loadAdData];
    
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
/*
    1.以后添加东西,首先想到添加多少次
 
 */

-(void)timeChange
{
    // 倒计时
    static int i = 3;
    if (i == 0) {
        [self jumpBtnClick:nil];
    }
    i--;
    
    // 设置跳转按钮文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转(%d)", i] forState:UIControlStateNormal];
}


#pragma mark --加载广告数据
- (void)loadAdData
{
    
    // unacceptable content-type: text/html"  响应头
    
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    // 3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/sunyuan/Desktop/AD.plist" atomically:YES];
        // 请求数据 -> 解析数据(写成plist文件) -> 设计模型 -> 字典转模型 ->展示数据
        // 获取字典
        NSDictionary *adDict =  [responseObject[@"ad"] lastObject];
        
        // 字典转模型
        XJXAdItem *item = [XJXAdItem mj_objectWithKeyValues:adDict];
        _item = item;
        // 创建UIImageView展示图片 =>
        CGFloat h = XJXScreenW / item.w * item.h;
        self.adView.frame = CGRectMake(0, 0, XJXScreenW, h);
        // 加载广告页面
        [self.adView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}



-(void)setupLaunchImage
{
    if (iPhone7plus)
    {
       self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone7)
    {
       self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }
    else if (iPhone5)
    {
        self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    }
    else if (iPhone4)
    {
        self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }
}



@end
