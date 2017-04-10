//
//  ScreeningView.m
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ScreeningView.h"
#import "ScreeningViewCell.h"
#import "ScreeningCategoryView.h"
#import "HomeCategoryModel.h"
#import "SkuPropertyModel.h"
#import "BrandsModel.h"
#import "ScreenView.h"

static int brandMoreBtnTag = 20170317;//品牌查看更多按钮tag，防止更新时被移除

@interface ScreeningView ()

@property (nonatomic, strong) UIButton * moreBrandBtn;//品牌下拉按钮

@end

@implementation ScreeningView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_333333_A(0.6);
        _alphaWidth = SCREEN_WIDTH*(5.0/32.0);
        _brandsList = [NSMutableArray array];
        _selectBrandsList = [NSMutableArray array];
        
        //创建 顶部view
        [self creatTopView];
        //创建 tableview
        [self creatTableView];
        //创建 table header
        [self creatTableHeader];
        //创建 底部view
        [self creatBottomView];
        // 是否显示品牌
        //[self enterType:self.enterType];
    }
    return self;
}

-(void)enterType:(ScreeningViewEnterType)enterType
{
    _enterType = enterType;
    switch (_enterType) {
        case ScreeningViewEnterType5:
        case ScreeningViewEnterType9:
        {
            //请求 品牌spu
            [self requestBrandCategory];
            //请求 sku属性
            [self requestCategorySchemaList];
        }
            break;
        case ScreeningViewEnterType6:
        case ScreeningViewEnterType10:
        {
            //无分类，显示品牌
            _categoryView.hidden = YES;
            _brandsView.frame = CGRectMake(0, 0, _headerView.width, _brandsView.height);
            _priceView.frame = CGRectMake(0, 50, _headerView.width, _priceView.height);
            //请求 品牌spu
            [self requestBrandCategory];
            //请求 sku属性
            [self requestCategorySchemaList];
        }
            break;
        case ScreeningViewEnterType1:
        case ScreeningViewEnterType2:
        case ScreeningViewEnterType3:
        case ScreeningViewEnterType4:
        case ScreeningViewEnterType7:
        case ScreeningViewEnterType8:
        {
            //有分类，不显示品牌
            _brandsView.hidden = YES;
            _priceView.frame = CGRectMake(0, _categoryView.bottom + 10, _headerView.width, _priceView.height);
        }
            break;
        default:
            break;
    }
}

#pragma mark - 创建 顶部view
-(void)creatTopView
{
    UIView * topBackView = [[UIView alloc]initWithFrame:CGRectMake(_alphaWidth, 20, SCREEN_WIDTH - _alphaWidth, 44)];
    topBackView.backgroundColor = COLOR_333333;
    [self addSubview:topBackView];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 44)];
    UIImage * backImage = [UIImage imageNamed:@"back2"];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [topBackView addSubview:backBtn];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake((topBackView.width - 60)/2, 0, 60, 44)];
    titleLab.text = @"筛选";
    titleLab.font = Font_1_F17;
    titleLab.textColor = COLOR_FFFFFF;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:titleLab];
}

#pragma mark - 创建 tableview
-(void)creatTableView
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(_alphaWidth, 64, SCREEN_WIDTH - _alphaWidth, SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_F7F7F7;
    [self addSubview:_tableView];
}

#pragma mark - 创建 table header
-(void)creatTableHeader
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 200)];
    [_tableView setTableHeaderView:_headerView];
    
    /************* 分类 *************/
    _categoryView = [[UIView alloc]init];
    _categoryView.frame = CGRectMake(0, 0, _tableView.width, 40);
    _categoryView.backgroundColor = COLOR_FFFFFF;
    [_categoryView addTapAction:self selector:@selector(doChooseCategory)];
    [_headerView addSubview:_categoryView];
    
    //分类
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, _categoryView.height)];
    titleLab.text = @"分类";
    titleLab.font = Font_1_F17;
    titleLab.textColor = COLOR_666666;
    [_categoryView addSubview:titleLab];
    
    //箭头
    UIImage * image = [UIImage imageNamed:@"chooseyou"];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headerView.width - 10 - image.size.width, (_categoryView.height - image.size.height)/2, image.size.width, image.size.height)];
    imageView.image = image;
    [_categoryView addSubview:imageView];
    
    //选择
    _categoryValueLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, imageView.left - 70, _categoryView.height)];
    _categoryValueLab.text = @"选择";
    _categoryValueLab.font = Font_1_F14;
    _categoryValueLab.textColor = COLOR_333333;
    _categoryValueLab.textAlignment = NSTextAlignmentRight;
    [_categoryView addSubview:_categoryValueLab];
    
    /************* 品牌 *************/
    _brandsView = [[UIView alloc]init];
    _brandsView.frame = CGRectMake(0, 0, _headerView.width, 40);
    if (_enterType != ScreeningViewEnterType4) {
        _brandsView.frame = CGRectMake(0, _categoryView.bottom + 10, _headerView.width, 40);
    }
    _brandsView.backgroundColor = COLOR_FFFFFF;
    _brandsView.clipsToBounds = YES;
    [_headerView addSubview:_brandsView];
    
    UILabel * brandLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    brandLab.text = @"品牌";
    brandLab.font = Font_1_F17;
    brandLab.textColor = COLOR_666666;
    [_brandsView addSubview:brandLab];
    
    //品牌下拉按钮
    UIButton * moreBrandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBrandBtn.selected = NO;
    moreBrandBtn.hidden = YES;
    moreBrandBtn.frame = CGRectMake(_brandsView.width-70, 0, 70, 40);
    [moreBrandBtn setTitle:@"全部" forState:UIControlStateNormal];
    moreBrandBtn.titleLabel.font = Font_1_F14;
    [moreBrandBtn setImage:[UIImage imageNamed:@"choosexia"] forState:UIControlStateNormal];
    [moreBrandBtn setImage:[UIImage imageNamed:@"chooseshang"] forState:UIControlStateSelected];
    [moreBrandBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [moreBrandBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [_brandsView addSubview:moreBrandBtn];
    [moreBrandBtn addTarget:self action:@selector(brandMoreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.moreBrandBtn = moreBrandBtn;
    
    /************* 价格区间 *************/
    _priceView = [[UIView alloc]init];
    _priceView.frame = CGRectMake(0, _brandsView.bottom + 10, _headerView.width, 80);
    _priceView.backgroundColor = COLOR_FFFFFF;
    [_headerView addSubview:_priceView];
    
    //价格区间
    UILabel * priceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 20)];
    priceLab.text = @"价格区间";
    priceLab.font = Font_1_F17;
    priceLab.textColor = COLOR_666666;
    [_priceView addSubview:priceLab];
    
    CGFloat textFwidth = (_headerView.width - 20 - 50)/2;
    
    //最低价
    _lowPriceTextF = [[UITextField alloc]initWithFrame:CGRectMake(10, priceLab.bottom + 10, textFwidth, 30)];
    _lowPriceTextF.placeholder = @"最低价";
    _lowPriceTextF.font = Font_1_F14;
    _lowPriceTextF.textAlignment = NSTextAlignmentCenter;
    _lowPriceTextF.keyboardType = UIKeyboardTypeNumberPad;
    _lowPriceTextF.backgroundColor = COLOR_F7F7F7;
    _lowPriceTextF.delegate = self;
    [_priceView addSubview:_lowPriceTextF];
    
    //最高价
    _highPriceTextF = [[UITextField alloc]initWithFrame:CGRectMake(_priceView.width - textFwidth - 10, priceLab.bottom + 10, textFwidth, 30)];
    _highPriceTextF.placeholder = @"最高价";
    _highPriceTextF.font = Font_1_F14;
    _highPriceTextF.textAlignment = NSTextAlignmentCenter;
    _highPriceTextF.keyboardType = UIKeyboardTypeNumberPad;
    _highPriceTextF.backgroundColor = COLOR_F7F7F7;
    _highPriceTextF.delegate = self;
    [_priceView addSubview:_highPriceTextF];
    
    //横线
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake((_headerView.width - 25)/2, _lowPriceTextF.top + 14, 25, 1.5)];
    line.backgroundColor = COLOR_666666;
    [_priceView addSubview:line];
    
    _headerView.frame = CGRectMake(0, 0, _tableView.width, _priceView.bottom);
}

#pragma mark - 选择 分类
-(void)doChooseCategory
{
    ScreeningCategoryView * view = [[ScreeningCategoryView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, _tableView.width, SCREEN_HEIGHT)];
    view.categoryId = _categoryId;
    view.fromFactoryFlage = self.fromFactoryFlage;
    view.type = self.type;
    view.brandName = self.brandName;
    [self addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = CGRectMake(_tableView.left, 0, _tableView.width, SCREEN_HEIGHT);
    }];
    switch (_enterType) {
        case ScreeningViewEnterType1:
            view.showType = DataShow_twoLevel;
            break;
        case ScreeningViewEnterType2:
        case ScreeningViewEnterType4:
            view.showType = DataShow_threeLevel;
            break;
        case ScreeningViewEnterType3:
        case ScreeningViewEnterType5:
        case ScreeningViewEnterType7:
        case ScreeningViewEnterType8:
        case ScreeningViewEnterType9:
            view.showType = DataShow_oneLevel;
            break;
        default:
            break;
    }
    VJDWeakSelf;
    view.chooseCategoryFinishBlcok = ^(HomeCategoryModel * model){
        weakSelf.selectCategoryModel = model;
        weakSelf.categoryValueLab.text = model.name;
        weakSelf.categoryValueLab.textColor = COLOR_F2B602;
        //请求 品牌
        [weakSelf requestBrandCategory];
        //请求 sku属性
        [weakSelf requestCategorySchemaList];

    };
}

#pragma mark - 请求 品牌
-(void)requestBrandCategory
{
    NSDictionary * params = @{@"categoryId":[NSNumber numberWithInteger:_categoryId],  //分类id
                              };
    NSMutableDictionary * muParams = [[NSMutableDictionary alloc]initWithDictionary:params];
    if (_selectCategoryModel) {
        [muParams setValue:[NSNumber numberWithInteger:_selectCategoryModel.myId] forKey:@"categoryId"];
    }
    VJDWeakSelf;
 //   [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetBrandCategoryURL parameters:muParams success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
         //   [VJDProgressHUD showSuccessHUD:nil];
            [weakSelf.selectBrandsList removeAllObjects];
            [weakSelf.brandsList removeAllObjects];
            NSArray * brandsList = [responseObject objectForKey:@"brandsList"];
            if (brandsList.count>0) {
                for (NSDictionary * dic in brandsList) {
                    BrandsModel * model = [[BrandsModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.brandsList addObject:model];
                }
                weakSelf.brandsView.hidden = NO;
                //重载 品牌view
                [weakSelf reloadBrandsView];
            }else{
                //无数据 隐藏
                _brandsView.hidden = YES;
                _priceView.frame = CGRectMake(0, _categoryView.bottom + 10, _headerView.width, _priceView.height);
            }
            
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 请求 sku属性
-(void)requestCategorySchemaList
{
    NSDictionary * params = @{@"categoryId":[NSNumber numberWithInteger:_categoryId],}; //114005
    NSMutableDictionary * muParams = [[NSMutableDictionary alloc]initWithDictionary:params];
    if (_selectCategoryModel) {
        [muParams setValue:[NSNumber numberWithInteger:_selectCategoryModel.myId] forKey:@"categoryId"];
    }
    VJDWeakSelf;
   // [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCategorySchemaListURL parameters:muParams success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            //[VJDProgressHUD showSuccessHUD:nil];
            //移除旧数据
            [weakSelf.tableView.dataArray removeAllObjects];
            
            NSArray * categoryExtendedAttribute = [responseObject objectForKey:@"categoryExtendedAttribute"];
            for (NSDictionary * dic in categoryExtendedAttribute) {
                SkuPropertyModel * model = [[SkuPropertyModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                model.normalHeight = 90;
                [weakSelf.tableView.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 重载 品牌view
-(void)reloadBrandsView
{
    //移除旧的按钮
    for (UIView * obj in _brandsView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            if (obj == self.moreBrandBtn) {//如果是品牌查看更多按钮，则跳过
                break;
            }
            [obj removeFromSuperview];
        }
    }
    
    //--------------yulei代码begin------------
    //数量少于三个显示一行，超过三个显示两行，超过六个最后一个显示“全部品牌”
    if (_brandsList.count>3) {
        self.moreBrandBtn.hidden = NO;
        if (self.moreBrandBtn.selected == YES) {
            _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 120);
        }else{
            _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 80);
        }
    }else{
        self.moreBrandBtn.hidden = YES;
    }
    
    _priceView.frame = CGRectMake(0, _brandsView.bottom + 10, _priceView.width, _priceView.height);
    _headerView.frame = CGRectMake(0, 0, _tableView.width, _priceView.bottom);
    //--------------yulei代码end------------
    
    //----------------------之前代码begin-------------------
    //数量少于三个显示一行，超过三个显示两行，超过六个最后一个显示“全部品牌”
//    if (_brandsList.count>3) {
//        _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 120);
//    }else{
//        _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 80);
//    }
//    _priceView.frame = CGRectMake(0, _brandsView.bottom + 10, _priceView.width, _priceView.height);
//    _headerView.frame = CGRectMake(0, 0, _tableView.width, _priceView.bottom);
    
    //----------------------之前代码end-------------------
    
    CGFloat btnWidth = (_headerView.width - 60)/3;
    
    //添加按钮
    for (int i=0; i<_brandsList.count; i++) {
        BrandsModel * model = [_brandsList objectAtIndex:i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(15+(i%3)*(btnWidth + 15), 40 + 40*(i/3), btnWidth, 30)];
        [_brandsView addSubview:button];
        [button setTitle:model.brandName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseBrands:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = Font_1_F13;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 2;
        button.tag = i;
        if (model.isSelect) {
            button.backgroundColor = CLEAR_COLOR;
            button.layer.borderColor = COLOR_F2B602.CGColor;
            [button setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            button.backgroundColor = COLOR_F7F7F7;
            button.layer.borderColor = CLEAR_COLOR.CGColor;
            [button setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        }
        if (i==5) {
            [button setTitle:@"全部品牌>" forState:UIControlStateNormal];
            button.backgroundColor = COLOR_F7F7F7;
            button.layer.borderColor = CLEAR_COLOR.CGColor;
            [button setTitleColor:COLOR_999999 forState:UIControlStateNormal];
            break;
        }
        
    }
}

#pragma mark - 品牌点击全部按钮

- (void)brandMoreBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.moreBrandBtn.selected == YES) {
        _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 120);
    }else{
        _brandsView.frame = CGRectMake(0, _brandsView.top, _brandsView.width, 80);
    }
    _priceView.frame = CGRectMake(0, _brandsView.bottom + 10, _priceView.width, _priceView.height);
    _headerView.frame = CGRectMake(0, 0, _tableView.width, _priceView.bottom);
    [self.tableView reloadData];
}

#pragma mark - 选择品牌
-(void)chooseBrands:(UIButton *)sender
{
    //全部品牌，弹出品牌界面
    if (sender.tag == 5) {
        NSMutableArray * muList = [NSMutableArray array];
        for (BrandsModel * model in _brandsList) {
            BrandsModel * newModel = [[BrandsModel alloc]init];
            newModel.brandId = model.brandId;
            newModel.brandName = model.brandName;
            newModel.isSelect = model.isSelect;
            [muList addObject:newModel];
        }
        ScreenView * view = [[ScreenView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.width, self.height) Arr:muList];
        self.screenView = view;
        view.delegate = self;
        [self addSubview:view];

        
        [UIView animateWithDuration:0.3 animations:^{
            view.frame = CGRectMake(_tableView.left, 0, _tableView.width, SCREEN_HEIGHT);
        }];
        return;
    }
    //点击button反选
    BrandsModel * model = [_brandsList objectAtIndex:sender.tag];
    model.isSelect = !model.isSelect;
    if (model.isSelect) {
        [_selectBrandsList addObject:model];
    }else{
        [_selectBrandsList removeObject:model];
    }
    [self reloadBrandsView];
}

#pragma mark - 选择品牌回调方法
//返回
-(void)backRootViewController
{
    [UIView animateWithDuration:0.3 animations:^{
        self.screenView.frame = CGRectMake(SCREEN_WIDTH, 0, _tableView.width, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [self.screenView removeFromSuperview];
    }];
}
//确定
-(void)sendAndBack:(NSMutableArray *)selectBrandsList
{
    [_selectBrandsList removeAllObjects];
    
    //yuei代码
    _selectBrandsList  = [selectBrandsList mutableCopy];
    for (BrandsModel * brand in _brandsList) {
        for (BrandsModel * selectModel in selectBrandsList) {
            if (brand.brandId == selectModel.brandId) {
                brand.isSelect = YES;
                break;
            }else{
                brand.isSelect = NO;
            }
        }
    }
    
    //之前代码
//    for (BrandsModel * brand in _brandsList) {
//        for (BrandsModel * selectModel in selectBrandsList) {
//            if (brand.brandId == selectModel.brandId) {
//                brand.isSelect = YES;
//                [_selectBrandsList addObject:brand];
//            }
//        }
//    }
    //之前代码
    
    [self reloadBrandsView];
    [UIView animateWithDuration:0.3 animations:^{
        self.screenView.frame = CGRectMake(SCREEN_WIDTH, 0, _tableView.width, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
        [self.screenView removeFromSuperview];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer=@"indentifer";
    ScreeningViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell=[[ScreeningViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=COLOR_F7F7F7;
    }
    SkuPropertyModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
    if (model.propertyList.count<=3) {
        model.expandHeight = model.normalHeight;
    }else{
        model.expandHeight = (model.propertyList.count/3 + 1)*40 + 10;
    }
    cell.model = model;
    cell.expandBtn.tag = indexPath.row;
    [cell.expandBtn addTarget:self action:@selector(doExpandCell:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat btnWidth = (cell.propertyView.width - 60)/3;
    for (int i=0; i<model.propertyList.count; i++) {
        PropertyModel * proModel = [model.propertyList objectAtIndex:i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(15+(i%3)*(btnWidth + 15), 40*(i/3), btnWidth, 30)];
        [button setTitle:proModel.propertyValue forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseProperty:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = Font_1_F13;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 2;
        button.tag = indexPath.row * 10000 +i;
        if (proModel.isSelect) {
            button.backgroundColor = CLEAR_COLOR;
            button.layer.borderColor = COLOR_F2B602.CGColor;
            [button setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            button.backgroundColor = COLOR_F7F7F7;
            button.layer.borderColor = CLEAR_COLOR.CGColor;
            [button setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        }
        [cell.propertyView addSubview:button];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SkuPropertyModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
    if (model.isExpand) {
        return model.expandHeight;
    }
    return model.normalHeight;
}

#pragma mark - 展开cell
-(void)doExpandCell:(UIButton *)sender
{
    SkuPropertyModel * model = [_tableView.dataArray objectAtIndex:sender.tag];
    model.isExpand = !model.isExpand;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 选择属性
-(void)chooseProperty:(UIButton *)sender
{
    SkuPropertyModel * model = [_tableView.dataArray objectAtIndex:sender.tag/10000];
    PropertyModel * proModel = [model.propertyList objectAtIndex:sender.tag%10000];
    //-----yulei 修改bug----
    if (model.selectPropertyList.count > 4 && proModel.isSelect == NO) {
        [VJDProgressHUD showTextHUD:@"最多选择5项"];
        return;
    }
    //-----yulei 修改bug----
    proModel.isSelect = !proModel.isSelect;
    if (proModel.isSelect) {
        
        [model.selectPropertyList addObject:proModel];
    }else{
        [model.selectPropertyList removeObject:proModel];
    }
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:sender.tag/10000 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 创建 底部view
-(void)creatBottomView
{
    _tableView.frame = CGRectMake(_tableView.left, _tableView.top, _tableView.width, _tableView.height - 50);
    
    //重选
    UIButton * reelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(_tableView.left, _tableView.bottom, _tableView.width/2, 50)];
    [reelectBtn setTitle:@"重选" forState:UIControlStateNormal];
    [reelectBtn addTarget:self action:@selector(reelectScreening) forControlEvents:UIControlEventTouchUpInside];
    reelectBtn.titleLabel.font = Font_1_F15;
    reelectBtn.backgroundColor = COLOR_F7F7F7;
    [reelectBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [self addSubview:reelectBtn];
    
    //确定
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(reelectBtn.right, reelectBtn.top, reelectBtn.width, reelectBtn.height)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(screeningSure) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = Font_1_F15;
    sureBtn.backgroundColor = COLOR_F2B602;
    [sureBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    
    //灰色线条
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(_tableView.left, reelectBtn.top, _tableView.width, 0.5)];
    lineView.backgroundColor = COLOR_DDDDDD;
    [self addSubview:lineView];
}

#pragma mrak - 重选
-(void)reelectScreening
{
    //清除已选 分类
    _categoryValueLab.text = @"选择";
    _categoryValueLab.textColor = COLOR_333333;
    _selectCategoryModel = nil;
    
    _lowPriceTextF.text = nil;
    _highPriceTextF.text = nil;
    
    //清除已选 品牌
    if (_selectBrandsList.count) {
        [_selectBrandsList removeAllObjects];
        for (BrandsModel * brand in _brandsList) {
            brand.isSelect = NO;
        }
        [self reloadBrandsView];
    }
    
    //清除已选 属性
    for (SkuPropertyModel * model in _tableView.dataArray) {
        [model.selectPropertyList removeAllObjects];
        for (PropertyModel * proModel in model.propertyList) {
            proModel.isSelect = NO;
        }
    }
    
    
    //-------------------------yulei修改bug--------------------------
    [self.tableView.dataArray removeAllObjects];
    //UI恢复到之前的状态
    _brandsView.hidden = YES;
    _priceView.frame = CGRectMake(0, _categoryView.bottom + 10, _headerView.width, _priceView.height);
    //-------------------------yulei修改bug--------------------------
    
    [_tableView reloadData];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length>=8) {
        return NO;
    }
    return YES;
}

#pragma mark - 确定
-(void)screeningSure
{
    //高低价格转换
    if ([_lowPriceTextF.text floatValue] >= [_highPriceTextF.text floatValue]) {
        NSString * highPrice = _lowPriceTextF.text;
        _lowPriceTextF.text = _highPriceTextF.text;
        _highPriceTextF.text = highPrice;
    }
    
    NSMutableArray * muArray = [NSMutableArray array];
    for (SkuPropertyModel * model in _tableView.dataArray){
        for (PropertyModel * proModel in model.propertyList) {
            if (proModel.isSelect) {
                [muArray addObject:proModel];
            }
        }
    }
    if (_screeningBlcok) {
        _screeningBlcok(_selectBrandsList,muArray,_lowPriceTextF.text,_highPriceTextF.text,_selectCategoryModel);
        if (_categoryNameBlock) {
                        _categoryNameBlock(_categoryValueLab.text);
        }
        [self back];
    }
}

#pragma mark - 返回
-(void)back
{
    [VJDProgressHUD dismissHUD];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
       // [self removeFromSuperview];
        //self.hidden =YES;
        
    }];
}

@end
