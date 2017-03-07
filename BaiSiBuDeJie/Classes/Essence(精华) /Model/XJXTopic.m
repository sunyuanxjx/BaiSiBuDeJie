//
//  XJXTopic.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/6.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTopic.h"

@implementation XJXTopic

-(CGFloat)cellHeight
{
    // 有值,不为0,直接返回
    if (_cellHeight) {
        
        return _cellHeight;
    }
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(XJXScreenW - 2 * XJXMargin, MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + XJXMargin;
    
    // 中间的内容
    if (self.type != XJXTopicTypeWord) {
        
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        
   
        
        if (middleH > XJXScreenH * 2) {
            // 超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        
        CGFloat middleY = _cellHeight;
        CGFloat middleX = XJXMargin;
        
        if (self.type == XJXTopicTypePicture) {
            
            NSLog(@"%f--%f", self.width, self.height);
        }
        
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += (middleH + XJXMargin);
    }
    
    // 最热评论
    if (self.top_cmt.count) {
        
        // 标题
        _cellHeight += 20;
        
        // 内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            
            content = @"语音评论";
        }
        
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + XJXMargin;
    }
    
    // 工具条
    _cellHeight += 35 + XJXMargin;
    
    return _cellHeight;
}

@end
