//
//  MagazineViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "MagazineViewController.h"
#import "MagModel.h"
#import "MagazineViewCell.h"
#import "UIImageView+WebCache.h"
#import "MagazineDetailViewController.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MagazineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView * _collectonView;
    MBProgressHUD * _hub; //加载视图
    NSMutableArray *_dataArray; //数据源
}

@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRefer]; //设置导航栏
    [self setLayout]; //布局相关
    [self setdata]; //加载数据
}

//导航栏相关
- (void)setNavigationRefer {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"切换_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    //右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"设置_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
}



//布局相关
- (void)setLayout {
    //collectionView
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(MAX_WIDTH - 10, 120);
    
    _collectonView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, MAX_WIDTH - 10, MAX_HEIGHT - 125) collectionViewLayout:flowLayout];
    _collectonView.delegate = self;
    _collectonView.dataSource = self;
    [_collectonView setBackgroundColor:[UIColor clearColor]];
    _collectonView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectonView];
    
    //注册cell
    [_collectonView registerNib:[UINib nibWithNibName:@"MagazineViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    //加载视图
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hub setDimBackground:YES];
    [_hub setHidden:NO];
    
}

//加载数据
- (void)setdata {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求
    [manager GET:@"http://ktx.cms.palmtrends.com/api_v2.php?%20action=get_mags_list&sa=&uid=10067567&mobile=ipho%20ne5&offset=0&count=15&&e=40dab97d773e7860febfc89%207c04824e2&uid=10067567&pid=10053&mobile=iphone5%20&platform=i" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //解析数据
        for (NSDictionary * dic in jsonObj[@"list"]) {
            MagModel * model = [[MagModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (model) {
                [_dataArray addObject:model];
            }
        }
        
     //   dispatch_async(dispatch_get_main_queue(), ^{
            //关闭加载视图
            [_hub setHidden:YES];
            
            //刷新数据
            [_collectonView reloadData];
     //   });
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cellIdentifier";
    MagazineViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.magtitle setTextColor:[UIColor blackColor]];
    MagModel * model = _dataArray[indexPath.row];
    [cell.magImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    cell.magtitle.text = model.title;
    cell.magContent.text = model.desc;
    cell.magVolYear.text = [NSString stringWithFormat:@"%@年第%@期",model.year,model.volYear];
    cell.magUpdateTime.text = model.updateTime;
    if (!((indexPath.row  - 2 ) % 4) || !((indexPath.row  - 3 ) % 4)) {
        [cell.magtitle setTextColor:[UIColor redColor]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //资讯id
    MagModel * model = _dataArray[indexPath.row];
    MagazineDetailViewController * ivc = [[MagazineDetailViewController alloc] init];
    ivc.magObj = model;
    [self.navigationController pushViewController:ivc animated:YES];
}
#pragma mark - button click 

//导航栏左侧按钮
- (void)leftBtnClick {
    //返回左侧页面
    [self.navigationController.tabBarController setSelectedIndex:0];
}

//导航栏右侧按钮
- (void)rightBtnClick {
    
}

@end
