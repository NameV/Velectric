//
//  OrderListVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/15.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "OrderListVC.h"
#import "OrderDetailVC.h"               //订单详情
#import "OrderListCell.h"               //订单cell
#import "OrderListModel.h"              //订单列表model
#import "GoodsModel.h"                  //商品model
#import "CartnilView.h"
#import "CommitOrderVC.h"               //提交订单成功
#import "CartViewController.h"          //购物车 再次购买跳转
#import "AlertView.h"
#import "VPopView.h"

//请求status
typedef enum{
    RequestOrderStatus_All = 0,                 //所有
    RequestOrderStatus_WaitPay = 1,             //代付款
    RequestOrderStatus_WaitHandle = 2,          //待受理
    RequestOrderStatus_WaitReceive = 3,         //待收货
    RequestOrderStatus_Finieshed = 4,           //已完成
    RequestOrderStatus_Cancel = 5,              //已取消
    RequestOrderStatus_Close = 6,               //已关闭
    RequestOrderStatus_Unusual = 7,             //异常
}RequestOrderStatus;

@interface OrderListVC ()<UITableViewDelegate,UITableViewDataSource,AlertViewDelegate>

//工具栏
@property (strong,nonatomic) UIScrollView * toolbarView;

//工具栏按钮list
@property (strong,nonatomic) NSMutableArray <UIButton *>* toolBarBtnList;

//工具栏底部线条
@property (strong,nonatomic) UIView * toolBarBottomLine;

//工单scrollview
@property (strong, nonatomic) UIScrollView * orderScrollView;

//列表
@property (strong,nonatomic) NSMutableArray <BaseTableView *> * tableList;

//订单状态
@property (assign,nonatomic) OrderStatus orderStatus;

//空view
@property (strong,nonatomic) CartnilView * emptyView;

//当前 tableview index
@property (assign,nonatomic) NSInteger executeIndex;

//是否可以加载
@property (assign,nonatomic) BOOL isCanLoad;

//alert操作提示 1确认收货     2取消订单
@property (assign,nonatomic) NSInteger alertExecute;

//当前操作的model
@property (strong,nonatomic) OrderListModel * executeModel;

//是否返回
@property (assign,nonatomic) BOOL isBack;

@property (strong,nonatomic) BaseTableView * mainTableView;//tableview

@end

@implementation OrderListVC{
    RequestOrderStatus requestStatus;//请求参数
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"订单中心";
    _toolBarBtnList = [NSMutableArray array];
    _tableList = [NSMutableArray array];
    _orderStatus = OrderStatus_All;
    [self setLeftBarButtonWithAction:@selector(toBack)];
    
    //创建 顶部导航view
    [self creatTopToolbarView];
    //创建 tableView
    [self creatTableView];
    
    self.executeIndex = 1;
}

#pragma mark - 创建 顶部导航view
-(void)creatTopToolbarView
{
    NSArray * titleList = @[Order_All,Order_WaitPay,Order_WaitExecuse,Order_WaitReceive,Order_Finish,Order_Cancel,Order_Unusual];
    //工具栏
    _toolbarView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _toolbarView.showsHorizontalScrollIndicator = NO;
    _toolbarView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:_toolbarView];
    
    UIView * lastView;
    CGFloat firshBtnWidth = 0.0;
    for (int i=0; i<titleList.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = Font_1_F15;
        button.tag = i;
        [button setTitle:[titleList objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        CGFloat width = [[titleList objectAtIndex:i] getStringWidthWithFont:button.titleLabel.font];
        button.layer.cornerRadius = 2;
        if (i==0) {
            button.frame = CGRectMake(10, 0, width + 30, 50);
            [button setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
            firshBtnWidth = button.width;
        }else{
            button.frame = CGRectMake(lastView.right + 0, 0, width + 30, 50);
        }
        
        [button addTarget:self action:@selector(toolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolbarView addSubview:button];
        [_toolBarBtnList addObject:button];
        lastView = button;
    }
    _toolbarView.contentSize = CGSizeMake(lastView.right + 10, _toolbarView.height);
    _toolBarBottomLine = [[UIView alloc]initWithFrame:CGRectMake(10, 48, firshBtnWidth, 2)];
    _toolBarBottomLine.backgroundColor = COLOR_F2B602;
    [_toolbarView addSubview:_toolBarBottomLine];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, _toolbarView.height - 0.5, _toolbarView.contentSize.width, 0.5)];
    line.backgroundColor = COLOR_DDDDDD;
    [_toolbarView addSubview:line];
}

#pragma mark - 工具栏按钮点击
-(void)toolBarBtnClick:(UIButton *)sender
{
    _executeIndex = sender.tag;
    switch (_executeIndex) {
        case 0://全部
            requestStatus = RequestOrderStatus_All;
            break;
        case 1://待付款
            requestStatus = RequestOrderStatus_WaitPay;
            break;
        case 2://待受理
            requestStatus = RequestOrderStatus_WaitHandle;
            break;
        case 3://待收货
            requestStatus = RequestOrderStatus_WaitReceive;
            break;
        case 4://已关闭
            requestStatus = RequestOrderStatus_Close;
            break;
        case 5://已取消
            requestStatus = RequestOrderStatus_Cancel;
            break;
        case 6://异常订单
            requestStatus = RequestOrderStatus_Unusual;
            break;
        default:
            break;
    }
    CGRect rect = self.emptyView.frame;
    rect.origin.x = _executeIndex * SCREEN_WIDTH;
    rect.size.width = SCREEN_WIDTH;
    self.emptyView.frame = rect;
    
    [_orderScrollView setContentOffset:CGPointMake(_executeIndex * SCREEN_WIDTH, 0) animated:YES];
    //判断是否需要移动
    [self judgeIsNeedToMove:sender];
    
    BaseTableView * baseTable = [_tableList objectAtIndex:_executeIndex];
    if (baseTable.dataArray.count==0) {
        [baseTable headerBeginRefreshing];
    }else{
        self.emptyView.hidden = YES;
    }
}

-(void)setExecuteIndex:(NSInteger)executeIndex
{
    _executeIndex = executeIndex;
    
    UIButton * btn = [_toolBarBtnList objectAtIndex:executeIndex];
    [self toolBarBtnClick:btn];
}

#pragma mark - 判断是否需要移动
-(void)judgeIsNeedToMove:(UIButton *)sender
{
    for (UIButton * btn in _toolBarBtnList) {
        if ([btn isEqual:sender]) {
            [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        }
    }
    
    VJDWeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.toolBarBottomLine.frame = CGRectMake(sender.left, weakSelf.toolBarBottomLine.top, sender.width, weakSelf.toolBarBottomLine.height);
    }];
    //第一个按钮
    if ([sender isEqual:[_toolBarBtnList firstObject]]) {
        [_toolbarView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //最后一个按钮
    else if ([sender isEqual:[_toolBarBtnList lastObject]]) {
        [_toolbarView setContentOffset:CGPointMake(_toolbarView.contentSize.width - _toolbarView.width, 0) animated:YES];
    }
    else{
        CGFloat offset = _toolbarView.contentOffset.x;
        if (offset == _toolbarView.contentSize.width - _toolbarView.width) {
            return;
        }
        //自动向左移动
        if((sender.right - offset) > (_toolbarView.width - 30)){
            if (offset + _toolbarView.frame.size.width >= _toolbarView.contentSize.width) {
                [_toolbarView setContentOffset:CGPointMake(_toolbarView.contentSize.width - _toolbarView.width, 0) animated:YES];
            }
            [_toolbarView setContentOffset:CGPointMake(offset + sender.width, 0) animated:YES];
        }
        //自动向右移动
        if((sender.left - offset) < 30){
            [_toolbarView setContentOffset:CGPointMake(offset - sender.width, 0) animated:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    if ([sender isKindOfClass:[BaseTableView class]]) {
        return;
    }
    self.executeIndex = sender.contentOffset.x/SCREEN_WIDTH;
}

#pragma mark - 创建 表格
-(void)creatTableView
{
    _orderScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _toolbarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - _toolbarView.height)];
    _orderScrollView.pagingEnabled = YES;
    _orderScrollView.delegate = self;
    _orderScrollView.showsHorizontalScrollIndicator = NO;
    _orderScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _toolBarBtnList.count, _orderScrollView.height);
    [self.view addSubview:_orderScrollView];
    
    CartnilView * cartnil = [[[NSBundle mainBundle]loadNibNamed:@"CartnilView" owner:self options:nil] lastObject];
    CGRect rect = cartnil.frame;
    rect.origin.y = -60;
    rect.size.width = SCREEN_WIDTH;
    cartnil.frame = rect;
    [cartnil.goIGuangGuangBtn addTarget:self action:@selector(goShopping) forControlEvents:UIControlEventTouchUpInside];
    cartnil.goIGuangGuangBtn.tag = 10001;//去逛逛
    [_orderScrollView addSubview:cartnil];
    self.emptyView = cartnil;
    self.emptyView.hidden = YES;

    //创建tableview
    for (int i=0; i<_toolBarBtnList.count; i++) {
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, _orderScrollView.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i+1;
        tableView.pageSize = 5;
        [tableView addHeaderWithTarget:self action:@selector(refreshNetData)];
        [tableView addFooterWithTarget:self action:@selector(loadMoreNetData)];
        [_orderScrollView addSubview:tableView];
        [_tableList addObject:tableView];
    }
    
    [self.view bringSubviewToFront:_orderScrollView];
}

#pragma mark - 去逛逛
-(void)goShopping
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - FreshHeader
- (void)refreshNetData
{
    BaseTableView * baseTable = [_tableList objectAtIndex:_executeIndex];
    baseTable.pageNo = 1;
    //移除旧数据
    [baseTable.dataArray removeAllObjects];
    //请求数据
    [self requestOrderListData];
}

#pragma mark - LoodingFooter
- (void)loadMoreNetData
{
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    if (!_isCanLoad) {
        [tableView footerEndRefreshing];
        return;
    }
    //请求数据
    [self requestOrderListData];
}

#pragma mark - 请求数据
-(void)requestOrderListData
{
    self.emptyView.hidden = YES;
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"state":[NSNumber numberWithInt:requestStatus],
                                    @"pageSize":[NSNumber numberWithInteger:tableView.pageSize],
                                    @"currentPage":[NSNumber numberWithInteger:tableView.pageNo],
                                    };
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetOrderPageURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            NSArray * memberMyOrderList = [responseObject objectForKey:@"memberMyOrderList"];
            for (NSDictionary * orderDic in memberMyOrderList) {
                OrderListModel * model = [[OrderListModel alloc]init];
                [model setValuesForKeysWithDictionary:orderDic];
                [tableView.dataArray addObject:model];
            }
            if (memberMyOrderList.count >= tableView.pageSize) {
                tableView.pageNo++;
                weakSelf.isCanLoad = YES;
            }else{
                weakSelf.isCanLoad = NO;
            }
            [tableView reloadData];
            if (tableView.pageNo == 1 && memberMyOrderList.count ==0) {
                weakSelf.emptyView.hidden = NO;
            }else{
                weakSelf.emptyView.hidden = YES;
            }
        }else{
            [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"resultMsg"]];
        }
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseTableView * baseTable = (BaseTableView *)tableView;
    return baseTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer=@"indentifer";
    OrderListCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell=[[OrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    BaseTableView * baseTable = (BaseTableView *)tableView;
    OrderListModel * model = [baseTable.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    cell.payBtn.tag = indexPath.row;
    cell.cancelBtn.tag = indexPath.row;
    cell.detailBtn.tag = indexPath.row;
    cell.buyAgainBtn.tag = indexPath.row;
    cell.sureResiveBtn.tag = indexPath.row;
    cell.unusualBtn.tag = indexPath.row;
    
    switch (model.orderStateAPP) {
        case OrderStatus_WaitPay:
        {
            [cell.payBtn addTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureResiveBtn removeTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buyAgainBtn removeTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderStatus_WaitExecuse:
        {
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn removeTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn removeTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureResiveBtn removeTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buyAgainBtn removeTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderStatus_WaitReceive://待收货
        {
            [cell.sureResiveBtn addTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn removeTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn removeTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buyAgainBtn removeTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
            [cell.unusualBtn addTarget:self action:@selector(unusualBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case OrderStatus_Finish:
        {
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn removeTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn removeTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureResiveBtn removeTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buyAgainBtn removeTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderStatus_Cancel:
        {
            [cell.buyAgainBtn addTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn removeTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn removeTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureResiveBtn removeTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderStatus_Unusual:
        {
            [cell.buyAgainBtn addTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
            [cell.detailBtn addTarget:self action:@selector(showOrderDetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.payBtn removeTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelBtn removeTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sureResiveBtn removeTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

#pragma mark - 订单详情
-(void)showOrderDetail:(UIButton *)sender
{
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    OrderListModel * model = [tableView.dataArray objectAtIndex:sender.tag];
    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
    vc.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    vc.orderTraces = model.orderTraces;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 支付
-(void)doPay:(UIButton *)sender
{
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    OrderListModel * model = [tableView.dataArray objectAtIndex:sender.tag];
    
    CommitOrderVC * vc = [[CommitOrderVC alloc]init];
    vc.mergePaymentId = model.mergePaymentId;
    vc.isOrderEnter = YES;
    vc.enterType = EnterType_OrderCenter;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 取消订单
-(void)doCancel:(UIButton *)sender
{
    _alertExecute = 2;
    
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"您确定要取消订单吗？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
    
    
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    _executeModel = [tableView.dataArray objectAtIndex:sender.tag];
    
}

#pragma mark - 确认收货
-(void)doSureReceive:(UIButton *)sender
{
    _alertExecute = 1;
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"您确定要收货吗？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
    
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    _executeModel = [tableView.dataArray objectAtIndex:sender.tag];
    
}

#pragma mark - AlertView Delegate
- (void)okBtnAction
{
    [[KGModal sharedInstance] hide];
    
    if (_alertExecute == 1) {
        [self executeSureReceive];
    }else{
        [self executeCancelOrder];
    }
}

- (void)cancleBtnAction
{
    [[KGModal sharedInstance] hide];
}

#pragma mark - 执行 取消订单
-(void)executeCancelOrder
{
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"orderId":[NSNumber numberWithInteger:_executeModel.orderId],
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCancelOrderURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showTextHUD:@"取消成功"];
            weakSelf.executeModel.orderStateAPP = OrderStatus_Cancel;
            NSInteger row = [tableView.dataArray indexOfObject:weakSelf.executeModel];
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 执行 确认收货
-(void)executeSureReceive
{
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"orderId":[NSNumber numberWithInteger:_executeModel.orderId],
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetReceiveOrderURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showTextHUD:@"已经确认收货"];
            weakSelf.executeModel.orderStateAPP = OrderStatus_Finish;
            [tableView reloadData];
        }else{
            [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 再次购买
-(void)doBuyAgain:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    BaseTableView * baseTable = [_tableList objectAtIndex:_executeIndex];
    OrderListModel * model = [baseTable.dataArray objectAtIndex:tag];
    NSMutableArray *goodArray = model.goodsList;
    
    if (goodArray.count > 1) {
        [self addLotCartNetWorkingWithArray:goodArray];
    }else{
        [self addSingalCartNetWorkingWithArray:goodArray];
    }
}

#pragma mark 单个加入购物车加入购物车的方法
-(void)addSingalCartNetWorkingWithArray:(NSMutableArray *)array
{
    GoodsModel *model = array[0];
    NSDictionary * parameters = @{@"goodId" :    [NSNumber numberWithInteger:model.myId],
                                  @"quantity"   :   [NSNumber numberWithInteger:model.quantity],
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:GetAddGoodsToCartURL
                                    parameters:parameters
                                       success:^(NSDictionary *responseObject) {
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               //跳转购物车
                                               CartViewController * vc = [[CartViewController alloc]init];
                                               vc.fromDetailFlag = @"detail";
                                               [self.navigationController pushViewController:vc animated:YES];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
                                       }];
}

#pragma mark 批量加入购物车的方法
-(void)addLotCartNetWorkingWithArray:(NSMutableArray *)array
{
    
    NSString *goodId = nil;
    NSString * payNumber = nil;
    for (GoodsModel * model in array) {
        
        //id
        if (goodId) {
            goodId= [NSString stringWithFormat:@"%@,%ld",goodId,(long)model.myId];
        }else{
            goodId = [NSString stringWithFormat:@"%ld",(long)model.myId];
        }
        
        //数量
        if (payNumber) {
            payNumber= [NSString stringWithFormat:@"%@,%ld",payNumber,(long)model.quantity];
        }else{
            payNumber = [NSString stringWithFormat:@"%ld",(long)model.quantity];
        }
    }
    
    NSDictionary * parameters = @{@"goodsIdStr":goodId,
                                  @"quantitys":payNumber,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetBatchAddGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:nil];
            //跳转购物车
            CartViewController * vc = [[CartViewController alloc]init];
            vc.fromDetailFlag = @"detail";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

#pragma mark - 返回
-(void)toBack
{
    
    
    //如果订单是从商品详情页进入的，OrderCenterEnter_MemberCenter,这样在返回的时候返回到上一个界面。
//    if ([[NSUserDefaults standardUserDefaults]integerForKey:OrderFromeProductDetail] == 1) {
//        NSArray *array = self.navigationController.childViewControllers;
//        UIViewController *con = (UIViewController *)array[array.count - 4];
//        [self.navigationController popToViewController:con animated:YES];
//        return;
//    }
    
    //从会员中心进入,返回商品详情界面。
    if (_enterType == OrderCenterEnter_MemberCenter) {
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        //从提交订单进入
        self.tabBarController.selectedIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - 异常订单

- (void)unusualBtnAction:(UIButton *)btn {
    BaseTableView * tableView = [_tableList objectAtIndex:_executeIndex];
    OrderListModel * model = [tableView.dataArray objectAtIndex:btn.tag];

    VPopView *popView = [[VPopView alloc]initTitle:@"异常订单申请" certenBlock:^(NSString *content, NSInteger type) {
        ELog(@"%@=====%lu",content,type);
        [self requestOrderWithReason:content reasonId:type orderId:model.orderId];
    }];
    [popView show];
}

#pragma mark - https
//提交异常订单
- (void)requestOrderWithReason:(NSString *)reason reasonId:(NSInteger)reasonId orderId:(NSInteger)orderId{
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"orderId"   :   [NSNumber numberWithInteger:orderId],
                               @"reasonId"  :   [NSNumber numberWithInteger:reasonId],
                               @"reason"    :   reason
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:ExceptionRequestOrderURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           //                                           &&responseObject[@"result"]
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"] ) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
