//
//  OrderDetailVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderProcessVC.h"                  //订单流程
#import "OrderDetailModel.h"
#import "GoodsModel.h"
#import "CartViewController.h"              //购物车 再次购买跳转
#import "CommitOrderVC.h"
#import "AlertView.h"
#import "VPopView.h"

#import "VProductDetailModel.h"
#import "VProductDetailCell.h"

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UIScrollView * scrollView;

//view的 y+height
@property (assign,nonatomic) CGFloat viewBottom;

//详情model
@property (strong,nonatomic) OrderDetailModel * detailModel;

//倒计时
@property (strong,nonatomic) UILabel * timingLab;

//定时器
@property (strong,nonatomic) NSTimer * timer;

//alert操作提示 1确认收货     2取消订单
@property (assign,nonatomic) NSInteger alertExecute;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UIButton *lookMoreButton;//查看更多button

@property (nonatomic, strong) UIView * secondBgView;//第二个view背景图

@property (nonatomic, strong) UIView * fourthBgView;//第四个view背景图

@property (nonatomic, strong) UIView * fifthBgView;//第五个view背景图

@property (nonatomic, strong) UILabel * countLab;//第四个--订单跟踪
@property (nonatomic, strong) UIImageView * goImg;//第四个--箭头


@end

static CGFloat originX = 10;

@implementation OrderDetailVC{
    BOOL isUnusualOrder;//是否为异常订单
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
    [VJDProgressHUD dismissHUD];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"订单详情";
    //请求订单详情接口
    [self requestOrderDetailData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [VJDProgressHUD dismissHUD];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 请求订单详情接口
-(void)requestOrderDetailData
{
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameterDic = @{@"orderId":_orderId,};
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetOrderDetailURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            NSDictionary * orderVO = [responseObject objectForKey:@"orderVO"];
            _detailModel = [[OrderDetailModel alloc]init];
            [_detailModel setValuesForKeysWithDictionary:orderVO];
            _detailModel.stepMap = [responseObject objectForKey:@"stepMap"];
            NSArray * productVO = [responseObject objectForKey:@"productVO"];
            for (NSDictionary * goodsDic in productVO){
                ProductInfoModel * product = [[ProductInfoModel alloc]init];
                [product setValuesForKeysWithDictionary:goodsDic];
                [_detailModel.productList addObject:product];
            }
            
            //-------------------yulei---------------------
            NSArray * productVOArray = [responseObject objectForKey:@"productVO"];
            for (NSDictionary *dic in productVOArray) {
                //yulei
                VProductDetailModel *model = [VProductDetailModel yy_modelWithDictionary:dic];
                for (VProductDetailCellModel *cellModel in model.ogvs) {
                    [self.datas addObject:cellModel];
                }
            }
            if ([orderVO[@"serviceStatus"] isEqual:@1]) {
                isUnusualOrder = YES;
            }
            //-------------------yulei---------------------
            
            //创建 UI
            [weakSelf creatUI];
        }else{
            [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

//提交异常订单
- (void)requestOrderWithReason:(NSString *)reason reasonId:(NSInteger)reasonId {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"orderId"   :   [NSNumber numberWithInteger:_detailModel.orderId],
                               @"reasonId"  :   [NSNumber numberWithInteger:reasonId],
                               @"reason"    :   reason
                               };

    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:ExceptionRequestOrderURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"] ) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark - 创建 UI
-(void)creatUI
{
    //--------------------yulei
    if (isUnusualOrder == YES) {
        _detailModel.orderStateAPP = OrderStatus_Unusual;
    }
    //--------------------yulei
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:_scrollView];
    _viewBottom = 0;
    //创建第一个背景view
    [self creatFirstWhiteBgView];
    //创建第二个背景view
    [self creatSecondWhiteBgView];
    
    
    //创建第三个背景view
//    [self creatThirdWhiteBgView];
    //---------------yulei------------------
    [self createThirdTableView];
    //---------------yulei------------------
    
    //创建第四个背景view
    [self creatFourthWhiteBgView];
    //创建按钮依据订单状态
    [self creatButtomWithOrderStatus];
}

#pragma mark - 创建第一个背景view
-(void)creatFirstWhiteBgView
{
    //白色背景
    UIView * firstBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _viewBottom, SCREEN_WIDTH, 100)];
    firstBgView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:firstBgView];
    
    //订单号-key
    UILabel * orderNoKeyLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, 0, 65, 50)];
    orderNoKeyLab.textColor = COLOR_333333;
    orderNoKeyLab.font = Font_1_F15;
    orderNoKeyLab.text = @"订单号";
    [firstBgView addSubview:orderNoKeyLab];
    
    //订单号-value
    UILabel * orderNoValueLab = [[UILabel alloc]initWithFrame:CGRectMake(orderNoKeyLab.right + 20, 0, 160, orderNoKeyLab.height)];
    orderNoValueLab.textColor = COLOR_999999;
    orderNoValueLab.font = Font_1_F15;
    orderNoValueLab.text = _detailModel.orderNumber;
    [firstBgView addSubview:orderNoValueLab];
    
    //订单状态
    UILabel * orderStatusLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 0, 70, orderNoKeyLab.height)];
    orderStatusLab.textColor = COLOR_F2B602;
    orderStatusLab.font = Font_1_F15;
    orderStatusLab.textAlignment = NSTextAlignmentRight;
    [firstBgView addSubview:orderStatusLab];

    switch (_detailModel.orderStateAPP) {
        case OrderStatus_WaitPay:
            orderStatusLab.text = Order_WaitPay;
            break;
        case OrderStatus_WaitExecuse:
            orderStatusLab.text = Order_WaitExecuse;
            break;
        case OrderStatus_WaitReceive:
            orderStatusLab.text = Order_WaitReceive;
            break;
        case OrderStatus_Finish:
            orderStatusLab.text = Order_Finish;
            break;
        case OrderStatus_Cancel:
            orderStatusLab.text = Order_Cancel;
            break;
        case OrderStatus_Unusual:
            orderStatusLab.text = Order_Unusual;
            break;
        default:
            break;
    }
    
    //灰色线条1
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_DDDDDD;
    [firstBgView addSubview:lineView1];
    
    //订单金额-key
    UILabel * moneyKeyLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, lineView1.bottom , orderNoKeyLab.width, orderNoKeyLab.height)];
    moneyKeyLab.textColor = orderNoKeyLab.textColor;
    moneyKeyLab.font = orderNoKeyLab.font;
    moneyKeyLab.text = @"订单金额";
    [firstBgView addSubview:moneyKeyLab];
    
    //金额-value
    UILabel * moneyValueLab = [[UILabel alloc]initWithFrame:CGRectMake(orderNoValueLab.left, moneyKeyLab.top, 150, orderNoKeyLab.height)];
    moneyValueLab.textColor = COLOR_F2B602;
    moneyValueLab.font = Font_1_F15;
    moneyValueLab.text = @"¥800.00";
    moneyValueLab.text = [NSString stringWithFormat:@"¥%0.2f",_detailModel.orderAmount];
    [firstBgView addSubview:moneyValueLab];
    
    //灰色线条2
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = COLOR_DDDDDD;
    [firstBgView addSubview:lineView2];
    
    //收货地址-key
    UILabel * addressKeyLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, lineView2.bottom, orderNoKeyLab.width, orderNoKeyLab.height)];
    addressKeyLab.textColor = orderNoKeyLab.textColor;
    addressKeyLab.font = orderNoKeyLab.font;
    addressKeyLab.text = @"收货地址";
    [firstBgView addSubview:addressKeyLab];
    
    //收货人姓名 手机号
    UILabel * infoLab = [[UILabel alloc]initWithFrame:CGRectMake(orderNoValueLab.left, addressKeyLab.top + 10, 200, 20)];
    infoLab.textColor = COLOR_666666;
    infoLab.font = orderNoKeyLab.font;
    infoLab.text = [NSString stringWithFormat:@"%@ %@",_detailModel.receiverName,_detailModel.mobile];
    [firstBgView addSubview:infoLab];
    
    //详细地址
    CGSize size = [_detailModel.address stringWithFont:Font_1_F13 andSize:CGSizeMake(SCREEN_WIDTH - orderNoKeyLab.right - originX, 0)];
    UILabel * addressDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(orderNoValueLab.left, infoLab.bottom + 10, SCREEN_WIDTH - infoLab.left - originX, size.height)];
    addressDetailLab.textColor = COLOR_999999;
    addressDetailLab.font = Font_1_F13;
    addressDetailLab.text = _detailModel.address;
    addressDetailLab.numberOfLines = 0;
    [firstBgView addSubview:addressDetailLab];
    
    firstBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, addressDetailLab.bottom + 10);
    self.viewBottom = firstBgView.bottom;
}

#pragma mark - 创建第二个背景view
-(void)creatSecondWhiteBgView
{
    //白色背景
    UIView * secondBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _viewBottom + 10, SCREEN_WIDTH, 200)];
    secondBgView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:secondBgView];
    self.secondBgView =secondBgView;
    
    NSArray * titleList = @[@"支付方式",@"配送方式",@"取货方式",@"发票信息",];
    
    //发票信息
    NSString *invoiceName ;
    if (![_detailModel.invoiceTitle isEmptyString]) {
        invoiceName = [NSString stringWithFormat:@"%@-%@",_detailModel.invoiceTypeName,_detailModel.invoiceTitle];
    }else{
        invoiceName = _detailModel.invoiceTypeName;
    }
    
    NSArray * valueList = @[_detailModel.payName,_detailModel.deliveryModeName,_detailModel.sendGoodsTypeName,invoiceName];
    for (int i=0; i<titleList.count; i++) {
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, i*50, 65, 50)];
        titleLab.textColor = COLOR_333333;
        titleLab.font = Font_1_F15;
        titleLab.text = [titleList objectAtIndex:i];
        titleLab.numberOfLines = 0;
        [secondBgView addSubview:titleLab];
        
        UILabel * valueLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.right + 20, i*50, 100, 50)];
        valueLab.textColor = COLOR_999999;
        valueLab.font = Font_1_F15;
        valueLab.text = [valueList objectAtIndex:i];
        valueLab.numberOfLines = 0;
        [secondBgView addSubview:valueLab];
        
        //灰色线条1
        UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, titleLab.bottom - 0.5, SCREEN_WIDTH, 0.5)];
        lineView1.backgroundColor = COLOR_DDDDDD;
        [secondBgView addSubview:lineView1];
    }
    
    self.viewBottom = secondBgView.bottom;
}

#pragma mark - 创建第三个背景view
-(void)creatThirdWhiteBgView
{
    //白色背景
    UIView * thirdBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _viewBottom + 10, SCREEN_WIDTH, 180)];
    thirdBgView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:thirdBgView];
    
    UIView * lastObj = nil;
    
    for (int i=0; i<_detailModel.productList.count; i++) {
        ProductInfoModel * product = [_detailModel.productList objectAtIndex:i];
        //产品名称
        UILabel * productNameLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, 19, SCREEN_WIDTH - originX*2, 15)];
        productNameLab.font = Font_1_F15;
        productNameLab.textColor = COLOR_333333;
        productNameLab.text = product.name;
        [thirdBgView addSubview:productNameLab];
        if (i!=0) {
            productNameLab.frame = CGRectMake(originX, lastObj.bottom + 20, SCREEN_WIDTH - originX*2, 15);
        }
        
        //黄色线条
        UIView * yellowLine = [[UIView alloc]initWithFrame:CGRectMake(originX, productNameLab.bottom + 10, SCREEN_WIDTH - 20, 0.5)];
        yellowLine.backgroundColor = COLOR_F2B602;
        [thirdBgView addSubview:yellowLine];
        
        //产品规格/型号
        UILabel * typeLab = [[UILabel alloc]initWithFrame:CGRectMake(productNameLab.left, yellowLine.bottom + 10, 120, 15)];
        typeLab.font = Font_1_F13;
        typeLab.textColor = COLOR_999999;
        typeLab.text = @"产品规格/型号";
        [thirdBgView addSubview:typeLab];
        
        //价格
        UILabel * priceLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 10, typeLab.top, 80, typeLab.height)];
        priceLab.font = typeLab.font;
        priceLab.textColor = typeLab.textColor;
        priceLab.text = @"价格";
        [thirdBgView addSubview:priceLab];
        
        //购买数量
        UILabel * buyCountLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 60, typeLab.top, 60, typeLab.height)];
        buyCountLab.font = typeLab.font;
        buyCountLab.textColor = typeLab.textColor;
        buyCountLab.text = @"购买数量";
        buyCountLab.textAlignment = NSTextAlignmentRight;
        [thirdBgView addSubview:buyCountLab];
        
        for (int j=0; j<product.goodsList.count; j++) {
            GoodsModel * goods = [product.goodsList objectAtIndex:j];
            //产品规格/型号
            UILabel * productTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(productNameLab.left, typeLab.bottom + 14 +j*35, 120, typeLab.height)];
            productTypeLab.font = Font_1_F13;
            productTypeLab.textColor = COLOR_333333;
            productTypeLab.text = goods.goodsSpecs;
            [thirdBgView addSubview:productTypeLab];
            
            //价格
            UILabel * procuctPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 10, productTypeLab.top, 80, typeLab.height)];
            procuctPriceLab.font = productTypeLab.font;
            procuctPriceLab.textColor = productTypeLab.textColor;
            procuctPriceLab.text = [NSString stringWithFormat:@"¥%0.2f",goods.dealPrice];
            [thirdBgView addSubview:procuctPriceLab];
            
            //购买数量
            UILabel * countLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 50, productTypeLab.top, 50, typeLab.height)];
            countLab.font = productTypeLab.font;
            countLab.textColor = productTypeLab.textColor;
            countLab.text = [NSString stringWithFormat:@"%ld",goods.quantity];
            countLab.textAlignment = NSTextAlignmentCenter;
            [thirdBgView addSubview:countLab];
            
            //灰色线条
            UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(10, productTypeLab.bottom + 10, SCREEN_WIDTH - 20, 0.5)];
            bottomLine.backgroundColor = COLOR_DDDDDD;
            [thirdBgView addSubview:bottomLine];
            
            lastObj = bottomLine;
        }
    }
    thirdBgView.frame = CGRectMake(0, _viewBottom + 10, SCREEN_WIDTH, lastObj.bottom);
    self.viewBottom = thirdBgView.bottom;
}

#pragma mark - 创建第三个view

- (void)createThirdTableView {
    UITableView *tableView;
    if (self.datas.count >3) {
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewBottom + 10, SCREEN_WIDTH, 125 * (self.datas.count > 3 ? 3 : self.datas.count) + 50) style:UITableViewStyleGrouped];
    }else{
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewBottom + 10, SCREEN_WIDTH, 125 * (self.datas.count > 3 ? 3 : self.datas.count)) style:UITableViewStyleGrouped];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [tableView registerClass:[VProductDetailCell class] forCellReuseIdentifier:NSStringFromClass([VProductDetailCell class])];
    [_scrollView addSubview:tableView];
    self.tableView = tableView;
    
    self.viewBottom = self.tableView.bottom;
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.lookMoreButton.selected == YES) {
        return self.datas.count;
    }else {
        return self.datas.count > 3 ? 3 : self.datas.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return self.datas.count > 3 ? 50 : 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VProductDetailCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view ;
    
    if (self.datas.count > 3) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.lookMoreButton];
    }else{
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.00001)];
    }
    return view;
}

//查看更多
- (void)lookMore:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self.tableView reloadData];
    [self updateLastViews];
}

//点击查看更多按钮 下面view的布局
- (void)updateLastViews {
    self.viewBottom = self.secondBgView.bottom;
    [UIView animateWithDuration:0.3 animations:^{
        if (self.lookMoreButton.selected == YES) {
            self.tableView.frame = CGRectMake(0, self.viewBottom + 10, SCREEN_WIDTH, 125 * self.datas.count + 50);
        }else{
            self.tableView.frame = CGRectMake(0, self.viewBottom + 10, SCREEN_WIDTH, 125 * (self.datas.count > 3 ? 3 : self.datas.count) + 50);
        }
        self.viewBottom = self.tableView.bottom;
        self.fourthBgView.frame = CGRectMake(0, _viewBottom + 10, SCREEN_WIDTH, 50);
        self.viewBottom = self.fourthBgView.bottom;
        self.fifthBgView.frame = CGRectMake(0, self.viewBottom, SCREEN_WIDTH, 40);
        self.viewBottom = self.fifthBgView.bottom;
    }];
}


#pragma mark - 创建第四个背景view
-(void)creatFourthWhiteBgView
{
    //白色背景
    UIView * fourthBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _viewBottom + 10, SCREEN_WIDTH, 50)];
    fourthBgView.backgroundColor = COLOR_FFFFFF;
    [fourthBgView addTapAction:self selector:@selector(showOrderProcess)];
    [_scrollView addSubview:fourthBgView];
    self.fourthBgView = fourthBgView;
    
    //订单跟踪
    UILabel * countLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, 0, 80, 50)];
    countLab.font = Font_1_F15;
    countLab.textColor = COLOR_333333;
    countLab.text = @"订单跟踪";
    [fourthBgView addSubview:countLab];
    
    //箭头
    UIImage * goImg = [UIImage imageNamed:@"youjiantou"];
    UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - goImg.size.width - 18, (50-goImg.size.height)/2, goImg.size.width, goImg.size.height)];
    rightImage.image = goImg;
    [fourthBgView addSubview:rightImage];
    
    self.viewBottom = fourthBgView.bottom;
}

#pragma mark - 创建按钮依据订单状态
-(void)creatButtomWithOrderStatus
{
    UIView *fifthView = [[UIView alloc]initWithFrame:CGRectMake(0, self.viewBottom, SCREEN_WIDTH, 40)];
//    fifthView.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:fifthView];
    self.fifthBgView = fifthView;
    
    if (_detailModel.orderStateAPP <= 2) {
        //剩下时间
        UILabel * alertLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, 10, 80, 15)];
        alertLab.font = Font_1_F12;
        alertLab.textColor = COLOR_666666;
//        [_scrollView addSubview:alertLab];
        [fifthView addSubview:alertLab];
        if (_detailModel.orderStateAPP == OrderStatus_WaitPay) {
            alertLab.text = @"支付剩余时间";
        }else if (_detailModel.orderStateAPP == OrderStatus_WaitExecuse){
            alertLab.text = @"受理剩余时间";
        }
        
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
        //加入主循环池中
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer fire];
        [self timeCountdown];
        
        //倒计时
        _timingLab = [[UILabel alloc]initWithFrame:CGRectMake(alertLab.left, alertLab.bottom, 80, 15)];
        _timingLab.font = Font_1_F12;
        _timingLab.textColor = COLOR_F2B602;
//        [_scrollView addSubview:_timingLab];
        [fifthView addSubview:_timingLab];
    }
    
    //取消订单
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH - 95*2, 10, 85, 30);
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font_1_F18;
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.borderColor = COLOR_F2B602.CGColor;
    [cancelBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:cancelBtn];
    [fifthView addSubview:cancelBtn];
    
    //去支付
    UIButton * payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH - 95, 10, 85, 30);
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    payBtn.titleLabel.font = Font_1_F18;
    payBtn.layer.cornerRadius = 2;
    payBtn.layer.borderWidth = 0.5;
    payBtn.layer.borderColor = COLOR_F2B602.CGColor;
    [payBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:payBtn];
    [fifthView addSubview:payBtn];
    
    //确认收货
    UIButton * sureResiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureResiveBtn.frame = CGRectMake(SCREEN_WIDTH - 95,  10, 85, 30);
    [sureResiveBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    sureResiveBtn.titleLabel.font = Font_1_F18;
    sureResiveBtn.layer.cornerRadius = 2;
    sureResiveBtn.layer.borderWidth = 0.5;
    sureResiveBtn.layer.borderColor = COLOR_F2B602.CGColor;
    [sureResiveBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [sureResiveBtn addTarget:self action:@selector(doSureReceive:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:sureResiveBtn];
    [fifthView addSubview:sureResiveBtn];
    
    //异常订单
    UIButton * unusualOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unusualOrderBtn.frame = CGRectMake(SCREEN_WIDTH - 190,  10, 85, 30);
    [unusualOrderBtn setTitle:@"异常订单" forState:UIControlStateNormal];
    unusualOrderBtn.titleLabel.font = Font_1_F18;
    unusualOrderBtn.layer.cornerRadius = 2;
    unusualOrderBtn.layer.borderWidth = 0.5;
    unusualOrderBtn.layer.borderColor = COLOR_F2B602.CGColor;
    [unusualOrderBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [unusualOrderBtn addTarget:self action:@selector(unusualOrderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:unusualOrderBtn];
    [fifthView addSubview:unusualOrderBtn];
    
    //再次购买
    UIButton * buyAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyAgainBtn.frame = CGRectMake(SCREEN_WIDTH - 95,  10, 85, 30);
    [buyAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    buyAgainBtn.titleLabel.font = Font_1_F18;
    buyAgainBtn.layer.cornerRadius = 2;
    buyAgainBtn.layer.borderWidth = 0.5;
    buyAgainBtn.layer.borderColor = COLOR_F2B602.CGColor;
    [buyAgainBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [buyAgainBtn addTarget:self action:@selector(doBuyAgain:) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:buyAgainBtn];
    [fifthView addSubview:buyAgainBtn];
    
//    self.viewBottom = _viewBottom + 40;
    self.viewBottom = fifthView.bottom;
    
    switch (_detailModel.orderStateAPP) {
        case OrderStatus_WaitPay://待付款
        {
            sureResiveBtn.hidden = YES;
            buyAgainBtn.hidden = YES;
            unusualOrderBtn.hidden = YES;
        }
            break;
        case OrderStatus_WaitExecuse://待受理
        {
            cancelBtn.hidden = YES;
            payBtn.hidden = YES;
            sureResiveBtn.hidden = YES;
            buyAgainBtn.hidden = YES;
            unusualOrderBtn.hidden = YES;
        }
            break;
        case OrderStatus_WaitReceive://待收货
        {
            cancelBtn.hidden = YES;
            payBtn.hidden = YES;
            buyAgainBtn.hidden = YES;
            
            //alreadySend == YES 表示已经发货，不隐藏异常按钮
            //alreadySend == NO 表示未发货，隐藏异常按钮
            if (_detailModel.alreadySend == YES) {
                unusualOrderBtn.hidden = NO;
            }else{
                unusualOrderBtn.hidden = YES;
            }
            
        }
            break;
        case OrderStatus_Finish://已关闭
        {
            cancelBtn.hidden = YES;
            payBtn.hidden = YES;
            sureResiveBtn.hidden = YES;
            unusualOrderBtn.hidden = YES;
        }
            break;
        case OrderStatus_Cancel://已取消
        {
            cancelBtn.hidden = YES;
            payBtn.hidden = YES;
            sureResiveBtn.hidden = YES;
            unusualOrderBtn.hidden = YES;
        }
        case OrderStatus_Unusual://异常订单
        {
            cancelBtn.hidden = YES;
            payBtn.hidden = YES;
            sureResiveBtn.hidden = YES;
            buyAgainBtn.hidden = NO;
            unusualOrderBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 时间倒计时
-(void)timeCountdown
{
    //获取当前时间戳 毫秒
    double nowChuo = [[NSDate millisecondIntervalSince1970] doubleValue];
    
    NSTimeInterval time = [NSDate timeIntervalWithTimeString:_detailModel.orderCeateTimeStr];
    //获取结束时间戳 毫秒
    //待支付 下单后12小时倒计时
    double endChuo = [[NSNumber numberWithDouble:time] longLongValue] + 60*60*12*1000;
    if (_detailModel.orderStateAPP == 2) {
        //待受理 支付后48小时倒计时
        endChuo = [[NSNumber numberWithDouble:time] longLongValue] + 60*60*48*1000;
    }
    
    NSDate * nowDate = [NSDate dateWithTimeIntervalSince1970:nowChuo/1000.f];
    NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:endChuo/1000.f];
    
    NSTimeInterval aTimer = [endDate timeIntervalSinceDate:nowDate];
    NSInteger hour = (aTimer/3600);
    NSInteger minute = (aTimer - hour*3600)/60;
    NSInteger second = aTimer - hour*3600 - minute*60;
    NSString * timing = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute,second];
    _timingLab.text = timing;
}

#pragma mark - 设置高度值
-(void)setViewBottom:(CGFloat)viewBottom
{
    _viewBottom = viewBottom;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, viewBottom + 10);
}

#pragma mark - 查看订单流程
-(void)showOrderProcess
{
    OrderProcessVC * vc = [[OrderProcessVC alloc]init];
    vc.orderTraces = _orderTraces;
    vc.logisticsDic = _detailModel.stepMap;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 支付
-(void)doPay:(UIButton *)sender
{
    CommitOrderVC * vc = [[CommitOrderVC alloc]init];
    vc.mergePaymentId = _detailModel.mergePaymentId;
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
}

#pragma mark - 确认收货
-(void)doSureReceive:(UIButton *)sender
{
    _alertExecute = 1;
    
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"您确定要收货吗？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
}

#pragma mark - 异常订单

- (void)unusualOrderBtnAction:(UIButton *)btn {
    VPopView *popView = [[VPopView alloc]initTitle:@"异常订单申请" certenBlock:^(NSString *content, NSInteger type) {
        ELog(@"%@=====%lu",content,type);
        [self requestOrderWithReason:content reasonId:type];
    }];
    [popView show];
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
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"orderId":[NSNumber numberWithInteger:_detailModel.orderId],
                                    };
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCancelOrderURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showTextHUD:@"取消成功"];
            weakSelf.detailModel.orderStateAPP = OrderStatus_Cancel;
            [weakSelf.view removeAllSubviews];
            [weakSelf creatUI];
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
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
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"orderId":[NSNumber numberWithInteger:_detailModel.orderId],
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetReceiveOrderURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showTextHUD:@"已经确认收货"];
            weakSelf.detailModel.orderStateAPP = OrderStatus_Finish;
            [weakSelf.view removeAllSubviews];
            [weakSelf creatUI];
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
    if (self.datas.count > 1) {
        [self addLotCartNetWorking];//多个加入购物车
    }else{
        [self addSingalCartNetWorking];//单个加入购物车
    }
}

#pragma mark 单个加入购物车加入购物车的方法
-(void)addSingalCartNetWorking
{
    VProductDetailCellModel *model = self.datas[0];
    NSDictionary * parameters = @{@"goodId":model.ident,
                                  @"quantity":model.quantity,
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
-(void)addLotCartNetWorking
{
    
    NSString *goodId = nil;
    NSString * payNumber = nil;
    for (VProductDetailCellModel * model in self.datas) {
        
        //id
        if (goodId) {
            goodId= [NSString stringWithFormat:@"%@,%@",goodId,model.ident];
        }else{
            goodId = [NSString stringWithFormat:@"%@",model.ident];
        }
        
        //数量
        if (payNumber) {
            payNumber= [NSString stringWithFormat:@"%@,%@",payNumber,model.quantity];
        }else{
            payNumber = [NSString stringWithFormat:@"%@",model.quantity];
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


#pragma mark - getter

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (UIButton *)lookMoreButton {
    if (!_lookMoreButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(8, 0, SCREEN_WIDTH-8*2, 40);
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        [button setTitle:@"收起列表" forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"箭头-向下-2"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"箭头-向上"] forState:UIControlStateSelected];
        button.selected = NO;
        [button setTitleColor:[UIColor ylColorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button setBackgroundColor:[UIColor ylColorWithHexString:@"#f7f7f7"]];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor ylColorWithHexString:@"#dddddd"].CGColor;
        [button addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
        _lookMoreButton = button;
    }
    return _lookMoreButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
