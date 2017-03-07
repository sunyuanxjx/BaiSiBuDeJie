//
//  XJXSettingViewController.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/29.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXSettingViewController.h"
#import <SDImageCache.h>
#import "XJXFIleTool.h"
#import <SVProgressHUD.h>
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
static NSString *const ID = @"cell";

@interface XJXSettingViewController ()

/**  **/
@property(nonatomic, assign) NSInteger totalSize;

@end

@implementation XJXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 正在计算尺寸(如果缓存的数据很大,就会有一段持续时间,这段时间,需要做提示)
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸..."];
    // 获取cache文件夹路径
    [XJXFIleTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

// 点击cell就会调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 删除文件里所有文件
    [XJXFIleTool removeDirectoryPath:CachePath];
    _totalSize = 0;
    [self.tableView reloadData];
}

// 返回尺寸
-(NSString *)sizeStr
{
    // 获取caches文件夹路径
    NSInteger totalSize = _totalSize;
    
    NSString *sizeStr = @"清楚缓存";
    if (totalSize > 1000*1000) {
        // MB
        CGFloat sizeF = totalSize / 1000 / 1000;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, sizeF];
    }else if (totalSize > 1000)
    {
        // KB
        CGFloat sizeF = totalSize / 1000;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeF];
    }else if (totalSize > 0)
    {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.1ldb)", sizeStr, totalSize];
        
    }
    
    return sizeStr;
}




@end
