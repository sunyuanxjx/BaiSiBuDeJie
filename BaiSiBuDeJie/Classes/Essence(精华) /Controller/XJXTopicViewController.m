//
//  XJXTopicViewController.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/13.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTopicViewController.h"
#import "XJXTopic.h"
#import "XJXHTTPSessionManager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "XJXRefreshHeader.h"
#import "XJXDIYFooter.h"

#import "XJXTopicCell.h"

#import "XJXAllViewController.h"
#import "XJXVideoViewController.h"
#import "XJXVoiceViewController.h"
#import "XJXPictureViewController.h"
#import "XJXWordViewController.h"

@interface XJXTopicViewController ()

/** 所有的帖子数据 **/
@property(nonatomic, strong) NSMutableArray<XJXTopic *> *topics;


@property(nonatomic, strong) XJXHTTPSessionManager *manager;

/** 当前最后一条帖子数据的描述信息,专门用来加载下一页数据 **/
@property(nonatomic, copy) NSString *maxtime;






@end

/* cell的重用标识 */
static NSString * const XJXTopicCellID = @"XJXTopicCellID";

@implementation XJXTopicViewController

// 写这个方法仅仅是为了消除警告
- (XJXTopicType)type{return 0;}



// 1.创建请求会话管理者
-(XJXHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [XJXHTTPSessionManager manager];
    }
    
    return _manager;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XJXGrayColor(206);
    
    // 设置cell的估算高度（每一行大约都是estimatedRowHeight）
    //    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XJXNavMaxY + XJXTitlesViewH, 0, XJXTabBarH, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    
    // 监听tabBarBtnClick通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick) name:XJXTabBarButtonDidRepeatClickNotification object:nil];
    // 监听titleBtnClick通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick) name:XJXTitleButtonDidRepeatClickNotification object:nil];
    
    // 上拉,下拉,广告条控件
    [self setupRefresh];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XJXTopicCell class]) bundle:nil] forCellReuseIdentifier:XJXTopicCellID];
}

-(void)setupRefresh
{
    // 广告条
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    adLabel.backgroundColor = [UIColor blackColor];
    adLabel.textColor = [UIColor whiteColor];
    adLabel.text = @"广告";
    adLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = adLabel;
    
    
    // 下拉刷新控件
    self.tableView.mj_header = [XJXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];

    
    
    // 上拉刷新控件
    self.tableView.mj_footer = [XJXDIYFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    
    
}

// 监听titleBtn点击
-(void)titleBtnDidRepeatClick
{
    // 重复点击的不是精华按钮
    if (self.view.window == nil) {
        return;
    }
    // 显示在正中间的不是AllViewController
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    
    // 进入下拉刷新
    [self.tableView.mj_header beginRefreshing];

    
    NSLog(@"all---薛娇贤我爱你");
}

// 监听tabBar点击
-(void)tabBarBtnDidRepeatClick
{
    // 重复点击的不是精华按钮
    if (self.view.window == nil) {
        return;
    }
    // 显示在正中间的不是AllViewController
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    
    // 进入下拉刷新
    [self.tableView.mj_header beginRefreshing];

    
    
}

-(void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





// 重新加载数据
-(void)loadNewData
{
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancle)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    // 3.发送请求
    [self.manager GET:XJXCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 通过字典数组来创建一个模型数组
        self.topics = [XJXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (error.code != -999) { // 并非取消任务导致的error,其他网络问题导致的error
            
            [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试"];
        }
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


// 加载更多数据
-(void)loadMoreData
{
    
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(calcel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.manager GET:XJXCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 通过字典数组来创建一个模型数组
        NSArray *moreTopics = [XJXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 累加到旧数组后面
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
//        // 公司的需求,最多加载若干条(比如40)数据,结束刷新并提醒用户没有更多数据
//        if (self.topics.count >= 40) {
//            
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }else
//        {
//            [self.tableView.mj_footer endRefreshing];
//        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // -999代表取消任务报错
        if (error.code != -999) {
            
            [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试"];
        }
        
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark --- 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XJXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XJXTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}


#pragma mark -- 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清楚缓存,占据缓存内容最大的是图片缓存,如果不清楚,就会一直加载,消耗内存越来越大,这里清楚缓存,将不在屏幕范围内的之前的图片缓存清理掉
    [[SDImageCache sharedImageCache] clearMemory];
    
}

// 处理cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return self.topics[indexPath.row].cellHeight;
}
@end
