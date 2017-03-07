//
//  XJXAdItem.h
//  BuDeJie
//
//  Created by 孙远 on 2017/1/26.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XJXAdItem : NSObject

/** 广告地址 **/
@property(nonatomic, strong) NSString *w_picurl;

/** 点击广告跳转的页面 **/
@property(nonatomic, strong) NSString *ori_curl;

/**  **/
@property(nonatomic, assign) CGFloat w;

/**  **/
@property(nonatomic, assign) CGFloat h;

@end
