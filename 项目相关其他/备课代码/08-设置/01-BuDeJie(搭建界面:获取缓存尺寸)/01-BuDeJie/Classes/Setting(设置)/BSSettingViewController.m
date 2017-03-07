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

@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
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
    
    cell.textLabel.text = [self sizeStr:size];
    
    
    return cell;
    
}

- (NSString *)sizeStr:(NSInteger)size
{
    CGFloat sizeF = 0;
    NSString *str = @"清除缓存";
    if (size > 1000 * 1000) { // Mb
        sizeF = size / 1000.0 / 1000.0;
        NSLog(@"%f",sizeF);
        str = [NSString stringWithFormat:@"清除缓存(%.1fMB)",sizeF];
        
    }else if (size > 1000){
        sizeF = size / 1000.0;
        str = [NSString stringWithFormat:@"清除缓存(%.1fKB)",sizeF];
    }else{
        
        str = [NSString stringWithFormat:@"清除缓存(%ldB)",size];
    }

    return str;
    
}



@end