//
//  MyTabBarController.m
//  HomeworkWeekend
//
//  Created by 古玉彬 on 15/10/23.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "MyTabBarController.h"
#import "InfoViewController.h"
#import "MagazineViewController.h"
#import "RespectableViewController.h"
#import "PictureViewController.h"
#import "ViewController.h"
#import "GuUINavigationController.h"

@interface MyTabBarController (){
    
    NSMutableArray *_viewControllers; //子视图数组
    NSArray *_classNameArray; //类名数组
    NSArray *_tabNameAndPicArray; //tab名称和图片
    
}


@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData]; //初始化数据
}

//初始化数据
- (void)setData {
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    
    _classNameArray = @[@"InfoViewController",@"MagazineViewController",@"RespectableViewController",@"PictureViewController"];
    //tabbar信息。。。偷懒直接写死。= =
    _tabNameAndPicArray = @[@[@"资讯",@"资讯_1",@"资讯_2"],@[@"杂志",@"杂志_1.png",@"杂志_2.png"],@[@"微言",@"微言_1.png",@"微言_2.png"],@[@"酷图",@"酷图_1",@"酷图_2"]];
    
    [_classNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ViewController *rvc = [[NSClassFromString(obj) alloc] init];
        GuUINavigationController *ngc = [[GuUINavigationController alloc] initWithRootViewController:rvc];
//        [[ngc.viewControllers firstObject] setTitle:_tabNameAndPicArray[idx][0]];
        [ngc.tabBarItem setImage:[[UIImage imageNamed:_tabNameAndPicArray[idx][1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]; //未选中图标
        [ngc.tabBarItem setSelectedImage:[[UIImage imageNamed:_tabNameAndPicArray[idx][2]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]; //选中图片
        [_viewControllers addObject:ngc];
        [self.tabBar setBarTintColor:[UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1.00f]];
    }];
    
    self.viewControllers = _viewControllers;
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
