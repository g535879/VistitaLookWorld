//
//  GuUINavigationController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "GuUINavigationController.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GuUINavigationController ()

@end

@implementation GuUINavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompactPrompt];
        UIView * statusBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, 20)];
        [statusBgView setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:statusBgView];
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20,MAX_WIDTH , 44)];
        self.bgImageView.image = [UIImage imageNamed:@"标题栏底.png"];
        [self.view insertSubview:self.bgImageView belowSubview:self.navigationBar];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
