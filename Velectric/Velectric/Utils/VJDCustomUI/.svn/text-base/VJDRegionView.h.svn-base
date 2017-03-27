//
//  VJDRegionView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/21.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegionModel;

//订单状态值
typedef enum {
    RegionData_Province             = 0,    //省份
    RegionData_City                 = 1,    //城市
    RegionData_Area                 = 2,    //地区
}RegionDataType;

@interface VJDRegionView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) BaseTableView * tableView;
//省份数据
@property (strong,nonatomic) NSMutableArray * provinceList;
//城市数据
@property (strong,nonatomic) NSMutableArray * cityList;
//地区数据
@property (strong,nonatomic) NSMutableArray * areaList;

//选中的省份
@property (strong,nonatomic) UILabel * provinceLab;
//选中的城市
@property (strong,nonatomic) UILabel * cityLab;
//选中的地区
@property (strong,nonatomic) UILabel * areaLab;
//滚动线条
@property (strong,nonatomic) UIView * scrollLine;

@property (assign,nonatomic) RegionDataType dataType;

//选中的省份 model
@property (strong,nonatomic) RegionModel * provinceModel;
//选中的城市 model
@property (strong,nonatomic) RegionModel * cityModel;
//选中的地区 model
@property (strong,nonatomic) RegionModel * areaModel;

@property (copy,nonatomic) void (^regionViewBlcok)(RegionModel * province,RegionModel * city,RegionModel * area);

-(void)show;



@end
