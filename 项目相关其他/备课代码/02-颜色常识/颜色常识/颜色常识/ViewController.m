//
//  ViewController.m
//  颜色常识
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

#import "UIColor+Hex.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _label.textColor = [UIColor colorWithHexString:@"#eb3535"];
    
    
}

// 213 213 213

// 颜色：是由颜色通道组成,R,G,B
// 颜色是24位，8位，取值0~255,OC 0~1


// #ffffff
// #:html中表示16进制
// 每两位表示一个颜色通道

// ff -> 10进制
// 15 * 16 + 15



@end
