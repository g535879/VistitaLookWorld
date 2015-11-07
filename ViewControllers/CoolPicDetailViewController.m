//
//  CoolPicDetailViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "CoolPicDetailViewController.h"
#import "GuUINavigationController.h"
#import "CoolPIcDetailModel.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CoolPicDetailViewController (){
    UIToolbar *_toolbar;
    UIImageView *_picImageView; //图片
    UIButton *_picLabel; //图片标题
    UILabel *_picDesc; //图片描述
    MBProgressHUD *_hub;//小菊花
}

@end

@implementation CoolPicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationRefer];
    [self loadData]; //请求数据
    [self setLayout]; // 布局
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //改变导航栏颜色
    [[(GuUINavigationController *)self.navigationController bgImageView] setImage:[UIImage imageNamed:@"ad_title_bg"]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //修改导航栏背景
    [[(GuUINavigationController *)self.navigationController bgImageView] setImage:[UIImage imageNamed:@"标题栏底.png"]];
    self.navigationController.tabBarController.tabBar.hidden = NO;

}
//导航栏相关
- (void)navigationRefer {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回2_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    
}

- (void)setLayout {
    
    //背景色
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    //图片
    
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, MAX_WIDTH, MAX_HEIGHT / 2)];
    [self.view addSubview:_picImageView];
    
    //图片标题
    _picLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_picImageView.frame), MAX_WIDTH, 40)];
    [_picLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_picLabel.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _picLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _picLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_picLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ad_title_bg"]]];
    [self.view addSubview:_picLabel];
    
    //图片des
    _picDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_picLabel.frame), MAX_WIDTH, MAX_HEIGHT-CGRectGetMaxY(_picLabel.frame)-50)];
    _picDesc.numberOfLines = 0;
    [_picDesc setTextColor:[UIColor whiteColor]];
    [_picDesc setAdjustsFontSizeToFitWidth:YES];
    [_picDesc setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:_picDesc];
    //工具栏
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, MAX_HEIGHT-44, MAX_WIDTH, 44)];
    
    [_toolbar setBarTintColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1]];
    
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
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


//得到自定义BBI
- (UIBarButtonItem *)customBBIWithImageName:(NSString *)imageName andAction:(SEL)action{
    UIBarButtonItem *bBBI = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    return bBBI;
}

- (void)loadData {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [[NSString stringWithFormat:@"http://ktx.cms.palmtrends.com/api_v2.php? action=picture&sa=&uid=10067567&mobile=iphone5&of fset=0&count=15&gid=%@&moblie=iphone5&e=40dab9 7d773e7860febfc897c04824e2&uid=10067567&pid=1005 3&mobile=iphone5&platform=i",self.gid] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary * dic in jsonObj[@"list"]) {
            CoolPIcDetailModel * model = [[CoolPIcDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            //刷新数据
            [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]]; //加载图片
            [_picLabel setTitle:model.title forState:UIControlStateNormal];//图片标题
            _picDesc.text = model.des; //图片描述
            [_hub setHidden:YES];
            
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//返回按钮
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
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
