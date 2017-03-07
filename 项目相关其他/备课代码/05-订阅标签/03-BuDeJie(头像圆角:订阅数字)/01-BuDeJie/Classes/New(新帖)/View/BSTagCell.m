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
@interface BSTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbelLabel;



@end

@implementation BSTagCell

- (void)awakeFromNib
{
    _iconView.layer.cornerRadius = 25;
    _iconView.layer.masksToBounds = YES;
}

- (void)setTagItem:(BSTagItem *)tagItem
{
    _tagItem = tagItem;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
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
