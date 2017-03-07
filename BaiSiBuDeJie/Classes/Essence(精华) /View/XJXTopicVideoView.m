//
//  XJXTopicVideoView.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/8.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTopicVideoView.h"
#import "XJXTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "XJXSeeBigPictureViewController.h"

@interface XJXTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation XJXTopicVideoView

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    

    
}

// 查看大图
-(void)seeBigPicture
{
    XJXSeeBigPictureViewController *vc = [[XJXSeeBigPictureViewController alloc] init];
    vc.topic= self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}


-(void)setTopic:(XJXTopic *)topic
{
    _topic = topic;
    
    // 占位图片
    UIImage *placeholder = nil;
    
    // 设置图片
    // 进来就显示
    self.placeholderView.hidden = NO;
    [self.imageView xjx_setOriginalImageWithURL:topic.image1 andThumbnailImageWithURL:topic.image0 placeholder:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 下载失败,返回
        if (!image) return ;
        // 下载成功
        self.placeholderView.hidden = YES;
        
    }];
    
    // 播放数量
    if (topic.playcount >= 10000) {
        
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
        
    }else
    {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    // %04d : 占据4位，多余的空位用0填补
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60, topic.videotime % 60];
    
    NSLog(@"%zd", topic.videotime);
}

@end

