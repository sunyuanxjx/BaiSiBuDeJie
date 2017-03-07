//
//  BSAdViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSAdViewController.h"


@interface BSAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation BSAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // 6p : 736 6 : 667  5 : 568  4 : 480
    if (iPhone6P) {
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];

    }else if (iPhone6){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
        
    }else if (iPhone5){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];

    }else if(iPhone4){
        
        _bgView.image = [UIImage imageNamed:@"LaunchImage-700"];
        
    }
    
    
}


@end
