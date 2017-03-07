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

static NSString * const ID = @"cell";

@interface BSMineViewController ()<UICollectionViewDataSource>

@end

@implementation BSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavBar];
    
    // 设置尾部视图
    [self setUpFootView];
    
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
    
    collectionView.backgroundColor = BSGlobeColor;
    
    collectionView.dataSource = self;
    
    self.tableView.tableFooterView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"BSSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
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