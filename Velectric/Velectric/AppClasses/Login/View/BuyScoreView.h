//
//  BuyScoreView.h
//  Velectric
//
//  Created by QQ on 2016/11/28.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义协议
@protocol BuybackRootViewDelegate <NSObject>

-(void)backRootViewController;
-(void)allThingSelect;

@end
@interface BuyScoreView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArray;
    NSArray *dataArray1;
}
@property (nonatomic, strong)NSMutableArray *tableArray; //记录选中的二级物品
@property (nonatomic, copy)NSString *name; //记录选中的一级name

@property (nonatomic, strong)UITableView * tableView1;
@property (nonatomic, strong)UITableView * tableView2;
@property (nonatomic, assign)BOOL isSelect;
@property (nonatomic, weak)id<BuybackRootViewDelegate>delegate;

//回调block
@property (copy,nonatomic) void (^buyScreeningBlcok)(NSString * managerange, NSString * myId);
@end
