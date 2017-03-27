//
//  VSearchView.h
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VScanHistoryModel.h"
#import "HsearchModel.h"

@protocol VSearchViewDelegate <NSObject>

//点击热词
- (void)HotWordClickedWithHotWord:(HsearchModel *)model ;

//点击更多
- (void)moreButtonCliked ;

//点击历史足迹
- (void)pushDetailControllerWithModel:(VScanHistoryModel *)model ;

@end

@interface VSearchView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, assign) id<VSearchViewDelegate> delegate;

//更新数据
- (void)reloadData ;

@end
