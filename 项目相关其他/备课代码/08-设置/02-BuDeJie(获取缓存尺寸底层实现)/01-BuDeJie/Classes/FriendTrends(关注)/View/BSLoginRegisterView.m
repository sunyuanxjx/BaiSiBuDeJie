//
//  BSLoginRegisterView.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSLoginRegisterView.h"

@implementation BSLoginRegisterView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BSLoginRegisterView" owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BSLoginRegisterView" owner:nil options:nil] lastObject];
}

@end
