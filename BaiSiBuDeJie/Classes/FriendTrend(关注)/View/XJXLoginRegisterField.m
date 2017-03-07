//
//  XJXLoginRegisterField.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/1/29.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXLoginRegisterField.h"
#import "UITextField+XJXPlaceholder.h"

@implementation XJXLoginRegisterField

// 自定义文本框,处理文本框相关属性,在xib中绑定自定义文本框
// awakeFromNib 从xib或者storyboard加载完毕就会调用
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置光标颜色为白色
    self.tintColor = [UIColor whiteColor];
    
    // 监听文本框编辑 1.代理 2.通知 3.target
    // 代理原则:不要自己成为自己的代理
    
    // 设置占位文字颜色为淡灰色
    // 第一种方法
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    // 快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名(1.runtime 2.断点)
    // 获取占位文字控件(自定义分类提供的方法)
    // 淡灰色
    self.placeholderColor = [UIColor lightGrayColor];
    
    
    // target法监听文本框
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    

}

// 开始编辑
// 占位文字颜色为白色
-(void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
    
    
}
// 结束编辑
// 占位文字颜色为淡灰色
-(void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
