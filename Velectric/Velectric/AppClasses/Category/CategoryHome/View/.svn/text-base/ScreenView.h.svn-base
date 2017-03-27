//
//  ScreenView.h
//  Velectric
//
//  Created by QQ on 2016/12/5.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandsModel.h"

//定义协议
@protocol ScreenViewDelegate <NSObject>

-(void)backRootViewController;
-(void)sendAndBack:(NSMutableArray *)selectBrandsList;

@end
@interface ScreenView : UIView<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray * dataArray;//字母排序数组
    NSMutableArray * indexList;
}
//品牌view
@property (strong,nonatomic) UIView * brandsView;
@property (strong,nonatomic)UIView * btnView;
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIButton * btn2;
@property (nonatomic, strong)UILabel * selectLab;
@property (nonatomic, strong)UITableView * tableView2;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIButton * backBtn;
@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)NSArray * seactionArray;

@property (nonatomic, strong)NSMutableArray * muArr;//推荐数组
@property (nonatomic, strong)NSMutableArray * selectArr;//选中的数组

@property (nonatomic, assign)id<ScreenViewDelegate>delegate;
//品牌集合
@property (strong,nonatomic) NSMutableArray <BrandsModel *>* brandsList;
//初始化并传数据
- (id)initWithFrame:(CGRect)frame Arr:(NSMutableArray *)arr;

@end
