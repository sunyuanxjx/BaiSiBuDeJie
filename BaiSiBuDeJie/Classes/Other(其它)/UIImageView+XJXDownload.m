//
//  UIImageView+XJXDownload.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/8.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "UIImageView+XJXDownload.h"
#import <AFNetworking.h>

@implementation UIImageView (XJXDownload)

-(void)xjx_setOriginalImageWithURL:(NSString *)originalImageURL andThumbnailImageWithURL:(NSString*)thumbnailImageURL placeholder:(UIImage*)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 获得原图 (SDWebImage的图片缓存是用图片的url字符串作为key) 从沙河中取(先去内存缓存中取)
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURL];
    
    if (originalImage)
    { // 原图已经被下载过
//        self.image = originalImage;
//        completedBlock(originalImage, nil, 0, [NSURL URLWithString:originalImageURL]);
        
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholder completed:completedBlock];
    }else // 原图没有被下载过
    {
        if (mgr.isReachableViaWiFi)
        {
            
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholder completed:completedBlock];
            
        }else if(mgr.isReachableViaWWAN)
        {
            // 3G/4G网络下是否要下载原图
            BOOL downloadOriginalImageWhen3Gor4G = YES;
            if (downloadOriginalImageWhen3Gor4G)
            {
                
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholder completed:completedBlock];
                
            }else
            {
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }
        }else  // 没有可用网络
        {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) // 缩略图已经被下载过
            {
//                self.image = thumbnailImage;
//                 completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:originalImageURL]);
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }else // 没有下载过任何图片
            {
                // 占位图片
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
                
            }
        }

   }
}

-(void)xjx_setHeader:(NSString *)headerURL
{
    UIImage *placeholder = [UIImage xjx_circleImageNamed:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:headerURL] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 图片下载失败,直接返回,按照它的默认做法
        if (!image) {
            return ;
        }
        
        self.image = [image xjx_circleImage];
    }];
}

@end
