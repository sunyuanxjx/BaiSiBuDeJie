//
//  XJXSubTagCell.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/28.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXSubTagCell.h"
#import "XJXSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Antialias.h"
@interface XJXSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;


@end

@implementation XJXSubTagCell

// 从xib加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置头像圆角,iOS9以后能用,用通用方法画图方法代替
//    _iconView.layer.cornerRadius = 30;
//    _iconView.layer.masksToBounds = YES;
    
    self.layoutMargins = UIEdgeInsetsZero;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    // 真正去给frame赋值
    [super setFrame:frame];
}

-(void)setItem:(XJXSubTagItem *)item
{
    _item = item;
    _nameView.text = item.theme_name;
    [self resolveNum];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 绘图
        // 1.开启图形上下文
        // 比例因素:当前点与像素比例
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        // 2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        // 3.设置裁剪区域
        [path addClip];
        // 4.画图片
        [image drawAtPoint:CGPointZero];
        // 5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
//        _iconView.image = image;
        // 返回一张不带锯齿的图片
        _iconView.image = [image imageAntialias];
        
    }];
    

}

// 处理订阅数字
-(void)resolveNum
{
    // 设置内容
    // 判断有没有大于10000
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅", _item.sub_number];
    NSInteger num = _item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
