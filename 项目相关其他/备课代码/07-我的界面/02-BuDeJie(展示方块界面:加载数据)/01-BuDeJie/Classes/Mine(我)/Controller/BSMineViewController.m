//
//  BSMineViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSMineViewController.h"

#import "UIBarButtonItem+Item.h"

#import "BSSettingViewController.h"

#import "BSSquareCell.h"

#import "BSSquareItem.h"

#import <AFNetworking/AFNetworking.h>

#import <MJExtension/MJExtension.h>

static NSString * const ID = @"cell";

@interface BSMineViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *squareList;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation BSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    // 设置尾部视图
    [self setUpFootView];
    
    // 加载数据
    [self loadData];
}

// 请求数据
- (void)loadData
{
    
    NSString *baseUrl = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 发送请求
    [mgr GET:baseUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/yuanzheng/Desktop/7期项目准备/07-我的界面/02-BuDeJie(展示方块界面:加载数据)/square.plist" atomically:YES];
        
        NSArray *dictArr = responseObject[@"square_list"];
        
        
        
        // 字典转模型
        _squareList = [BSSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 刷新collectionView
        [self.collectionView reloadData];
        
        // 计算collectionView高度
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}


- (void)setUpFootView
{
    
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    int cols = 4;
    
    CGFloat margin = 0.5;
    
    CGFloat w = (BSScreenW - (cols - 1) * margin) / cols;
    
    layout.itemSize = CGSizeMake(w, w);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    
    _collectionView = collectionView;
    
    collectionView.backgroundColor = BSGlobeColor;
    
    collectionView.dataSource = self;
    
    self.tableView.tableFooterView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"BSSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _squareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareList[indexPath.item];
    
    return cell;
    
}

// 设置导航条
- (void)setUpNavBar
{
    UIBarButtonItem *night = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(night:)];
    
    UIBarButtonItem *setting = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setting)];
    
    // right
    self.navigationItem.rightBarButtonItems = @[setting,night];
    
    // titleView
    self.navigationItem.title = @"我的";
}

// 夜间模式
- (void)night:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)setting
{
    // 进入设置界面
    BSSettingViewController *settingVc = [[BSSettingViewController alloc] init];
    
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
    
}

@end