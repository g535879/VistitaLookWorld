//
//  ViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "ViewController.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRootNavigationBarRefer]; //设置导航栏
    [self setRootLayout]; //布局相关
}



- (void)setRootNavigationBarRefer {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompactPrompt];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20,MAX_WIDTH , 44)];
    bgView.image = [UIImage imageNamed:@"标题栏底.png"];
    [self.navigationController.view insertSubview:bgView belowSubview:self.navigationController.navigationBar];
}

//布局相关
- (void)setRootLayout {
    
    //设置背景图
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"资讯背景底@2x"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
