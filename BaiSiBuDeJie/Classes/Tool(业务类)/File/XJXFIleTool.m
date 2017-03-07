//
//  XJXFIleTool.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/1.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXFIleTool.h"

@implementation XJXFIleTool

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @return 返回文件夹尺寸
 */

+(void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion
{
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径,就能获取文件属性
    // 把所有文件尺寸加起来
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断是否文件夹
    BOOL isDirectory;
    // 判断文件是否存在,并且判断是否是文件夹
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
       // 抛异常
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入一个文件夹路径" userInfo:nil];
        [excp raise];
    }
    
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || !isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // 计算完成回调
            if (completion) {
                completion(totalSize);
            }
            
            
        });
        
    });
    
    
   
    
}




/**
删除文件夹所有文件

@param directoryPath 文件夹路径
*/

+(void)removeDirectoryPath:(NSString *)directoryPath
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否文件夹
    BOOL isDirectory;
    // 判断文件是否存在,并且判断是否是文件夹
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        // 抛异常
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入一个文件夹路径" userInfo:nil];
        [excp raise];
    }
   // 获取caches文件下所有文件夹
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }

}

@end
