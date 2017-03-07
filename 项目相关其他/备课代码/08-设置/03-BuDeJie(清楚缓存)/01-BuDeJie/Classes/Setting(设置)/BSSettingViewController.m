//
//  BSSettingViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSSettingViewController.h"

#import <SDWebImage/SDImageCache.h>

@interface BSSettingViewController ()


@property (nonatomic, assign) NSInteger totoal;

@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
    
    [self getCacheSize:^(NSInteger total){
        _totoal = total;
        
        [self.tableView reloadData];
    }];

}


- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 获取缓存
    // 图片缓存，SDWebImage
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    NSInteger size = [imageCache getSize];
    
    cell.textLabel.text = [self sizeStr:_totoal];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    _totoal = 0;
    // 刷新界面
    [self.tableView reloadData];
}

-(void)getCacheSize:(void(^)(NSInteger total))block
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 获取cache文件夹
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //
        NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
        
        NSArray *subpaths = [mgr subpathsAtPath:defaultPath];
        
        NSInteger total = 0;
        
        for (NSString *subPath in subpaths) {
            NSString *filePath = [defaultPath stringByAppendingPathComponent:subPath];
            
            BOOL isDirectory = NULL;
            // 判断是否存在，并且不是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if (isExist && !isDirectory) {
                // 获取文件属性:给定一个文件全路径
                NSDictionary *fileAttr = [mgr attributesOfItemAtPath:filePath error:nil];
                
                NSInteger fileSize = [fileAttr[NSFileSize] integerValue];
                
                total += fileSize;
                

            }
            
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            block(total);
        });
        
        
    });
    
    
//    return total;
    
}

- (NSString *)sizeStr:(NSInteger)size
{
    CGFloat sizeF = 0;
    NSString *str = @"清除缓存";
    if (size > 1000 * 1000) { // Mb
        sizeF = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"清除缓存(%.1fMB)",sizeF];
        
    }else if (size > 1000){
        sizeF = size / 1000.0;
        str = [NSString stringWithFormat:@"清除缓存(%.1fKB)",sizeF];
    }else if(size > 0){
        
        str = [NSString stringWithFormat:@"清除缓存(%ldB)",size];
    }

    return str;
    
}



@end