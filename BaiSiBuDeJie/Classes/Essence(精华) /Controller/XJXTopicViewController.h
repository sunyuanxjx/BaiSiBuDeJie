//
//  XJXTopicViewController.h
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/13.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJXTopic.h"
@interface XJXTopicViewController : UITableViewController

// 只生成get方法,不会生成_下划线的成员变量,可以在后面随时传入其它参数
-(XJXTopicType)type;

@end
