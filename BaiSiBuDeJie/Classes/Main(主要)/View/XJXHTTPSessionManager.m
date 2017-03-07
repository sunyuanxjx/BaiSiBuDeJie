//
//  XJXHTTPSessionManager.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/14.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXHTTPSessionManager.h"

@implementation XJXHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        [self.requestSerializer setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"Phone"];
        [self.requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"OS"];
    }
    return self;
}

@end
