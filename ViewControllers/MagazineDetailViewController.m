//
//  MagazineDetailViewController.m
//  VisitaLookWorld1.0
//
//  Created by 古玉彬 on 15/11/7.
//  Copyright © 2015年 guyubin. All rights reserved.
//

#import "MagazineDetailViewController.h"
#import "MagDetailModel.h"
#import "MagDetailReusableView.h"
#import "MagDetailViewCell.h"

#define MAX_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MagazineDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView; //表格布局
    NSMutableArray *_dataArray; //数据源
    MBProgressHUD * _hub; //加载框
}

@end

@implementation MagazineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayout]; //布局
    [self setData]; //加载数据
    
}
//隐藏分栏
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}


//显示分栏
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}


- (void)setLayout {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //导航栏标题
    self.title = [NSString stringWithFormat:@"第%@期",self.magObj.volYear];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //左侧返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    
    //layout
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT-64) collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    
    //注册cell
    
    [_collectionView registerNib:[UINib nibWithNibName:@"MagDetailViewCell" bundle:nil] forCellWithReuseIdentifier:@"detailCellIdentifier"];
    
    //reusable头cell
    [_collectionView registerNib:[UINib nibWithNibName:@"MagDetailReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellReusableView"];
    
    //加载框
    _hub = [MBProgressHUD showHUDAddedTo:_collectionView animated:YES];
}

- (void)setData {
    
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }

    //网络请求
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * urlStr = [[NSString stringWithFormat:@"http://ktx.cms.palmtrends.com/api_v2.php? action=get_mags_detail&sa=&uid=10067567&mobile=ip hone5&offset=0&count=1000&magid=%@&e=40dab97d7 73e7860febfc897c04824e2&uid=10067567&pid=10053& mobile=iphone5&platform=i",self.magObj.magId] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [session GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //解析json
        for (NSDictionary * dic in jsonObj[@"cats"]) {
            MagDetailModel * model = [[MagDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (![model.catName isEqualToString:@"图片"]) {
                [_dataArray addObject:model];
            }

        }
        
        //主线程刷新ui
     //   dispatch_async(dispatch_get_main_queue(), ^{
            //刷新数据
            [_collectionView reloadData];
            
            //关闭加载框
            [_hub setHidden:YES];
     //   });
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"detailCellIdentifier";
    
    MagDetailViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //赋值
    MagDetailModel * model = _dataArray[indexPath.row];
    
    cell.title.text = model.catName; //标题
    cell.content.text = model.title;  //内容
    
    return cell;
}

//单元格高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(MAX_WIDTH-10, 90);
}

//cell 头

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MagDetailReusableView * cell;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // 头视图
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"cellReusableView" forIndexPath:indexPath];
        
        cell.MagTitle.text = self.magObj.title;
        cell.MagTime.text = self.magObj.updateTime;
        cell.MagDesc.text = self.magObj.desc;
    }
    
    return cell;
}

//头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = [self.magObj.desc boundingRectWithSize:CGSizeMake(MAX_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}context:nil].size;
    return CGSizeMake(0, size.height+70);
}

#pragma mark -  button click refer

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
