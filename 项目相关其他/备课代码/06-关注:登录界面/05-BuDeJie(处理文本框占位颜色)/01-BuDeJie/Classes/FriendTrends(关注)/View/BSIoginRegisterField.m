//
//  BSIoginRegisterField.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSIoginRegisterField.h"

@implementation BSIoginRegisterField

- (void)awakeFromNib
{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    // 设置占位文字颜色
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
    
    // 监听文本框开始编辑：1.代理 2.通知 3.绑定监听者
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textBegin
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    // 设置占位文字颜色
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;

    
}

- (void)textEnd
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    // 设置占位文字颜色
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
}
@end
