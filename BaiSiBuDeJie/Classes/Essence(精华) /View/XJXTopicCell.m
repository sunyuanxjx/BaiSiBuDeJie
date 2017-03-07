//
//  XJXTopicCell.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/7.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTopicCell.h"
#import "XJXTopic.h"
#import "UIImage+XJXOriginalImage.h"
#import <UIImageView+WebCache.h>
#import "XJXTopicVideoView.h"
#import "XJXTopicVoiceView.h"
#import "XJXTopicPictureView.h"
#import "UIView+XJXFrame.h"

@interface XJXTopicCell()

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 发帖时间
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
// 帖子内容
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
// 顶btn
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
// 踩btn
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
// 分享btn
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
// 评论btn
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

// 最热评论View
@property (weak, nonatomic) IBOutlet UIView *topComtView;
// 最热评论内容
@property (weak, nonatomic) IBOutlet UILabel *topComtLabel;

/** 图片控件 **/
@property(nonatomic, weak) XJXTopicPictureView *pictureView;

/** 声音控件 **/
@property(nonatomic, weak) XJXTopicVoiceView *voiceView;

/** 视频控件 **/
@property(nonatomic, weak) XJXTopicVideoView *videoView;

@end


@implementation XJXTopicCell

-(XJXTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        
        XJXTopicPictureView *pictureView = [XJXTopicPictureView xjx_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    
    return _pictureView;
}

-(XJXTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        XJXTopicVoiceView *voiceView = [XJXTopicVoiceView xjx_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
    
}

-(XJXTopicVideoView *)videoView
{
    if (_videoView == nil) {
        XJXTopicVideoView *videoView = [XJXTopicVideoView xjx_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(XJXTopic *)topic
{
    _topic = topic;
    
    // 下载图片,并设置占位图片
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage xjx_circleImageNamed:@"defaultUserIcon"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 图片下载失败,直接返回,按照它的默认做法
        if (!image) {
            return ;
        }
        
        self.profileImageView.image = [image xjx_circleImage];
    }];
    
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_Label.text = topic.text;
    
    [self setupBtnTitle:self.dingBtn number:topic.ding placeholder:@"顶"];
    [self setupBtnTitle:self.caiBtn number:topic.cai placeholder:@"踩"];
    [self setupBtnTitle:self.shareBtn number:topic.repost placeholder:@"分享"];
    [self setupBtnTitle:self.commentBtn number:topic.comment placeholder:@"评论"];

    if (topic.top_cmt.count) { // 有最热评论
        
        self.topComtView.hidden = NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            
            content = @"[语音评论]";
        }
        
        NSString *username = cmt[@"user"][@"username"];
        self.topComtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    }else
    {
        // 没有最热评论
        self.topComtView.hidden = YES;
    }
    
    // 中间的内容
    if (topic.type == XJXTopicTypePicture) {
        
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        // 把模型赋值给对应的控件
        self.pictureView.topic = topic;
        
    }else if (topic.type == XJXTopicTypeVideo)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        
    }else if (topic.type == XJXTopicTypeVoice)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
    }else if (topic.type == XJXTopicTypeWord)
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    
}

// 设置按钮
-(void)setupBtnTitle:(UIButton *)btn number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 1000) {
        
        [btn setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0)
    {
        [btn setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else
    {
        [btn setTitle:placeholder forState:UIControlStateNormal];
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= XJXMargin;
    
    // 真正设置frame
    [super setFrame:frame];
}


-(void)layoutSubviews
{
    // 中间的内容
    if (self.topic.type == XJXTopicTypePicture) {
        
        self.pictureView.frame = self.topic.middleFrame;
        
    }else if (self.topic.type == XJXTopicTypeVideo)
    {
        self.videoView.frame = self.topic.middleFrame;
        
    }else if (self.topic.type == XJXTopicTypeVoice)
    {
        self.voiceView.frame = self.topic.middleFrame;
    }
}

@end
