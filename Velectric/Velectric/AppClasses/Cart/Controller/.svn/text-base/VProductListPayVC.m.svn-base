//
//  VProductListPayVC.m
//  Velectric
//
//  Created by LYL on 2017/3/3.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VProductListPayVC.h"
#import "CartnilView.h"
#import "CartCell.h"
#import "CartListModel.h"
#import "OrderSettlementVC.h"
#import "CartModel.h"
#import "MJExtension.h"
#import "FactoryViewController.h"
#import "BrandsModel.h"
#import "DetailsViewController.h"

@interface VProductListPayVC ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    NSMutableArray * dataArray;//数据源
    NSArray * listArray;//存放basketIds  的数组
}

@property (nonatomic,strong)UITableView * tableView;//列表

@property (nonatomic,strong)UIView * aView; // section的内容
@property(nonatomic,strong)UIBarButtonItem * rightBotton;//nav 右侧的btn
@property(nonatomic,assign)BOOL isSelect;//btn 是否选中
@property (nonatomic,strong)CartnilView * cartnil;//购物篮为空时的界面
@property (nonatomic,strong)UIButton * goPayBtn;
@property (nonatomic,strong)UIButton * rightBtn;

@property (nonatomic,strong)UIButton * sectionBtn;//每个分区的btn
@property (nonatomic, copy)NSString * flag;//sectionBtn的显示
@property (nonatomic,strong)UIButton * bottomBtn;//底部全选的btn
@property (nonatomic, copy)NSString * flagBottom;//底部Btn的显示标示
@property (nonatomic,strong)UILabel * hejiLable;//底部合计的lable


@end

@implementation VProductListPayVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self loadUpdata];
    [MobClick beginLogPageView:self.navTitle];
    [self.goPayBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.cartnil.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView headerBeginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//RGBColor(247,247, 247);
    dataArray = [NSMutableArray array];
    listArray = [NSMutableArray array];
    //初始化界面
    [self initUI];
//    //判断是否是第一次进入购物车
//    BOOL loadApp = [[NSUserDefaults standardUserDefaults]boolForKey:@"FIRST_CART"];
//    if (!loadApp) {
//        //购物车蒙层提示
//        [self mengCengUI];
//    }
}
#pragma mark 请求购物车数据
-(void)loadUpdata
{
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [dataArray removeAllObjects];//清除原有的数据
        //品牌-数据
        NSDictionary * baskets = responseObject[@"cart"][@"baskets"];
        NSArray * brands = [baskets allKeys];
        listArray = brands;
        for (NSString * brandsName in brands) {
            //品牌信息
            NSDictionary * brandsInfo = [baskets objectForKey:brandsName];
            CartListModel * cListModel = [[CartListModel alloc]init];
            [cListModel setValuesForKeysWithDictionary:brandsInfo];
            [dataArray addObject:cListModel];
        }
        if (dataArray.count) {
            self.cartnil.hidden = YES;
        }else{
//            NSArray *array = self.navigationController.childViewControllers;
//            UIViewController *controller = array[array.count - 3];
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSInteger childRoonInt = 0;
        for (CartListModel * listModel in dataArray) {
            childRoonInt =childRoonInt+ listModel.cartList.count;
        }
        //0.05*SCREEN_HEIGHT*dataArray.count+0.22*SCREEN_HEIGHT*childRoonInt
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        
        self.block(dataArray);
        
    } failure:^(NSError *error) {
        ELog(@"失败");
        [_tableView headerEndRefreshing];
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}


#pragma mark  处理遮罩的单击事件
-(void)handleSingleFingerEvent{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"FIRST_CART"];
    [self.aView removeFromSuperview];
}

#pragma mark 初始化UI界面的方法
-(void)initUI
{
    //    设置nav
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    titleLable.text = @"商品清单";
    titleLable.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLable;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 50);
    tableView.separatorColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.tableView addHeaderWithTarget:self action:@selector(loadUpdata)];
    [self.view addSubview:tableView];
    [self.tableView headerBeginRefreshing];
    
    CartnilView * cartnil = [[[NSBundle mainBundle]loadNibNamed:@"CartnilView" owner:self options:nil] lastObject];
    cartnil.userInteractionEnabled = YES;
    [cartnil.goIGuangGuangBtn addTarget:self action:@selector(bianJiBtn:) forControlEvents:UIControlEventTouchUpInside];
    cartnil.goIGuangGuangBtn.tag = 10001;//去逛逛
    self.cartnil = cartnil;
    cartnil.hidden = YES;
//    [self.view addSubview:cartnil];
    
    //--------yulei------------------
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_HEIGHT, 50)];
    bottomView.backgroundColor = [UIColor ylColorWithHexString:@"#666666"];
    [self.view addSubview:bottomView];
    
    CGFloat labelWidth = 80;
    UILabel *totalMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, SCREEN_HEIGHT-64-50, labelWidth, 50)];
    totalMoneyLabel.text = @"实付金额";
    totalMoneyLabel.backgroundColor = COLOR_666666;
    totalMoneyLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:totalMoneyLabel];
    
    UILabel *totalMoneyValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelWidth + 5 , SCREEN_HEIGHT-64-50, 200 , 50)];
    totalMoneyValueLabel.backgroundColor = COLOR_666666;
    totalMoneyValueLabel.textColor = V_ORANGE_COLOR;
    [self.view addSubview:totalMoneyValueLabel];
    self.hejiLable = totalMoneyValueLabel;
    
    
    UIButton * goPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-64-50, 100, 50)];
    [goPayBtn setTitle:@"确定" forState:UIControlStateNormal];
    [goPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goPayBtn.backgroundColor = COLOR_F2B602;
    [goPayBtn addTarget:self action:@selector(bianJiBtn:) forControlEvents:UIControlEventTouchUpInside];
    goPayBtn.titleLabel.font = Font_1_F19;
    [self.view addSubview:goPayBtn];
    
    
}
#pragma mark 编辑的button 的方法
-(void)bianJiBtn:(UIButton *)btn
{
    if ([@"编辑" isEqualToString:btn.titleLabel.text]) {
        ELog(@"编辑");
        [self.goPayBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.tableView reloadData];
        
    }else if ([@"确定" isEqualToString:btn.titleLabel.text]){
        ELog(@"确定");
        [self goPayNetWorking];
//        [self popPayViewCon];
    }else if (btn.tag == 10001){
        ELog(@"去逛逛");
        self.tabBarController.selectedIndex =0;
    }else if ([@"删除" isEqualToString:btn.titleLabel.text]){
        [self doLoginOut];
    }else if ([@"完成" isEqualToString:btn.titleLabel.text]){
        ELog(@"完成");
        [self.goPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
}


#pragma mark 批量删除的网络请求

-(void)deleteNetWorking
{
    NSString * basketIdArr = nil;
    NSString * goodsIdStr = nil;
    NSString * items = nil;
    NSString *basketId=nil;
    NSMutableArray * arr = [NSMutableArray array];
    
    NSMutableArray * productListArr1 = [NSMutableArray arrayWithArray:dataArray];
    for (int i=0; i<productListArr1.count; i++) {//循环出要传的model
        CartListModel * cartListModel = productListArr1[i];
        
        for (int j=0; j<cartListModel.cartList.count; j++){
            CartModel * cartModel = cartListModel.cartList[j];
            if (!cartModel.selected) {
                // [cartListModel.cartList removeObject:cartModel];
                if (cartListModel.cartList.count==0) {
                    [productListArr1 removeObject:cartListModel];
                }
            }else{
                if (goodsIdStr) {
                    goodsIdStr = [NSString stringWithFormat:@"%@,%ld",goodsIdStr,(long)cartModel.goodsId];
                }else{
                    goodsIdStr = [NSString stringWithFormat:@"%ld",(long)cartModel.goodsId];
                }
                if (items) {
                    items = [NSString stringWithFormat:@"%@,%@",items,cartModel.itemId];
                }else{
                    items = [NSString stringWithFormat:@"%@",cartModel.itemId];
                }
                
            }
            
        }
        basketId = [NSString stringWithFormat:@"%@#%@#%@",goodsIdStr,items,cartListModel.basketId];
        [arr addObject:basketId];
        
    }
    
    for (NSString * basketId in arr) {
        if (basketIdArr) {
            basketIdArr = [NSString stringWithFormat:@"%@-%@",basketId,basketIdArr];
        }else{
            basketIdArr = [NSString stringWithFormat:@"%@",basketId];
        }
    }
    
    if (!basketIdArr) {
        [VJDProgressHUD showTextHUD:@"请选择删除的商品"];
        return;
    }
    
    [VJDProgressHUD  showProgressHUD:nil];
    NSDictionary * parameters = @{@"basketIdArr":basketIdArr,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetDeleteSelectedURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        if ([@"RS200" isEqualToString:responseObject[@"code"]]) {
            [VJDProgressHUD showSuccessHUD:@"删除成功"];
        }
        [self loadUpdata];
        
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
    
}
#pragma mark 去支付的网络请求
-(void)goPayNetWorking
{
    NSString *goodsIdStr =nil;
    NSString *quantitys =nil;
    NSString *selected = nil;
    NSString * basketIds =nil;
    NSString * remark =nil;
    BOOL SelectStaute=NO;
    NSMutableArray * productListArr = [NSMutableArray arrayWithArray:dataArray];
    for (CartListModel * cartListModel in productListArr) {//循环获取goodsIdStr，selected
        for (CartModel * cartModel in cartListModel.cartList) {
            if (!cartModel.selected) {
                if (!selected) {
                    selected = @"0";
                }else{
                    selected = [NSString stringWithFormat:@"%@,0",selected];
                }
            }else{
                SelectStaute =YES;
                if (!selected) {
                    selected = @"1";
                }else{
                    selected = [NSString stringWithFormat:@"%@,1",selected];
                }
            }
            //商品数量
            if (quantitys) {
                quantitys = [NSString stringWithFormat:@"%@,%lu",quantitys,cartModel.quantity];
            }else{
                quantitys = [NSString stringWithFormat:@"%lu",cartModel.quantity];
            }
            
            //商品id
            if (goodsIdStr) {
                goodsIdStr = [NSString stringWithFormat:@"%@,%lu",goodsIdStr,cartModel.goodsId];
            }else{
                goodsIdStr = [NSString stringWithFormat:@"%lu",cartModel.goodsId];
            }
        }
        //购物篮id
        if (basketIds) {
            basketIds = [NSString stringWithFormat:@"%@,%@",basketIds,cartListModel.basketId];
        }else{
            basketIds = cartListModel.basketId;
        }
    }
    
    NSMutableArray * productListArr1 = [NSMutableArray arrayWithArray:dataArray];
    for (int i=0; i<productListArr1.count; i++) {//循环出要传的model
        CartListModel * cartListModel = productListArr1[i];
        for (CartModel * cartModel in cartListModel.cartList){
            if (!cartModel.selected) {
                [cartListModel.cartList removeObject:cartModel];
                if (cartListModel.cartList.count==0) {
                    [productListArr1 removeObject:cartListModel];
                }
            }
        }
    }
    
    
    
    for (NSString * basketIdStr in listArray) {
        
        if (remark) {
            remark = [NSString stringWithFormat:@"%@,1",remark];
            
        }else{
            remark=@"1";
        }
    
    }
    
    [VJDProgressHUD  showProgressHUD:@"请求中..."];
//    if (!goodsIdStr||!basketIds||!quantitys||!selected||!remark) {
//        [VJDProgressHUD showTextHUD:@"您还未选择商品"];
//        return;
//    }
    NSDictionary * parameters = @{@"basketIds":basketIds ? basketIds : @"",//购物篮ID
                                  @"goodsIdStr":goodsIdStr ? goodsIdStr : @"",//商品ID
                                  @"quantitys":quantitys ? quantitys : @"",//商品数量
                                  @"selected":selected ? selected :@"",
                                  @"remark":remark ? remark : @"",
                                  @"loginName":GET_USER_INFO.loginName,
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetAddAllGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        [VJDProgressHUD dismissHUD];
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            if (SelectStaute) {
                //更新购物车数据
                [self updateCartData];
            }else{
                [VJDProgressHUD showTextHUD:@"您还未选择商品"];
                return ;
            }
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

//请求购物车数据，和上面的请求是一个，但是这个请求成功之后要返回上个界面。
-(void)updateCartData
{
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [dataArray removeAllObjects];//清除原有的数据
        //品牌-数据
        NSDictionary * baskets = responseObject[@"cart"][@"baskets"];
        NSArray * brands = [baskets allKeys];
        listArray = brands;
        for (NSString * brandsName in brands) {
            //品牌信息
            NSDictionary * brandsInfo = [baskets objectForKey:brandsName];
            CartListModel * cListModel = [[CartListModel alloc]init];
            [cListModel setValuesForKeysWithDictionary:brandsInfo];
            [dataArray addObject:cListModel];
        }
//        if (dataArray.count) {
//            self.cartnil.hidden = YES;
//        }else{
//            self.cartnil.hidden = NO;
//        }
        NSInteger childRoonInt = 0;
        for (CartListModel * listModel in dataArray) {
            childRoonInt =childRoonInt+ listModel.cartList.count;
        }
        //0.05*SCREEN_HEIGHT*dataArray.count+0.22*SCREEN_HEIGHT*childRoonInt
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        
        self.block(dataArray);
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        ELog(@"失败");
        [_tableView headerEndRefreshing];
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark 创建蒙层
-(void)mengCengUI
{
    UIView * aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.aView = aView;
    aView.backgroundColor = [UIColor blackColor];
    aView.alpha = 0.7;
    aView.userInteractionEnabled = YES;
    [self.view addSubview:aView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:aView.frame];
    imageView.image = [UIImage imageNamed:@"tishiceng"];
    [aView addSubview:imageView];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.aView addGestureRecognizer:singleFingerOne];
}

#pragma  UITableView  的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{   [self forInDataArray:dataArray];//此方法判定底部bootom 的现实状态
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CartListModel * model = [dataArray objectAtIndex:section];
    return model.cartList.count;
    
}

#pragma mark cellForRow 方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * identifier = @"cell";
    CartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CartCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//不可被点击
    PPNumberButton * numberBtn = [PPNumberButton numberButtonWithFrame:CGRectZero];
    //CGRectMake(5, 0, 100, 30)];
    //默认可以编辑数字
    numberBtn.isCanEdit = YES;

    numberBtn.increaseTitle = @"";
    numberBtn.decreaseTitle = @"";
    numberBtn.inputFieldFont = 15;
    numberBtn.increaseImage = [UIImage imageNamed:@"jiaShen"];
    numberBtn.decreaseImage = [UIImage imageNamed:@"jianShen"];
    
    CartListModel * model = [dataArray objectAtIndex:indexPath.section];
    CartModel * cartModel = [model.cartList objectAtIndex:indexPath.row];
    numberBtn.minValue =[cartModel.minQdl integerValue]; //设置最小起订量
    numberBtn.resultBlock = ^(NSString *num){
        cartModel.quantity = [num integerValue];
        [self.tableView reloadData];
    };
    cell.numberView.userInteractionEnabled = YES;
    if (cartModel.selected) {
        cell.xuanBtn.selected = YES;
        [cell.xuanBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    }else{
        cell.xuanBtn.selected = NO;
        [cell.xuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }
    //cell.xuanBtn.tag = indexPath.row+10000*(indexPath.section +1);
    cell.xuanBtn.tag = indexPath.section*10000+indexPath.row;
    [cell.xuanBtn addTarget:self action:@selector(cellBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.numberView addSubview:numberBtn];
    [numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.numberView.mas_top);
        make.right.equalTo(cell.numberView.mas_right);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    [cell.cartimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestApiPictureURL_Test,cartModel.picUrl]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.infoLable.text =cartModel.goodsName;
    cell.cartimageView.userInteractionEnabled = YES;
    cell.moneyLable.text =[NSString stringWithFormat:@"¥ %@",cartModel.excutePrice
                           ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    //    cell.xuanBtn.userInteractionEnabled = NO;
    numberBtn.currentNumber =[NSString stringWithFormat:@"%ld",cartModel.quantity];
    
    //-------------
    cell.xuanBtn.hidden = YES;
    //-------------
    return cell;
}
#pragma mark didselect 选中的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CartListModel * model = [dataArray objectAtIndex:indexPath.section];
//    CartModel * cartModel = [model.cartList objectAtIndex:indexPath.row];
//    
//    DetailsViewController * detail = [[DetailsViewController alloc]init];
//    detail.name = cartModel.goodsName;
//    detail.iD =cartModel.productId;
//    detail.type = @"";
//    [self.navigationController pushViewController:detail animated:YES];
    
    //    UIButton * xuanBtn = [self.view viewWithTag:indexPath.row+10000*(indexPath.section +1)];
    //    if (cartModel.selected) {
    //        cartModel.selected = NO;
    //        [xuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    //    }else{
    //        cartModel.selected = YES;
    //        [xuanBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    //    }
    //    [self.tableView reloadData];
}

#pragma mark cellBtn 的点击方法
-(void)cellBtn:(UIButton *)btn
{
    NSInteger section = btn.tag/10000;
    NSInteger row = btn.tag%10000;
    CartListModel * model = [dataArray objectAtIndex:section];
    CartModel * cartModel = [model.cartList objectAtIndex:row];
    if (cartModel.selected) {
        cartModel.selected = NO;
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }else{
        cartModel.selected = YES;
        [btn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}
#pragma mark 每行行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.22*SCREEN_HEIGHT;
    
}

#pragma mark 设置可以编辑的状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}
#pragma mark 点击删除的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self danNetwokingIndexPath:indexPath];
    }
}
#pragma mark 单个删除的网络请求
-(void)danNetwokingIndexPath:(NSIndexPath *)indexPath
{
    NSString * goodsIdStr = nil;
    
    CartListModel * model = dataArray[indexPath.section];
    CartModel * cartModel = model.cartList[indexPath.row];
    goodsIdStr = [NSString stringWithFormat:@"%ld",cartModel.goodsId];
    [VJDProgressHUD  showProgressHUD:nil];
    NSDictionary * parameters = @{@"basketId":model.basketId,
                                  @"goodId":goodsIdStr,
                                  @"itemId":cartModel.itemId,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetDeleteURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [self loadUpdata];
        [VJDProgressHUD showSuccessHUD:nil];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

#pragma mark 滑动后删除的形式
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
#pragma mark HeaderInSection 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.05*SCREEN_HEIGHT;
}

#pragma mark HeaderInSection 的方法
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    aview.backgroundColor =RGBColor(247, 247, 247);
    UILabel * aLable = [[UILabel alloc]initWithFrame:CGRectMake(30, aview.top, SCREEN_WIDTH-60, 35)];
    CartListModel * listModel = [dataArray objectAtIndex:section];
    aLable.text = listModel.brandsName;
    [aview addSubview:aLable];
    UIButton * xuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, aview.centerY-5, 15, 15)];
//    [aview addSubview:xuanBtn];
    
    [xuanBtn addTarget:self action:@selector(xuanBtnSection:) forControlEvents:UIControlEventTouchUpInside];
    xuanBtn.tag = section +150;
    UIButton * Btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(aLable.frame), aview.centerY-5, 15, 15)];
    
    for (CartModel * model in listModel.cartList) {
        if (!model.selected) {
            _flag = @"1";
            break;
        }else{
            _flag=nil;
        }
    }
    if (_flag) {
        [xuanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        xuanBtn.selected = NO;
    }else{
        [xuanBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        xuanBtn.selected = YES;
    }
    Btn.tag = section+500;
    [Btn setImage:[UIImage imageNamed:@"youjiantou"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(goBrand:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:Btn];
    return aview;
}
#pragma mark   section 右侧尖头的点击事件
-(void)goBrand:(UIButton *)btn
{
    CartListModel * listModel = dataArray[btn.tag-500];
    FactoryViewController * factory = [[FactoryViewController alloc]init];
    BrandsModel * model = [[BrandsModel alloc]init];
    model.name = listModel.brandsName;
    model.Id =[NSNumber numberWithInt:0];
    factory.cartFlog =@"cart";
    factory.type =@"1";
    factory.brandsModel = model;
    [self.navigationController pushViewController:factory animated:YES];
    
    
}
#pragma mark   每个分区btn 的选中状态
-(void)xuanBtnSection:(UIButton *)btn
{
    ELog(@"section 选中");
    CartListModel * listModel = dataArray[btn.tag-150];
    if (btn.selected) {
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        for (CartModel * cartModel in listModel.cartList) {
            cartModel.selected = NO;
        }
        
    }else{
        btn.selected =YES;
        [btn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        for (CartModel * cartModel in listModel.cartList) {
            cartModel.selected = YES;
        }
    }
    [self.tableView reloadData];
}

#pragma mark 每次都循环用来获取底部全选的状态
-(void)forInDataArray:(NSArray *)dataAr
{
    //底部btn的显示
    for (CartListModel *cartListModel in dataAr) {
        for (CartModel * cartModel in cartListModel.cartList) {
            if (!cartModel.selected) {
                _flagBottom = @"1";
                break;
            }else{
                _flagBottom =nil;
            }
        }
        if (!_flagBottom) {
            [self.bottomBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        }else{
        }
    }
    if (dataAr.count==0) {
        [self.bottomBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }
    
    //底部合计的现实
    
    //底部btn的显示
    CGFloat allPice = 0.0;
    for (CartListModel *cartListModel in dataAr) {
        for (CartModel * cartModel in cartListModel.cartList) {
            if (cartModel.selected) {
                allPice = allPice +cartModel.quantity * [cartModel.excutePrice floatValue];
            }
        }
    }
    self.hejiLable.font = [UIFont systemFontOfSize:16];
    self.hejiLable.text = [NSString stringWithFormat:@"%.2lf",allPice];
}

#pragma mark - 提示删除
-(void)doLoginOut
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:@"你确定要删除吗？"
                                                     otherButtonTitles:@"确定",nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

#pragma mark UIActionSheetDelegate 删除时给出提示
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //批量删除的方法
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1) {
        [self deleteNetWorking];
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
