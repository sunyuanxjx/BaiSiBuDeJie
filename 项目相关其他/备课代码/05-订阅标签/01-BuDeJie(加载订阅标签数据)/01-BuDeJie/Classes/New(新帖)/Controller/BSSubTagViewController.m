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

@interface BSSubTagViewController ()

@property (nonatomic, strong) NSArray *tags;

@end

@implementation BSSubTagViewController

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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败调用
        
    }];
    
}

@end