//
//  PictureViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "PictureViewController.h"
#import "CoolPicModel.h"
#import "CoolPicViewCell.h"
#import "CoolPicDetailViewController.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView; //滚动视图
    MBProgressHUD *_hub; //加载视图
    NSMutableArray * _dataArray; //数据源
    
}
@end

@implementation PictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarRefers]; //导航栏相关
    [self setLayout]; //布局相关
    [self loadData]; //加载数据
    
}

//布局相关
- (void)setLayout {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //背景黑色
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //layout
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT - 104) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    //注册cell
    
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CoolPicViewCell" bundle:nil] forCellWithReuseIdentifier:@"coolPicCell"];
    
    //加载视图
    _hub = [MBProgressHUD showHUDAddedTo:_collectionView animated:YES];
}

- (void)setNavigationBarRefers {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"设置_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
}


//加载数据
- (void)loadData {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://ktx.cms.palmtrends.com/api_v2.php?action=piclist&sa=&uid=10067567&mobile=iphone5&offset=0&count=9&&e=40dab97d773e7860febfc897c04824e2&uid=10067567&pid=10053&mobile=iphone5&platform=i" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //解析数据
        for (NSDictionary * dic in jsonObj[@"list"]) {
            CoolPicModel * model = [[CoolPicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        //刷新数据
        [_collectionView reloadData];
        
        //关闭小菊花
        [_hub setHidden:YES];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"coolPicCell";
    CoolPicViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    CoolPicModel * model = _dataArray[indexPath.row];
    [cell.coolImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    cell.coolTitle.text = model.title;
    cell.coolImage.hidden = !(indexPath.row & 1);
    cell.cooBgImage.hidden = indexPath.row & 1;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MAX_WIDTH/3, 160);
}

//cell间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//行高
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}


//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CoolPicDetailViewController * cvc = [[CoolPicDetailViewController alloc] init];
    cvc.gid = [_dataArray[indexPath.row] gid];
    self.navigationController.tabBarController.tabBar.hidden = YES; //隐藏底部栏
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
