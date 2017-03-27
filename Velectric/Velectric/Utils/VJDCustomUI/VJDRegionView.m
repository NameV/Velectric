//
//  VJDRegionView.m
//  Velectric
//
//  Created by hongzhou on 2016/12/21.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "VJDRegionView.h"
#import "RegionModel.h"

@implementation VJDRegionView

-(instancetype)init
{
    if (self==[super init]) {
        
        _dataType = RegionData_Province;
        _provinceList = [NSMutableArray array];
        _cityList = [NSMutableArray array];
        _areaList = [NSMutableArray array];
        //创建UI
        [self creatUI];
        //请求数据
        [self requestRegionData];
    }
    return self;
}

#pragma mark - 创建UI
-(void)creatUI
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = COLOR_333333_A(0.5);
    
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 80)];
    header.backgroundColor = COLOR_F7F7F7;
    [self addSubview:header];
    
    //所在地区
    UILabel * versionlab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 0, 100, 40)];
    versionlab.font = Font_1_F15;
    versionlab.textColor = COLOR_999999;
    versionlab.text = @"所在地区";
    versionlab.textAlignment = NSTextAlignmentCenter;
    [header addSubview:versionlab];
    
    //关闭按钮
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40);
    [closeBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:closeBtn];
    
    _provinceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 80, 40)];
    _provinceLab.font = Font_1_F16;
    _provinceLab.textColor = COLOR_F2B602;
    _provinceLab.text = @"请选择";
    _provinceLab.textAlignment = NSTextAlignmentCenter;
    [header addSubview:_provinceLab];
    
    _cityLab = [[UILabel alloc]initWithFrame:CGRectMake(_provinceLab.right + 20, _provinceLab.top, _provinceLab.width, _provinceLab.height)];
    _cityLab.font = Font_1_F16;
    _cityLab.textColor = COLOR_F2B602;
    _cityLab.text = @"请选择";
    _cityLab.textAlignment = NSTextAlignmentCenter;
    _cityLab.hidden = YES;
    [header addSubview:_cityLab];
    
    _areaLab = [[UILabel alloc]initWithFrame:CGRectMake(_cityLab.right + 20, _provinceLab.top, _provinceLab.width, _provinceLab.height)];
    _areaLab.font = Font_1_F16;
    _areaLab.textColor = COLOR_F2B602;
    _areaLab.text = @"请选择";
    _areaLab.textAlignment = NSTextAlignmentCenter;
    _areaLab.hidden = YES;
    [header addSubview:_areaLab];
    
    _scrollLine = [[UIView alloc]initWithFrame:CGRectMake(_provinceLab.left, 78, 80, 2)];
    _scrollLine.backgroundColor = COLOR_F2B602;
    [header addSubview:_scrollLine];
    
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, header.bottom, SCREEN_WIDTH, 220)];
    _tableView.backgroundColor = COLOR_F7F7F7;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
}

#pragma mark - 请求数据
-(void)requestRegionData
{
    //省份 传值0
    NSDictionary * parameterDic;
    if (_dataType == RegionData_Province){
        parameterDic  = @{@"id": [NSNumber numberWithInteger:0],};
        [_provinceList removeAllObjects];
    }
    if (_dataType == RegionData_City){
        //城市 传值省份id
        parameterDic = @{@"id": [NSNumber numberWithInteger:_provinceModel.myId],};
        [_cityList removeAllObjects];
    }else if (_dataType == RegionData_Area){
        //地区 传值城市id
        parameterDic = @{@"id": [NSNumber numberWithInteger:_cityModel.myId],};
        [_areaList removeAllObjects];
    }
    [_tableView reloadData];
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindChildrenURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            NSArray * regions = [responseObject objectForKey:@"regions"];
            for (NSDictionary * dic in regions) {
                RegionModel * model = [[RegionModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                if (weakSelf.dataType == RegionData_Province) {
                    [weakSelf.provinceList addObject:model];
                }else if (weakSelf.dataType == RegionData_City){
                    [weakSelf.cityList addObject:model];
                }else if (weakSelf.dataType == RegionData_Area){
                    [weakSelf.areaList addObject:model];
                }
            }
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD  showErrorHUD:error.domain];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataType == RegionData_Province) {
        return _provinceList.count;
    }else if (_dataType == RegionData_City){
        return _cityList.count;
    }else if (_dataType == RegionData_Area){
        return _areaList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer= @"indentifer";
    UITableViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.contentView removeAllSubviews];
    
    RegionModel * model;
    if (_dataType == RegionData_Province) {
        model = [_provinceList objectAtIndex:indexPath.row];
    }else if (_dataType == RegionData_City){
        model = [_cityList objectAtIndex:indexPath.row];
    }else if (_dataType == RegionData_Area){
        model = [_areaList objectAtIndex:indexPath.row];
    }
    
    UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 40)];
    namelabel.font = Font_1_F15;
    namelabel.textColor = COLOR_999999;
    namelabel.text = model.name;
    [cell.contentView addSubview:namelabel];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 39.5, SCREEN_WIDTH - 20, 0.5)];
    lineView.backgroundColor = COLOR_DDDDDD;
    [cell.contentView addSubview:lineView];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataType == RegionData_Province) {
        _dataType = RegionData_City;
        _provinceModel = [_provinceList objectAtIndex:indexPath.row];
        _provinceLab.text = _provinceModel.name;
        _cityLab.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            _scrollLine.frame = CGRectMake(_cityLab.left, _cityLab.bottom - 2, _cityLab.width, 2);
        }];
        
        [self requestRegionData];
    }else if (_dataType == RegionData_City){
        _dataType = RegionData_Area;
        _cityModel = [_cityList objectAtIndex:indexPath.row];
        _cityLab.text = _cityModel.name;
        _areaLab.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            _scrollLine.frame = CGRectMake(_cityLab.left, _cityLab.bottom - 2, _cityLab.width, 2);
        }];
        [self requestRegionData];
    }else if (_dataType == RegionData_Area){
        _areaModel = [_areaList objectAtIndex:indexPath.row];
        if (_regionViewBlcok) {
            _regionViewBlcok(_provinceModel,_cityModel,_areaModel);
        }
        [self closeCurrentView];
    }
}

-(void)show
{
    [[KGModal sharedInstance] showWithContentView: self];
}

-(void)closeCurrentView
{
    [[KGModal sharedInstance] hide];
}

@end
