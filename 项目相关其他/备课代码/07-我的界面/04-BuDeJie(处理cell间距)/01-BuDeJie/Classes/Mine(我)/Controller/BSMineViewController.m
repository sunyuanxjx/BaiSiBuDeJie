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

static int const cols = 4;

static CGFloat const margin = 0.5;

#define BSCellW (BSScreenW - (cols - 1) * margin) / cols

/*
    cell填充，有多少cell，由模型决定，缺多少，就添加多少模型。
 */

@interface BSMineViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *squareList;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation BSMineViewController

- (NSMutableArray *)squareList
{
    if (_squareList == nil) {
        _squareList = [NSMutableArray array];
    }
    return _squareList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    // 设置尾部视图
    [self setUpFootView];
    
    // 加载数据
    [self loadData];
    
    // 设置tableView组间距,默认都会有组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
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
        self.squareList = [BSSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 处理数据
        [self resolveData];
        
        // 5
        // 计算总行数 rows = (count - 1) / cols + 1
        NSInteger rows = (_squareList.count - 1) / cols + 1;
        
        CGFloat collectionH = rows * BSCellW;
        // 计算collectionView高度
        self.collectionView.height = collectionH;
        
        self.tableView.tableFooterView = self.collectionView;
        
        // 刷新collectionView
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

- (void)resolveData
{
    NSInteger count = _squareList.count;
    
    // 3 % 4 3
    int extre = count % cols;
    
    if (extre) {
        extre = cols - extre;
    }
    
    for (int i = 0; i < extre; i++) {
        BSSquareItem *item = [[BSSquareItem alloc] init];
        [self.squareList addObject:item];
    }
    
}


- (void)setUpFootView
{
    
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    
    
    
    layout.itemSize = CGSizeMake(BSCellW, BSCellW);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    
    _collectionView = collectionView;
    
    collectionView.backgroundColor = BSGlobeColor;
    
    collectionView.dataSource = self;
    
    // 取消弹簧效果
//    collectionView.bounces = NO;
//    collectionView.alwaysBounceVertical = NO;
    collectionView.scrollEnabled = NO;
    
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