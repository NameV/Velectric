//
//  ScreeningCategoryView.m
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ScreeningCategoryView.h"
#import "HomeCategoryModel.h"
#import "ScreeningCategoryViewCell1.h"
#import "ScreeningCategoryViewCell2.h"
#import "ScreeningCategoryViewCell3.h"
#import "SectionView.h"

@implementation ScreeningCategoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _firstCategoryList = [NSMutableArray array];
        _secondCategoryList = [NSMutableArray array];
        _thirdbCategoryList = [NSMutableArray array];
        
        _currentLevel = 1;
        //创建 顶部view
        [self creatTopView];
        //创建 tableview
        [self creatTableView];
    }
    return self;
}

#pragma mark - 创建 顶部view
-(void)creatTopView
{
    UIView * topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.width, 44)];
    topBackView.backgroundColor = COLOR_333333;
    [self addSubview:topBackView];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 44)];
    UIImage * backImage = [UIImage imageNamed:@"back2"];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [topBackView addSubview:backBtn];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake((topBackView.width - 100)/2, 0, 100, 44)];
    titleLab.text = @"筛选分类";
    titleLab.font = Font_1_F17;
    titleLab.textColor = COLOR_FFFFFF;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:titleLab];
}

#pragma mark - 创建 tableview
-(void)creatTableView
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64, self.width, SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1;
    _tableView.backgroundColor = COLOR_F7F7F7;
    [self addSubview:_tableView];
}

-(void)setShowType:(DataShowType)showType
{
    _showType = showType;
    //请求 分类
    
    if (self.fromFactoryFlage) {
        [self requestCategoryId];//来自品牌的网络请求
        _showType =DataShow_oneLevel;
    }else{
        [self requestGetTree];
    }
    
    
}
#pragma mark 厂商和品牌的分类数据请求
-(void)requestCategoryId
{
    // NSString * brandNameStr = self.brandsList[0];
    if (!self.level) {
        self.level = @"";
    }

    NSDictionary * parameters = @{
                                  @"brandName":self.brandName,          //品牌名
                                  @"brandId":[NSString stringWithFormat:@"%ld", _categoryId],         //品牌id
                                  @"manufacturerId":@"",
                                  @"manufacturerName":@"",
                                  @"identifying":_type,
                                  @"categoryId":@"",
                                  @"categoryName":@"",
                                  @"level":self.level,
                                  };
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCategoryGetByBrandOrManufacturerURL parameters:parameters success:^(NSDictionary *responseObject) {
        
        for (NSDictionary * dic in responseObject[@"category"]) {
            HomeCategoryModel * model = [[HomeCategoryModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.firstCategoryList addObject:model];
        }
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}



-(void)requestGetTree
{
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters;
    //一、二、三级展示
    if (_showType == DataShow_threeLevel) {
        if (_currentLevel == 1) {
            parameters = @{@"categoryId":@"1"};
            [_firstCategoryList removeAllObjects];
        }else if (_currentLevel == 2){
            parameters = @{@"categoryId":[NSNumber numberWithInteger:_selectFirstModel.myId]};
            [_secondCategoryList removeAllObjects];
        }else if (_currentLevel == 3){
            parameters = @{@"categoryId":[NSNumber numberWithInteger:_selectSecondModel.myId]};
            [_thirdbCategoryList removeAllObjects];
        }
    }else if (_showType == DataShow_twoLevel){
        if (_currentLevel == 1) {
            parameters = @{@"categoryId":[NSNumber numberWithInteger:_categoryId]};
            [_firstCategoryList removeAllObjects];
            
        }else if (_currentLevel == 2){
            parameters = @{@"categoryId":[NSNumber numberWithInteger:_selectFirstModel.myId]};
            [_secondCategoryList removeAllObjects];
        }
    }else{
        parameters = @{@"categoryId":[NSNumber numberWithInteger:_categoryId]};
        [_firstCategoryList removeAllObjects];
    }
    
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        [VJDProgressHUD dismissHUD];
        NSDictionary * result = [responseObject objectForKey:@"result"];
        if (result && ![result isKindOfClass:[NSNull class]]) {
            NSArray * children = [result objectForKey:@"children"];
            if (children.count){
                for (NSDictionary * dic in children) {
                    HomeCategoryModel * model = [[HomeCategoryModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    if (_showType == DataShow_threeLevel) {
                        if (_currentLevel == 1) {
                            [weakSelf.firstCategoryList addObject:model];
                        }else if (_currentLevel == 2){
                            [weakSelf.secondCategoryList addObject:model];
                        }else if (_currentLevel == 3){
                            [weakSelf.thirdbCategoryList addObject:model];
                        }
                    }else if (_showType == DataShow_twoLevel){
                        if (_currentLevel == 1) {
                            [weakSelf.firstCategoryList addObject:model];
                        }else if (_currentLevel == 2){
                            [weakSelf.secondCategoryList addObject:model];
                        }
                    }else if (_showType == DataShow_oneLevel){
                        [weakSelf.firstCategoryList addObject:model];
                    }
                }
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _firstCategoryList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return 40;
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeCategoryModel * model = [_firstCategoryList objectAtIndex:section];
    SectionView * sectionV = [[SectionView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 40)];
    sectionV.fromFactoryFlage = self.fromFactoryFlage;
    sectionV.backgroundColor = COLOR_FFFFFF;
    sectionV.button.tag = section;
    [sectionV.button addTarget:self action:@selector(tableViewDidSelectSecton:) forControlEvents:UIControlEventTouchUpInside];
    sectionV.model = model;
    return sectionV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        HomeCategoryModel * model = [_firstCategoryList objectAtIndex:section];
        if (model.isSelect) {
            return _secondCategoryList.count;
        }
        return 0;
    }else {
        return _thirdbCategoryList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        static NSString * indentifer=@"indentifer1";
        ScreeningCategoryViewCell2 * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[ScreeningCategoryViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=COLOR_FFFFFF;
        }
        HomeCategoryModel * model = [_secondCategoryList objectAtIndex:indexPath.row];
        cell.model = model;
        if (model.isSelect) {
            cell.subCategoryView.hidden = NO;
            cell.subCategoryView.frame = CGRectMake(0, 40, self.width, 40*_thirdbCategoryList.count);
            cell.subCategoryView.delegate = self;
            cell.subCategoryView.dataSource = self;
            cell.subCategoryView.tag = 2;
            [cell.subCategoryView reloadData];
        }else{
            cell.subCategoryView.hidden = YES;
        }
        return cell;
    }else if (tableView.tag == 2) {
        static NSString * indentifer=@"indentifer2";
        ScreeningCategoryViewCell3 * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[ScreeningCategoryViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=COLOR_FFFFFF;
        }
        HomeCategoryModel * model = [_thirdbCategoryList objectAtIndex:indexPath.row];
        cell.model = model;
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        HomeCategoryModel * model = [_secondCategoryList objectAtIndex:indexPath.row];
        if (model.isSelect) {
            return  40 + 40*_thirdbCategoryList.count;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showType == DataShow_threeLevel) {
        //选中的二级类别model
        if (tableView.tag == 1){
            _selectSecondModel = [_secondCategoryList objectAtIndex:indexPath.row];
            _selectSecondModel.isSelect = !_selectSecondModel.isSelect;
            if (_selectSecondModel.isSelect) {
                _currentLevel = 3;
                //请求 分类
                [self requestGetTree];
            }else{
                [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            //选中的三级类别model
            HomeCategoryModel * model = [_thirdbCategoryList objectAtIndex:indexPath.row];
            if (_chooseCategoryFinishBlcok) {
                _chooseCategoryFinishBlcok(model);
                [self back];
            }
        }
    }else if (_showType == DataShow_twoLevel){
        //选中的三级类别model
        HomeCategoryModel * model = [_secondCategoryList objectAtIndex:indexPath.row];
        if (_chooseCategoryFinishBlcok) {
            _chooseCategoryFinishBlcok(model);
            [self back];
        }
    }
}

#pragma mark - section点击
-(void)tableViewDidSelectSecton:(UIButton *)sender
{
    if (_showType == DataShow_threeLevel || _showType == DataShow_twoLevel) {
        _selectFirstModel = [_firstCategoryList objectAtIndex:sender.tag];
        _selectFirstModel.isSelect = !_selectFirstModel.isSelect;
        NSIndexSet * section = [NSIndexSet indexSetWithIndex:sender.tag];
        [_tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
        if (_selectFirstModel.isSelect) {
            _currentLevel = 2;
            //请求 分类
            [self requestGetTree];
        }
    }else if (_showType == DataShow_oneLevel){
        HomeCategoryModel * model = [_firstCategoryList objectAtIndex:sender.tag];
        if (_chooseCategoryFinishBlcok) {
            _chooseCategoryFinishBlcok(model);
            [self back];
        }
    }
}

#pragma mark - 返回
-(void)back
{
    [VJDProgressHUD dismissHUD];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
