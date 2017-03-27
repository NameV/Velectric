//
//  HSearchView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineTopCollectionView.h"
#import "publicCell.h"
@class HsearchModel;
@protocol HSearchViewDelegate<NSObject>

-(void)pushNextViewController:(HsearchModel *)model;
@end
@interface HSearchView : UIView<UITableViewDelegate,UITableViewDataSource,MineTopCollectionViewDelegate>

@property (nonatomic, strong)UITableView * tableView;//历史记录列表
@property (nonatomic, strong)NSMutableArray * dataArray;//数据源
@property (nonatomic, strong)UITableView *tableView1;//搜索列表
@property (nonatomic, assign)BOOL isSearch;//是否有搜索的关键字
@property (nonatomic, strong)UIView * headerView;//列表的头部
@property (nonatomic, strong) NSString * searchStr;//搜索的关键字
@property (nonatomic, strong)UINavigationController * nav;//push用 上个页面传过来的
@property (nonatomic, weak)id<HSearchViewDelegate>delegate;

@property (nonatomic, strong)UIView * nilView; //没有数据时展示的界面
-(void)reloadTableviewFieldText:(NSString *)fieldText;//调用搜索的方法
@end
