//
//  BrandsView.m
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "BrandsView.h"
#import "HomeCategoryModel.h"
#import "BrandsModel.h"
#import "FactoryViewController.h"       //厂商首页
#import "UIScrollView+PSRefresh.h"      //横向加载
#import "BrandsCollectionCell.h"


static CGFloat originX = 10;

@implementation BrandsView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _categoryList = [NSMutableArray array];
        _brandsList = [NSMutableArray array];
        _typeBtnList = [NSMutableArray array];
        _clickIndex = 0;
        [self creatUI];
        [self requestGetTree];
    }
    return  self;
}

#pragma mark - 请求 品牌类别
-(void)requestGetTree
{
    VJDWeakSelf;
    NSDictionary * parameters = @{@"categoryId":@"1"};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:2 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        NSDictionary * result = [responseObject objectForKey:@"result"];
        if (![result isKindOfClass:[NSNull class]]) {
            NSArray * children = [result objectForKey:@"children"];
            if (children.count){
                for (NSDictionary * dic in children) {
                    HomeCategoryModel * model = [[HomeCategoryModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.categoryList addObject:model];
                }
                //重载品牌类型按钮
                [weakSelf reloadBrandTypeScrollView];
                //请求 品牌类型
                [weakSelf requestListByCategory];
            }
            else{
                
            }
        }else{
            //todo
            //请求 品牌类型
            [weakSelf requestListByCategory];
        }
    } failure:^(NSError *error) {
//        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 请求品牌信息
-(void)requestListByCategory
{
    VJDWeakSelf;
    if (_categoryList.count==0) {
        return;
    }
    HomeCategoryModel * model = [_categoryList objectAtIndex:_clickIndex];
    NSDictionary * parameters = @{@"categoryId":[NSNumber numberWithInteger:model.myId],
                                  @"pageSize":@"20",};
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:2 WithURLString:GetListByCategoryURL parameters:parameters success:^(NSDictionary *responseObject) {
        [VJDProgressHUD showSuccessHUD:nil];
        NSArray * result = [responseObject objectForKey:@"result"];
        if (result.count){
            [weakSelf.brandsList removeAllObjects];
            for (NSDictionary * dic in result) {
                BrandsModel * model = [[BrandsModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [weakSelf.brandsList addObject:model];
            }
            //重载品牌类型
            //            [weakSelf reloadBrandBgScrollView];
            [weakSelf.brandCollectionView reloadData];
            [weakSelf.brandCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];//滚动到第一个
            [weakSelf.brandCollectionView endRefreshing];
        }
        else{
            
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 创建UI
-(void)creatUI
{
    //品牌馆image
    UIImage * brandImg = [UIImage imageNamed:@"biaoqian"];
    UIImageView * brandImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, brandImg.size.height)];
    brandImage.image = brandImg;
    brandImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:brandImage];
    
    NSArray * titleList = @[@"五金工具",@"机电设备",@"电器电缆",@"密封保温",@"水暖建材",@"仪器仪表",@"劳保安防",@"轴承标准件",];
    _brandtypeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, brandImage.bottom + 10, SCREEN_WIDTH, 30)];
    _brandtypeScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_brandtypeScrollView];
    
    UIView * lastView;
    for (int i=0; i<titleList.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = Font_1_F12;
        button.tag = i;
        [button setTitle:[titleList objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        CGFloat width = [[titleList objectAtIndex:i] getStringWidthWithFont:Font_1_F12];
        button.layer.cornerRadius = 2;
        if (i==0) {
            button.frame = CGRectMake(10, 0, width + 10, 25);
            button.backgroundColor = COLOR_333333;
            [button setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            button.frame = CGRectMake(lastView.right + 4, 0, width + 10, 25);
        }
        if (i<titleList.count -1) {
            //分割线
            UIView * fengeView = [[UIView alloc]initWithFrame:CGRectMake(button.right + 2, button.top + 7, 0.5, button.height - 14)];
            fengeView.backgroundColor = COLOR_DDDDDD;
            [_brandtypeScrollView addSubview:fengeView];
        }
        
        [button addTarget:self action:@selector(brandTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_brandtypeScrollView addSubview:button];
        [_typeBtnList addObject:button];
        lastView = button;
    }
    _brandtypeScrollView.contentSize = CGSizeMake(lastView.right + 10, _brandtypeScrollView.height);
    
    CGFloat distance = SCREEN_WIDTH/4;
    
    //品牌背景view
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;     //列间距 最小距离
    flowLayout.minimumLineSpacing = 0;          //行间距 最小距离
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
    _brandCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _brandtypeScrollView.bottom, SCREEN_WIDTH, distance * 2+1 ) collectionViewLayout:flowLayout];
    _brandCollectionView.backgroundColor = COLOR_FFFFFF;
    _brandCollectionView.dataSource = self;
    _brandCollectionView.delegate = self;
    [self addSubview:_brandCollectionView];
    
    [_brandCollectionView registerClass:[BrandsCollectionCell class] forCellWithReuseIdentifier:@"BrandsCollectionCell"];
    
    VJDWeakSelf;
    _brandCollectionView.refreshFooterTextColor = COLOR_666666;
    [_brandCollectionView addGifRefreshFooterNoStatusWithClosure:^{
//        [weakSelf requestListByCategory];
        [weakSelf.brandCollectionView endRefreshing];
    }];
    
//    //三条横线和三条竖线
//    for (int i=0; i<3; i++) {
//        //横线
//        UIView * HorizontalView = [[UIView alloc]initWithFrame:CGRectMake(0,_brandCollectionView.top + i*distance, SCREEN_WIDTH, 0.5)];
//        HorizontalView.backgroundColor = COLOR_DDDDDD;
//        [self addSubview:HorizontalView];
//        //竖线
//        UIView * verticalView = [[UIView alloc]initWithFrame:CGRectMake(distance + i*distance, _brandCollectionView.top, 0.5, distance * 2)];
//        verticalView.backgroundColor = COLOR_DDDDDD;
//        [self addSubview:verticalView];
//    }
    
//    //循环添加品牌
//    for (int i=0; i<8; i++) {
//        UIImage * image = [UIImage imageNamed:@"brand"];
//        UIImageView * brandImage = [[UIImageView alloc]initWithFrame:CGRectMake(originX + (i%4)*distance, originX + (i/4)*distance, distance - originX*2, distance - originX*2)];
//        brandImage.image = image;
//        [_brandCollectionView addSubview:brandImage];
//    }
    
    self.frame = CGRectMake(0, self.top, SCREEN_WIDTH, _brandCollectionView.bottom);
}

#pragma mark - UICollectionViewDelegate
// item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4-1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_brandsList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BrandsCollectionCell" forIndexPath:indexPath];
    BrandsModel * model = [_brandsList objectAtIndex:indexPath.row];
    NSURL * picUrl = [NSURL URLWithString:CreateRequestApiPictureUrl(model.logoOriginUrl)];
    [cell.photoView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandsModel * model = [_brandsList objectAtIndex:indexPath.row];
    FactoryViewController * vc = [[FactoryViewController alloc]init];
    vc.enterType = ScreeningViewEnterType3;
    vc.brandsModel = model;
    vc.type = @"1";
    vc.saiXuanCategory = [NSString stringWithFormat:@"%@",model.Id];
    [_controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 商品类型按钮点击
-(void)brandTypeBtnClick:(UIButton *)sender
{
    _clickIndex = sender.tag;
    if (_categoryList.count) {
        //请求品牌信息
        [self requestListByCategory];
    }
    
    //判断是否需要移动
    [self judgeIsNeedToMove:sender];
}

#pragma mark - 判断是否需要移动
-(void)judgeIsNeedToMove:(UIButton *)sender
{
    for (UIButton * btn in _typeBtnList) {
        if ([btn isEqual:sender]) {
            btn.backgroundColor = COLOR_333333;
            [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
            btn.backgroundColor = CLEAR_COLOR;
        }
    }
    //第一个按钮
    if ([sender isEqual:[_typeBtnList firstObject]]) {
        [_brandtypeScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //最后一个按钮
    else if ([sender isEqual:[_typeBtnList lastObject]]) {
        [_brandtypeScrollView setContentOffset:CGPointMake(_brandtypeScrollView.contentSize.width - _brandtypeScrollView.width, 0) animated:YES];
    }
    else{
        CGFloat offset = _brandtypeScrollView.contentOffset.x;
        if (offset == _brandtypeScrollView.contentSize.width - _brandtypeScrollView.width) {
            return;
        }
        //自动向左移动
        if((sender.right - offset) > (_brandtypeScrollView.width - 30)){
            if (offset + _brandtypeScrollView.frame.size.width >= _brandtypeScrollView.contentSize.width) {
                [_brandtypeScrollView setContentOffset:CGPointMake(_brandtypeScrollView.contentSize.width - _brandtypeScrollView.width, 0) animated:YES];
            }
            [_brandtypeScrollView setContentOffset:CGPointMake(offset + sender.width, 0) animated:YES];
        }
        //自动向右移动
        if((sender.left - offset) < 30){
            [_brandtypeScrollView setContentOffset:CGPointMake(offset - sender.width, 0) animated:YES];
        }
    }
}

#pragma mark - 重载品牌类型按钮
-(void)reloadBrandTypeScrollView
{
    [_brandtypeScrollView removeAllSubviews];
    [_typeBtnList removeAllObjects];
    UIView * lastView;
    for (int i=0; i<_categoryList.count; i++) {
        HomeCategoryModel * model = [_categoryList objectAtIndex:i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = Font_1_F12;
        button.tag = i;
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        CGFloat width = [model.name getStringWidthWithFont:Font_1_F12];
        button.layer.cornerRadius = 2;
        if (i==0) {
            button.frame = CGRectMake(10, 0, width + 10, 25);
            button.backgroundColor = COLOR_333333;
            [button setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        }else{
            button.frame = CGRectMake(lastView.right + 4, 0, width + 10, 25);
        }
        if (i<_categoryList.count -1) {
            //分割线
            UIView * fengeView = [[UIView alloc]initWithFrame:CGRectMake(button.right + 2, button.top + 7, 0.5, button.height - 14)];
            fengeView.backgroundColor = COLOR_DDDDDD;
            [_brandtypeScrollView addSubview:fengeView];
        }
        
        [button addTarget:self action:@selector(brandTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_brandtypeScrollView addSubview:button];
        [_typeBtnList addObject:button];
        lastView = button;
    }
    _brandtypeScrollView.contentSize = CGSizeMake(lastView.right + 10, _brandtypeScrollView.height);
}

#pragma mark - 重载品牌类型
-(void)reloadBrandBgScrollView
{
    [_brandCollectionView removeAllSubviews];
    
    CGFloat distance = SCREEN_WIDTH/4;
    //循环添加品牌
    for (int i=0; i<_brandsList.count; i++) {
        BrandsModel * model = [_brandsList objectAtIndex:i];
        UIImage * image = [UIImage imageNamed:@"brand"];
        NSURL * picUrl = [NSURL URLWithString:CreateRequestApiPictureUrl(model.logoOriginUrl)];
        UIImageView * brandImage = [[UIImageView alloc]initWithFrame:CGRectMake(originX + (i%4)*distance, originX + (i/4)*distance, distance - originX*2, distance - originX*2)];
        brandImage.contentMode = UIViewContentModeScaleAspectFit;
        [brandImage sd_setImageWithURL:picUrl placeholderImage:image];
        [_brandCollectionView addSubview:brandImage];
        
        UIButton * button = [[UIButton alloc]initWithFrame:brandImage.frame];
        [button addTarget:self action:@selector(goToFactoryViewController:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [_brandCollectionView addSubview:button];
    }
}

#pragma mark - 进入品牌首页
-(void)goToFactoryViewController:(UIButton *)sender
{
    BrandsModel * model = [_brandsList objectAtIndex:sender.tag];
    FactoryViewController * vc = [[FactoryViewController alloc]init];
    vc.enterType = ScreeningViewEnterType3;
    vc.brandsModel = model;
    vc.type = @"1";
    vc.saiXuanCategory = [NSString stringWithFormat:@"%@",model.Id];
    [_controller.navigationController pushViewController:vc animated:YES];
}

@end
