//
//  InfoViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/6.
//  Copyright © 2015年 guyubin. All rights reserved.
//


#import "InfoViewController.h"
#import "InfoDetailViewController.h"
#import "InfoViewCell.h"
#import "InfoModel.h"
#import "UIImageView+WebCache.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface InfoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_dataArray; //数据源
    MBProgressHUD *_hub; //小菊花
    UICollectionView *_collectionView; //表格

}

@end
@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarRefers]; //设置导航栏
    [self initData]; //初始化数据
    [self loadData]; //获取数据
    [self setLayout]; //布局
}


- (void)initData {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
}

- (void)setNavigationBarRefers {

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"设置_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)loadData {
    
    //小菊花
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hub setDimBackground:YES];
    [_hub setHidden:NO];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://ktx.cms.palmtrends.com/api_v2.php?%20action=home_list&sa=&uid=10067566&mobile=iphone5%20&offset=0&count=15&&e=b7849d41b00bbacc9a6254440%202abed9e&uid=10067566&pid=10053&mobile=iphone5&p%20latform=i" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in jsonObj[@"list"]) {
            InfoModel * model = [[InfoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (model) {
                [_dataArray addObject:model];
            }
        }
            //刷新表格。
        [_collectionView reloadData];
            
        [_hub setHidden:YES]; //关闭小菊
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)setLayout {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //表格布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(MAX_WIDTH-10, 120);
    
    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, MAX_WIDTH-10, MAX_HEIGHT-125) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"InfoViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
}

//单元格宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cellIdentifier";
    InfoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //设置属性
    InfoModel * model = _dataArray[indexPath.row];
    [cell.imageIcon sd_setImageWithURL:[NSURL URLWithString:model.icon  ]];
    cell.title.text = model.title;
    [cell.title setTextColor:[UIColor blackColor]];
    cell.content.text = model.desc;
    cell.time.text = model.pubTime;
    if (indexPath.row & 1) { //基数
        [cell.title setTextColor:[UIColor redColor]];
    }
    return cell;

}

//选中单元格事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //资讯id
    NSString * uId = [_dataArray[indexPath.row] infoId];
    InfoDetailViewController * ivc = [[InfoDetailViewController alloc] init];
    ivc.uId = uId;
    [self.navigationController pushViewController:ivc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
