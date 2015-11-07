//
//  InfoDetailViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "InfoDetailViewController.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface InfoDetailViewController (){
    UIToolbar * _toolbar; //底部工具栏
    UIWebView *_webView;
    MBProgressHUD *_hub;//加载控制器
}

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRefer]; //导航栏相关
    [self setLayout]; //布局相关
    [self loadData]; //加载数据
}
//隐藏分栏
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@",self.uId);
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}


//显示分栏
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)setNavigationRefer {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
}

//布局
- (void)setLayout {
    
   
    
    //webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, MAX_WIDTH, MAX_HEIGHT-44)];
    [_webView.scrollView setContentInset:UIEdgeInsetsMake(-64, 0, 0, 0)];
    [self.view addSubview:_webView];
    
    //工具栏
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, MAX_HEIGHT-44, MAX_WIDTH, 44)];
    
    [_toolbar setBarTintColor:[UIColor blackColor]];
    
    //backBBI
    UIBarButtonItem * backBBI = [self customBBIWithImageName:@"上一章_1" andAction:@selector(backBtnClick)];
    
    //commonBBI
    UIBarButtonItem * commonBBI = [self customBBIWithImageName:@"评论_1" andAction:nil];
    
    //starBBI
    UIBarButtonItem * starBBI = [self customBBIWithImageName:@"收藏" andAction:nil];
    
    //relay
    UIBarButtonItem * relayBBI = [self customBBIWithImageName:@"内页转发_1" andAction:nil];
    
    //nextBBI
    UIBarButtonItem * nextBBI = [self customBBIWithImageName:@"下一章_1" andAction:nil];
    
    
    UIBarButtonItem * flexbaleBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //放入数组中
    _toolbar.items = @[backBBI,flexbaleBBI,commonBBI,flexbaleBBI,starBBI,flexbaleBBI,relayBBI,flexbaleBBI,nextBBI];
    
    [self.view addSubview:_toolbar];
    
    
    
    //小菊花
    _hub = [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    [_hub setDimBackground:YES];
    [_hub setHidden:NO];
}


//得到自定义BBI
- (UIBarButtonItem *)customBBIWithImageName:(NSString *)imageName andAction:(SEL)action{
    UIBarButtonItem *bBBI = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    return bBBI;
}


- (void)loadData {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://ktx.cms.palmtrends.com/api_v2.php" parameters:@{@"action":@"article",@"uid":@"10067567",@"id":self.uId,@"mobile":@"iphone5",@"e":@"40dab97d773e7860febfc897c04824e2",@"fontsize":@"m!"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * urlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //主线程刷新UI
    //    dispatch_async(dispatch_get_main_queue(), ^{
            [_webView loadHTMLString:urlStr baseURL:nil];
            //隐藏小菊花
            [_hub setHidden:YES];
     //   });
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 点击事件相关

//返回按钮
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
