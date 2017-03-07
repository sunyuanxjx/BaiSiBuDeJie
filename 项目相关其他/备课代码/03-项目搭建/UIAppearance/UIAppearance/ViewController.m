//
//  ViewController.m
//  UIAppearance
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view removeFromSuperview];
    
    // 在显示之前设置
    UISwitch *switchV =  [UISwitch appearance];
    
    switchV.onTintColor = [UIColor redColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
    
    
}

@end
