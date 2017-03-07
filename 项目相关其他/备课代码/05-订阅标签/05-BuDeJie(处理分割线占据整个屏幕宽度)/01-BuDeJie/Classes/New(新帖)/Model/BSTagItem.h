//
//  BSTagItem.h
//  BuDeJie
//
//  Created by yz on 15/11/14.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTagItem : NSObject


@property (nonatomic, strong) NSString *image_list;

@property (nonatomic, strong) NSString *theme_id;

@property (nonatomic, strong) NSString *theme_name;

@property (nonatomic, assign) int is_sub;

@property (nonatomic, assign) int is_default;

@property (nonatomic, strong) NSString *sub_number;

@end
