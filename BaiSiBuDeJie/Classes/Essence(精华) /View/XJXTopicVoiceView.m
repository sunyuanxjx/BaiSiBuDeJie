//
//  XJXTopicVideoView.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/8.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTopicVoiceView.h"
#import "XJXTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface XJXTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation XJXTopicVoiceView

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
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
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}

@end
