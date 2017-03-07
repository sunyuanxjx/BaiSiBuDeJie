//
//  BSSquareCell.m
//  BuDeJie
//
//  Created by yz on 15/11/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSSquareCell.h"


#import "BSSquareItem.h"


#import <SDWebImage/UIImageView+WebCache.h>

@interface BSSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;


@end

@implementation BSSquareCell
- (void)setItem:(BSSquareItem *)item
{
    _item = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
    
}

@end
