
//
//  BSFastLoginView.m
//  BuDeJie
//
//  Created by yz on 15/11/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSFastLoginView.h"

@implementation BSFastLoginView

+ (instancetype)fastLoginView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

@end
