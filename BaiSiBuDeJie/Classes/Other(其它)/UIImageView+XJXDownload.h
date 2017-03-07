//
//  UIImageView+XJXDownload.h
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/8.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (XJXDownload)


-(void)xjx_setHeader:(NSString *)headerURL;

-(void)xjx_setOriginalImageWithURL:(NSString *)originalImageURL andThumbnailImageWithURL:(NSString*)thumbnailImageURL placeholder:(UIImage*)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

@end
