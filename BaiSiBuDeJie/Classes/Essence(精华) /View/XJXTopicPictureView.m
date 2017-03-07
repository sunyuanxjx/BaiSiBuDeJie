//
//  XJXTopicPictureView.m
//  BuDeJie
//
//  Created by 孙远 on 2016/12/8.
//  Copyright © 2016年 sunyuan. All rights reserved.
//

#import "XJXTopicPictureView.h"
#import "XJXTopic.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "UIImageView+XJXDownload.h"
#import "XJXSeeBigPictureViewController.h"
@interface XJXTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@property (weak, nonatomic) IBOutlet UIImageView *giftView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;


@end


@implementation XJXTopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.ImageView.userInteractionEnabled = YES;
    
    [self.ImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    
    
}

// 弹出看大图控制器
-(void)seeBigPicture
{
    XJXSeeBigPictureViewController *seeBigPictureVC = [[XJXSeeBigPictureViewController alloc] init];
    seeBigPictureVC.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigPictureVC animated:YES completion:nil];
    
}
- (IBAction)seeBigPictureBtnClick:(id)sender{
    
    [self seeBigPicture];
}

-(void)setTopic:(XJXTopic *)topic
{
    _topic = topic;
    
    // 占位图片
    UIImage *placeholder = nil;
    
    // 设置图片
    // 进来就显示
    self.placeholderView.hidden = NO;
    [self.ImageView xjx_setOriginalImageWithURL:topic.image1 andThumbnailImageWithURL:topic.image0 placeholder:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 下载失败,返回
        if (!image) return ;
        // 下载成功
        self.placeholderView.hidden = YES;
        
        if (topic.isBigPicture) {
            
            // 处理超长图片的大小
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = topic.height * imageW / topic.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文
            [self.ImageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.ImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
            
        }
        
        
    }];
    
    // gif
    self.giftView.hidden = !topic.is_gif;

    
    // 点击查看大图
    if (topic.bigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.ImageView.contentMode = UIViewContentModeTop;
        self.ImageView.clipsToBounds = YES;
        
        
        
    }else
    {
        self.seeBigPictureButton.hidden = YES;
        self.ImageView.contentMode = UIViewContentModeScaleToFill;
        self.ImageView.clipsToBounds = NO;
    }
}

@end
