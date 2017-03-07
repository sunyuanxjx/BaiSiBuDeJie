//
//  BSTagCell.m
//  BuDeJie
//
//  Created by yz on 15/11/14.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSTagCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "BSTagItem.h"
#import "UIImage+Antialias.h"
@interface BSTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbelLabel;



@end

@implementation BSTagCell

- (void)awakeFromNib
{
    // cell分割线默认有内边距
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    _iconView.layer.cornerRadius = 25;
//    _iconView.layer.masksToBounds = YES;
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setTagItem:(BSTagItem *)tagItem
{
    _tagItem = tagItem;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 裁剪图片,生成一张新的图片
        
        // 开启位图上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        // 描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [path addClip];
        
        [image drawAtPoint:CGPointZero];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        _iconView.image = [image imageAntialias];
        
    }];
    
    _nameLabel.text = _tagItem.theme_name;
    
    // 订阅数字
    CGFloat subNumber = [_tagItem.sub_number floatValue];
    
    NSString *subStr = [NSString stringWithFormat:@"%@人订阅",_tagItem.sub_number];
    if (subNumber > 10000) {
        subNumber = subNumber / 10000.0;
        subStr = [NSString stringWithFormat:@"%.1f万人订阅",subNumber];
    }
    
    _numbelLabel.text = subStr;
    
    
}
@end
