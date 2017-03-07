//
//  BSSubTagViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSSubTagViewController.h"

#import "BSTagItem.h"

#import <MJExtension/MJExtension.h>

#import <AFNetworking/AFNetworking.h>

#import "BSTagCell.h"

@interface BSSubTagViewController ()

@property (nonatomic, strong) NSArray *tags;

@end

@implementation BSSubTagViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    // 1.加载数据
    // 加载数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSString *baseUrl = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tags_list";
    parameters[@"c"] = @"subscribe";
    
    [mgr GET:baseUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/yuanzheng/Desktop/7期项目准备/05-订阅标签/tag.plist" atomically:YES];
        
        // 成功调用
        NSArray *dictArr = responseObject[@"def_tags"];
        
        _tags = [BSTagItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败调用
        
    }];
    
    // 通过xib创建cell两种方式：一种通过注册 二种：直接加载xib,但是要注意绑定标示符，否则没有循环利用
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"BSTagCell" bundle:nil] forCellReuseIdentifier:ID];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BSTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    cell.tagItem = _tags[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end