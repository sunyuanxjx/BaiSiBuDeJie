//
//  XJXSquareCell.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/29.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXSquareCell.h"
#import "XJXSquareItem.h"
#import <UIImageView+WebCache.h>

@interface XJXSquareCell();
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation XJXSquareCell

-(void)setItem:(XJXSquareItem *)item
{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}

@end
