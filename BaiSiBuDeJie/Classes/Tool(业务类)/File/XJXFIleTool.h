//
//  XJXFIleTool.h
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/1.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJXFIleTool : NSObject

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @return 返回文件夹尺寸
 */

+(void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;



/**
 删除文件夹所有文件
 
 @param directoryPath 文件夹路径
 */

+(void)removeDirectoryPath:(NSString *)directoryPath;

@end
