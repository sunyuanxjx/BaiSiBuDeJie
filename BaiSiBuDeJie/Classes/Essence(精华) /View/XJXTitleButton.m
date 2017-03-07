//
//  XJXTitleButton.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/2.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXTitleButton.h"

@implementation XJXTitleButton

-(void)setHighlighted:(BOOL)highlighted
{
    // 只要重写了这个方法,按钮就无法进入highligh状态


}

/*
 特定的构造方法
 1> 后面带有 NS_DESIGNATED_INITIALIZER 的方法,就是特定构造方法
 2> 子类如果重写了[特定构造方法],那么必须用 super调用分类的特定构造方法,不然会报警告
 
 */

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        // 按钮文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    
    return self;

}



@end
