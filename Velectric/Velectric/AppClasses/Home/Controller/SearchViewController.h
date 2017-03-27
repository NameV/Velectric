//
//  SearchViewController.h
//  Velectric
//
//  Created by QQ on 2016/11/28.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (nonatomic, strong)UITableView * tableView;//历史记录列表
@property (nonatomic, strong)NSMutableArray * dataArray;//数据源
@property (nonatomic, strong)UITableView *tableView1;//搜索列表
@property (nonatomic, assign)BOOL isSearch;//是否有搜索的关键字
@property (nonatomic, strong)UIView * headerView;//列表的头部
@property (nonatomic, strong) NSString * searchStr;//搜索的关键字
@property (nonatomic, strong)UINavigationController * nav;//push用 上个页面传过来的

-(void)reloadTableviewFieldText:(NSString *)fieldText;//调用搜索的方法

@end
