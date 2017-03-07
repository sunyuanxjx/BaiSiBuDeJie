//
//  XJXWebViewController.m
//  BaiSiBuDeJie
//
//  Created by 孙远 on 2017/2/1.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXWebViewController.h"
#import <WebKit/WebKit.h>
@interface XJXWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
/**  **/
@property(nonatomic, weak) WKWebView *webView;
@end

@implementation XJXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加webView
    WKWebView *webVeiw = [[WKWebView alloc] init];
    _webView = webVeiw;
    [self.contentView addSubview:webVeiw];
    
    // 展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webVeiw loadRequest:request];
    
    // 前进,后退,刷新
    // KVO监听属性的改变
    // KVO注意点:一定要记得移除
    // Observer观察者
    // KeyPath:观察webView哪个属性
    // options:
    [webVeiw addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webVeiw addObserver:self forKeyPath:@"canGoForWard" options:NSKeyValueObservingOptionNew context:nil];
    [webVeiw addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    [webVeiw addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

// 移除观察者
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForWard"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

//  只要观察对象属性有新值就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    
    [self.webView goForward];
}
- (IBAction)reload:(id)sender {
    
    [self.webView reload];
}


@end
