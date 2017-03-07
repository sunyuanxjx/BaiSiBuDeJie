//
//  XJXSubTagViewController.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/28.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>
#import "XJXSubTagItem.h"
#import "XJXSubTagCell.h"
#import <MJRefresh.h>
static NSString * const ID = @"cell";
@interface XJXSubTagViewController ()

/**  **/
@property(nonatomic, strong) NSArray *subTags;

/**  **/
@property(nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation XJXSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    // 展示标签数据 -> 请求数据(接口文档) -> 解析数据(写成Plist)(image_list,sub_number,theme_name) -> 设计模型 -> 字典转模型 -> 展示数据
    [self loadData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XJXSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 处理cell分割线 1.自定义分割线 2.系统属性(iOS8以后)3.万能方式
    // 清空tabView分割线内边距,清空cell约束边缘
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    // 清空分割线,重新设置frame
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XJXColor(228, 227, 229,1);
    
    // 提示用户当前正在加载数据
    [SVProgressHUD showWithStatus:@"正在加载数据......"];
    
    [self setupRefresh];
}

// 上拉刷新
- (void)setupRefresh
{
    // header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 2秒后自动结束刷新
            [self.tableView.mj_header endRefreshing];
            
        });
        
    }];
    
}


// 界面即将消失的时候调用
// 当请求没有响应,返回上一界面的时候,仍然在加载提示框
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 销毁指示器
    [SVProgressHUD dismiss];
    // 取消之前的请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}

-(void)loadData
{
    // 1.创建会话请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    self.mgr = mgr;
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
        
        // 销毁指示器
        [SVProgressHUD dismiss];
        // 字典数组转模型数组
        _subTags = [XJXSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 销毁指示器
        [SVProgressHUD dismiss];
        
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 自定义cell
    XJXSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    // 获取模型
    XJXSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
