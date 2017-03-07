//
//  XJXMeViewController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/24.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXMeViewController.h"
#import "XJXSettingViewController.h"
#import "XJXSquareCell.h"
#import "XJXSquareItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "XJXWebViewController.h"
#import <WebKit/WebKit.h>

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH ((XJXScreenW - (cols - 1) * margin) / cols)


@interface XJXMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

/**  **/
@property(nonatomic, strong) NSMutableArray *squareItems;

/**  **/
@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation XJXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置导航条
    [self setupNavbar];
    // 2.设置底部视图
    [self setupFootView];
    // 3.请求数据
    [self loadData];
    
    // 处理cell间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}

// 3.请求数据
-(void)loadData
{
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    // 3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"square_list"];
        // 字典数组转换为模型数组
        _squareItems = [XJXSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        // 处理数据
        [self resolveData];
        
        // 设置collectionView 计算高度
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        // 设置高度
        self.collectionView.xjx_height = rows * itemWH;
        // 设置tableView滚动范围
        self.tableView.tableFooterView = self.collectionView;
        
        // 刷新表格
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)resolveData
{
    // 判断最后一行缺几个
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter)
    {
        exter = cols - exter;
    
        for (NSInteger i = 0; i < exter; i++)
        {
            XJXSquareItem *item = [[XJXSquareItem alloc] init];
            
            [self.squareItems addObject:item];
            
        }
    }
    
}

// 2.设置底部视图
-(void)setupFootView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    self.tableView.tableFooterView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 让scrollEnabled 不能滚动
    collectionView.scrollEnabled = NO;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"XJXSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
}

#pragma mark -- UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转界面 push
    /*
     1.Safari openURL:自带很多功能(进度条,刷新,前进,倒退等等功能),必须要跳出当前应用
     2.UIWebView(没有功能), 在当前应用打开网页,并且有Safari,自己实现,UIWebView不能实现进度条
     3.SFSafariViewController:专门用来展示网页 需求:既想要在当前应用展示网页,又想要Safari功能
     需要#import <SafariServices/SafariServices.h>  iOS9才能使用
     4.WKWebView
     
     */
    
    XJXWebViewController *webVC = [[XJXWebViewController alloc] init];
    XJXSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) {
        return;
    }
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    
    
    /* 第一种方法
    NSLog(@"薛娇贤我爱你");
    XJXSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:item.url];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
    */
    

}

//#pragma mark -- SFSafariViewControllerDelegate
//-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    XJXSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

// 1.设置导航条
-(void)setupNavbar
{
    // 设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模式,选中状态
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    // 右边两个按钮,传数组
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    // title
    self.navigationItem.title = @"我的";
}

// 设置
-(void)setting
{
    // 跳转到设置界面
    XJXSettingViewController *settingVC = [[XJXSettingViewController alloc] init];
    // 推进到设置界面
    [self.navigationController pushViewController:settingVC animated:YES];
    
    // 隐藏底部条,必须在跳转之前设置
}

// 夜间模式
-(void)night:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
