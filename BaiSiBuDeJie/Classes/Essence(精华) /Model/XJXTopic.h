//
//  XJXTopic.h
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/6.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XJXTopicType) {
    /** 全部 */
    XJXTopicTypeAll = 1,
    /** 图片 */
    XJXTopicTypePicture = 10,
    /** 段子 */
    XJXTopicTypeWord = 29,
    /** 声音 */
    XJXTopicTypeVoice = 31,
    /** 视频 */
    XJXTopicTypeVideo = 41
};

@interface XJXTopic : NSObject

/** 用户的名字 **/
@property(nonatomic, copy) NSString *name;

/** 用户的头像 **/
@property(nonatomic, copy) NSString *profile_image;

/** 帖子的文字内容 **/
@property(nonatomic, copy) NSString *text;

/** 帖子审核通过的时间 **/
@property(nonatomic, copy) NSString *passtime;

/** 顶数量 **/
@property(nonatomic, assign) NSInteger ding;

/** 踩数量 **/
@property(nonatomic, assign) NSInteger cai;

/** 转发,分享数量 **/
@property(nonatomic, assign) NSInteger repost;

/** 评论数量 **/
@property(nonatomic, assign) NSInteger comment;

/** 帖子的类型 10为图片,29为段子,31为音频,41为视频 **/
@property(nonatomic, assign) NSInteger type;

/** 额外增加的属性(并非服务器返回的属性,仅仅是为了提高开发效率) **/
/** 根据当前模型计算出来的cell高度 **/
@property(nonatomic, assign) CGFloat cellHeight;

/** 最热评论 **/
/**  **/
@property(nonatomic, strong) NSArray *top_cmt;

/** 图片宽度(像素) **/
@property(nonatomic, assign) CGFloat width;

/** 图片高度(像素) **/
@property(nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;

/** XJXTopicCell中间内容的尺寸 **/
@property(nonatomic, assign) CGRect middleFrame;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 是否为动态图 **/
@property(nonatomic, assign) BOOL is_gif;

/** 是否为大图 **/
@property(nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end
