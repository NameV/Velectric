//
//  OrderProcessVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderProcessVC.h"
#import "OrderProcessCell.h"            //流程cell
#import "OrderProcessModel.h"
#import "LogisticsCell.h"               //物流cell

@interface OrderProcessVC ()<UITableViewDelegate,UITableViewDataSource>

//流程列表
@property (strong,nonatomic) BaseTableView * tableView;

//是否显示物流
@property (assign,nonatomic) BOOL isShowLogistics;

//物流数据list
@property (strong,nonatomic) NSMutableArray <OrderProcessModel *>* logisticsList;

@property (assign,nonatomic) CGFloat logisticsViewHeight;

@end

@implementation OrderProcessVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"订单跟踪";
    _logisticsList = [NSMutableArray array];
    //创建 UI
    [self creatUI];
}

#pragma mark - 创建 UI
-(void)creatUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1;
    [_tableView addHeaderWithTarget:self action:@selector(refreshNetData)];
    [_tableView headerBeginRefreshing];
    [self.view addSubview:_tableView];
}

-(void)setOrderTraces:(NSArray *)orderTraces
{
    _orderTraces = orderTraces;
}

#pragma mark - FreshHeader
- (void)refreshNetData
{
    [self requestOrderProcessData];
}

#pragma mark - 请求流程数据
-(void)requestOrderProcessData
{
    [_tableView.dataArray removeAllObjects];

    for (NSDictionary * dic in _orderTraces) {
        OrderProcessModel * model = [[OrderProcessModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [_tableView.dataArray addObject:model];
    }
    [_tableView reloadData];
    [_tableView headerEndRefreshing];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return _tableView.dataArray.count;
    }else{
        return _logisticsList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        static NSString * indentifer= @"indentifer";
        OrderProcessCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[OrderProcessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        OrderProcessModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
        cell.model = model;
        if (indexPath.row == 0) {
            cell.verticaleLine.frame = CGRectMake(cell.verticaleLine.left, cell.yuanImage.bottom, cell.verticaleLine.width, 40 - cell.yuanImage.bottom);
        }else{
            cell.verticaleLine.frame = CGRectMake(cell.verticaleLine.left, -10, cell.verticaleLine.width, 50);
        }
        if ([model.myDescription containsString:@"已发货"]) {
            cell.seeLogisticsBtn.hidden = NO;
            if (_isShowLogistics){
                cell.logisticsView.hidden = NO;
            }else{
                cell.logisticsView.hidden = YES;
            }
            
            [cell.seeLogisticsBtn addTarget:self action:@selector(seeLogistics:) forControlEvents:UIControlEventTouchUpInside];
            cell.verticaleLine.frame = CGRectMake(cell.verticaleLine.left, -10, cell.verticaleLine.width, cell.verticaleLine.height + 50);
            cell.logisticsView.frame = CGRectMake(cell.logisticsView.left, cell.seeLogisticsBtn.bottom, cell.logisticsView.width, _logisticsViewHeight);
            cell.logisticsView.delegate = self;
            cell.logisticsView.dataSource = self;
            cell.logisticsView.tag = 2;
            [cell.logisticsView reloadData];
        }else{
            cell.seeLogisticsBtn.hidden = YES;
            cell.logisticsView.hidden = YES;
        }
        return cell;
    }else{
        static NSString * indentifer= @"indentifer1";
        LogisticsCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[LogisticsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        OrderProcessModel * model = [_logisticsList objectAtIndex:indexPath.row];
        cell.logisticsModel = model;
        if (indexPath.row == _logisticsList.count - 1) {
            
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        OrderProcessModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
        if ([model.myDescription containsString:@"已发货"]) {
            if (_isShowLogistics) {
                return 80+_logisticsViewHeight;
            }
            return 80;
        }
        return 40;
    }else{
        return 50;
    }
}

#pragma mark - 查看物流
-(void)seeLogistics:(UIButton *)sender
{
    _isShowLogistics = !_isShowLogistics;
    if (_isShowLogistics) {
        //显示物流
        [sender setImage:[UIImage imageNamed:@"chakanwuliushang"] forState:UIControlStateNormal];
        [self requestLogisticsData];
    }else{
        //隐藏物流
        [sender setImage:[UIImage imageNamed:@"chakanwuliuxia"] forState:UIControlStateNormal];
    }
    [_tableView reloadData];
}

#pragma mark - 请求物流数据
-(void)requestLogisticsData
{
    NSArray * keyList = [_logisticsDic allKeys];
    [_logisticsList removeAllObjects];
    for (NSString * key in keyList) {
        OrderProcessModel * model = [[OrderProcessModel alloc]init];
        model.logisticsTime = key;
        model.myDescription = [_logisticsDic objectForKey:key];
        [_logisticsList addObject:model];
    }
    _logisticsViewHeight = _logisticsList.count * 50;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
