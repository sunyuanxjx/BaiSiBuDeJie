//
//  XJXEssenceViewController.m
//  BuDeJie
//
//  Created by 孙远 on 2017/1/24.
//  Copyright © 2017年 sunyuan. All rights reserved.
//

#import "XJXEssenceViewController.h"
#import "XJXTitleButton.h"
#import "XJXAllViewController.h"
#import "XJXVideoViewController.h"
#import "XJXVoiceViewController.h"
#import "XJXPictureViewController.h"
#import "XJXWordViewController.h"


@interface XJXEssenceViewController ()<UIScrollViewDelegate>

/**  **/
@property(nonatomic, weak) UIView *titlesView;

/** 上一次被点击的btn  **/
@property(nonatomic, weak) UIButton *previousClickedTitleButton;

/** 下划线 **/
@property(nonatomic, weak) UIView *titleUnderlineView;

/**  **/
@property(nonatomic, weak) UIScrollView *scrollView;

@end

@implementation XJXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor greenColor];

    // 导航条按钮
    [self setupNavBar];
    
    // 1.添加控制器
    [self setupAllChildVC];
    
    // scrollView滚动条
    [self setupScrollView];
    
    // titleView
    [self setupTitlesView];
    
    // 添加第0个控制器的View
    [self addChildVcViewIntoScrollView];
    
    
}

// 添加所有tableViewController
-(void)setupAllChildVC
{
    [self addChildViewController:[[XJXAllViewController alloc] init]];
    [self addChildViewController:[[XJXVideoViewController alloc] init]];
    [self addChildViewController:[[XJXVoiceViewController alloc] init]];
    [self addChildViewController:[[XJXPictureViewController alloc] init]];
    [self addChildViewController:[[XJXWordViewController alloc] init]];
    
//    XJXAllViewController *allVC = [[XJXAllViewController alloc] init];
//    allVC.type = XJXTopicTypeAll;
//    [self addChildViewController:allVC];
//    
//    XJXVideoViewController *videoVC = [[XJXVideoViewController alloc] init];
//    videoVC.type = XJXTopicTypeVideo;
//    [self addChildViewController:videoVC];
//    
//    XJXVoiceViewController *voiceVC = [[XJXVoiceViewController alloc] init];
//    voiceVC.type = XJXTopicTypeVoice;
//    [self addChildViewController:voiceVC];
//    
//    XJXPictureViewController *pictureVC = [[XJXPictureViewController alloc] init];
//    pictureVC.type = XJXTopicTypePicture;
//    [self addChildViewController:pictureVC];
//    
//    XJXWordViewController *wordVC = [[XJXWordViewController alloc] init];
//    wordVC.type = XJXTopicTypeWord;
//    [self addChildViewController:wordVC];
}

// titleView
-(void)setupTitlesView
{
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = XJXColor(255, 255, 255, 0.5);
    titlesView.frame = CGRectMake(0, 64, self.view.xjx_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加按钮
    [self setupTitleBtn];
    
    // 添加下划线
    [self setupTitleUnderline];
    
    
    
}

//  设置内容(滚动条)
-(void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    // 去掉滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xjx_width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);

    
    
}

#pragma mark -- <UIScrollViewDelegate>
// scrollView采用手势滚动翻页时,对应的按钮也要被点击选中
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮对应的索引
    // NSUInteger是无符号的整型, NSInteger是有符号的整型，在表视图应用中常见 NSUInteger row= [indexPath row];因为这是显示tableViewCell有多少个，只能是非零整数的，也就是说，NSUInteger常用于索引值；
    NSUInteger index = scrollView.contentOffset.x / scrollView.xjx_width;
    
    // 点击对应的标题按钮
    XJXTitleButton *titleBtn = self.titlesView.subviews[index];
    [self titleBtnClick:titleBtn];
}



// 添加下划线
-(void)setupTitleUnderline
{
    // 标题按钮
    XJXTitleButton *firstTitleBtn = self.titlesView.subviews.firstObject;
    UIView *titleUnderlineView = [[UIView alloc] init];
    titleUnderlineView.xjx_height = 2;
    titleUnderlineView.xjx_y = self.titlesView.xjx_height - titleUnderlineView.xjx_height;
    titleUnderlineView.xjx_width = 70;
    titleUnderlineView.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderlineView];
    self.titleUnderlineView = titleUnderlineView;
    
    // 默认点击最前面的按钮
    firstTitleBtn.selected = YES;
    self.previousClickedTitleButton = firstTitleBtn;
    [firstTitleBtn.titleLabel sizeToFit]; // 让label根据文字自适应大小
    self.titleUnderlineView.xjx_width = firstTitleBtn.titleLabel.xjx_width + 10;
    // 处理下划线
    self.titleUnderlineView.xjx_centerX = firstTitleBtn.xjx_centerX;
    
}

// 添加标题栏按钮
-(void)setupTitleBtn
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titles.count;
    
    // frame
    CGFloat titleButtonW = self.titlesView.xjx_width / count;
    CGFloat titleButtonH = self.titlesView.xjx_height;
    
    // 创建五个标题按钮
    for (NSInteger i = 0; i < count; i++)
    {
        XJXTitleButton *titlesBtn = [[XJXTitleButton alloc] init];
        
        titlesBtn.tag = i; // 绑定标识符,来实现点击按钮切换view
        
        [titlesBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titlesView addSubview:titlesBtn];
        
        // frame
        titlesBtn.frame = CGRectMake(i*titleButtonW, 0, titleButtonW, titleButtonH);
        
        
        // 文字
        [titlesBtn setTitle:titles[i] forState:UIControlStateNormal];
        
        
        // 按钮文字颜色(正常与选中)----这段代码可以在自定义btn中实现
        // [titlesBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        // [titlesBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
    
}

// 监听按钮
-(void)titleBtnClick:(UIButton*)titleBtn
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleBtn) {
        
        // 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:XJXTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    /*
     改变按钮状态的第二种方法,通过自定义按钮(XJXButton,取消了高亮状态),来改变按钮颜色,推荐使用,有扩展性,
     */
    titleBtn.selected = YES;
    self.previousClickedTitleButton.selected = NO;
    self.previousClickedTitleButton = titleBtn;
    
    NSUInteger index = titleBtn.tag;
    
    [UIView animateWithDuration:0.2 animations:^{
    
        // 处理下划线
        self.titleUnderlineView.xjx_width = titleBtn.titleLabel.xjx_width + 10;
        self.titleUnderlineView.xjx_centerX = titleBtn.xjx_centerX;
        
        CGFloat offsetX = self.scrollView.xjx_width * index;
        // 点击按钮来滚动scrollView
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView];
        
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES 其他设置为NO
    for (NSInteger i = 0; i < self.childViewControllers.count; i++)
    {
        UIViewController *childVC = self.childViewControllers[i];
        // 如果view还没被创建,就不用去处理
        if (![childVC isViewLoaded]) {
            continue;
        }
        
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            
            continue;
            
        }
        
        scrollView.scrollsToTop = (i == index);
        
    }
}

// 添加子控制器的view
-(void)addChildVcViewIntoScrollView
{
    CGFloat scrollViewW = self.scrollView.xjx_width;
    NSUInteger index = self.scrollView.contentOffset.x / scrollViewW;
    // 取出index位置对应的子控制器的view
    UIView *childView = self.childViewControllers[index].view;
    // 设置子控制器view的frame
    childView.frame = self.scrollView.bounds;
    // 添加到scrollView中
    [self.scrollView addSubview:childView];
    
}



// 导航栏按钮
-(void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // 中间
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

-(void)game
{
    NSLog(@"薛娇贤我爱你");
}


@end
