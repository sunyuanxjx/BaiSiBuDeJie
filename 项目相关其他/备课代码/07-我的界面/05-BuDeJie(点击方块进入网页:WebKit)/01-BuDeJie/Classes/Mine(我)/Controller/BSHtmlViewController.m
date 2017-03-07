//
//  BSHtmlViewController.m
//  01-BuDeJie
//
//  Created by yz on 15/12/18.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "BSHtmlViewController.h"

#import <WebKit/WebKit.h>

@interface BSHtmlViewController ()

@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, weak) UIProgressView *progressView;

@end

@implementation BSHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    // 加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    // 监听标题
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // URL
    [webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // 创建进度条控件
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.frame = CGRectMake(0, 64, self.view.width, 0);

    progressView.progressTintColor = [UIColor orangeColor];
    _progressView = progressView;
    [self.view insertSubview:progressView aboveSubview:webView];
    
    _webView = webView;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.title = _webView.title;
        
    }else if ([keyPath isEqualToString:@"URL"]){
//        NSLog(@"%@",_webView.URL);
    }else if ([keyPath isEqualToString:@"estimatedProgress"]){

        [_progressView setProgress:_webView.estimatedProgress animated:YES];
        _progressView.hidden = _progressView.progress >= 1;
        
    }
}


- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
}

@end