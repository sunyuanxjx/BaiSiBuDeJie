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

- (void)setTagItem:(BSTagItem *)tagItem
{
    _tagItem = tagItem;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    _nameLabel.text = _tagItem.theme_name;
    _numbelLabel.text = _tagItem.sub_number;
}
@end
