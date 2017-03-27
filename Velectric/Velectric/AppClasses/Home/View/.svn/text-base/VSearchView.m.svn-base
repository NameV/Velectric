//
//  VSearchView.m
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSearchView.h"
#import "VSearchHeaderView.h"
#import "VDateManager.h"
#import "VSearchFootPrintCell.h"
#import "VFileMnager.h"
#import "USPopView.h"
#import "HsearchModel.h"

@interface VSearchView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *cacheDatas;

@end

@implementation VSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self hotWordRequest];//获取热词
        [self getAllHistoryRecord];//获取所有历史足迹
        [self getLocalHistorySerach];//获取本地历史搜索
    }
    return self;
}

- (void)reloadData {
    [self hotWordRequest];//获取热词
    [self getLocalHistorySerach];//获取本地历史搜索
    [self getAllHistoryRecord];//获取所有历史足迹
}

#pragma mark - https

//获取热词请求
- (void)hotWordRequest {
    NSDictionary *paramDic = @{};
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HotWordQueryURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                        
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self.datas replaceObjectAtIndex:0 withObject:responseObject[@"hotWord"]];
                                               NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                                               [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];

}

//获取本地历史搜索
- (void)getLocalHistorySerach {
    
    NSArray *array = [[VFileMnager sharedInstance] getHistorySearchFromCache];
    [self.datas replaceObjectAtIndex:1 withObject:array];
    self.cacheDatas = [array mutableCopy];//全局的缓存数据
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

//获取所有历史记录
- (void)getAllHistoryRecord {
    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HistoricalFootprintQueryURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               NSMutableArray *tmpArray = [NSMutableArray array];
                                               for (NSArray *array in [VDateManager getArrayWithArray:responseObject[@"list"]]) {
                                                   for (VScanHistoryModel *model in array) {
                                                       [tmpArray addObject:model];
                                                   }
                                               }
                                               [self.datas replaceObjectAtIndex:2 withObject:tmpArray];
                                               NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                                               [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}


#pragma mark - config

- (void)setupViews {
    [self addSubview:self.tableView];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.datas[section] count] < 20 ? [self.datas[section] count] : 20;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1 && [self.datas[section] count] > 0) {
        return 70;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
        case 0://热词
        {
            return [self cellHightWithTableView:tableView indexPath:indexPath];
        }
            break;
        case 1://历史搜索
        {
            VSearchFootPrintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdView" forIndexPath:indexPath];
            NSArray *array = self.datas[1];//获取到所有天的model数组
            HsearchModel *model = array[indexPath.row];
            [self configCellWithCell:cell model:model];
            return cell;
        }
            break;
        case 2://历史足迹
        {
            VSearchFootPrintCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdView" forIndexPath:indexPath];
            NSArray *array = self.datas[2];//获取到所有天的model数组
            cell.model = array[indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.datas[indexPath.section][indexPath.row]];
    return cell;
}

//给历史搜索cell赋值
- (void)configCellWithCell:(VSearchFootPrintCell *)cell model:(HsearchModel *)model{
    
    NSString * labText;
    
    if ([model.searchText isEmpty] || !model.searchText) {//如果为空，走智能搜索的字符串拼接
        if (![@""isEqualToString:model.categoryId] && model.categoryId) {
            labText = [NSString stringWithFormat:@"%@",model.categoryTreePath];
            cell.titleLabel.text = labText;
            
        }else if (![@""isEqualToString:model.brandName] && model.brandName){
            labText = [NSString stringWithFormat:@"品牌中搜索%@",model.brandName];
            cell.titleLabel.text = labText;
        }else if (![@""isEqualToString:model.productName] && model.productName){
            labText = [NSString stringWithFormat:@"商品中%@",model.productName];
            cell.titleLabel.text = labText;
            
        }else if (![@""isEqualToString:model.manufacturerName] && model.manufacturerName){
            labText= [NSString stringWithFormat:@"厂商中搜索%@",model.manufacturerName];
        }

    }else{//搜索词不为空，直接显示搜索词
        labText = model.searchText;
    }
    
    cell.titleLabel.text = labText;
    cell.timeLabel.text = @"";

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    VSearchHeaderView *headerView = [[VSearchHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    switch (section) {
        case 0:
        {
            headerView.titleLabel.text = @"热搜";
            headerView.iconImage.image = [UIImage imageNamed:@"HoT"];
            headerView.moreBtn.hidden = YES;
        }
            break;
        case 1:
        {
            headerView.titleLabel.text = @"历史搜索";
            headerView.iconImage.image = [UIImage imageNamed:@"sousuolishi"];
            headerView.moreBtn.hidden = YES;
        }
            break;
        case 2:
        {
            headerView.titleLabel.text = @"历史足迹";
            headerView.iconImage.image = [UIImage imageNamed:@"zuji"];
            [headerView.moreBtn addTarget:self action:@selector(moreHistory:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
            break;
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView;
    if (section == 1 && [self.datas[section] count] > 0) {
        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        footerView.backgroundColor = [UIColor whiteColor];
        
        //清空历史搜索按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((SCREEN_WIDTH - 120) / 2, 15, 120, 30);
        [button setImage:[UIImage imageNamed:@"qingkonglishi"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteAllHistory:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        
        //
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 10)];
        view.backgroundColor = [UIColor ylColorWithHexString:@"#f2f2f2"];
        [footerView addSubview:view];
    }else{
        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        footerView.backgroundColor = [UIColor ylColorWithHexString:@"#f2f2f2"];
    }
    return footerView;
}

#pragma mark - hotWord view
//热词cell
- ( UITableViewCell *)cellHightWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    //cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //清空cell上面所以视图，方式重新创建，视图错乱。
    [cell removeAllSubviews];
    
    //滚动视图
    UIScrollView *scrolView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    scrolView.showsHorizontalScrollIndicator = NO;
    [cell addSubview:scrolView];
    
    NSArray *arr = self.datas[indexPath.section];
    CGFloat width = 0;
    for (int i = 0; i < arr.count; i++) {
        
        //热词
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = i + 100;
        [button setTitleColor:V_BLACK_COLOR forState:UIControlStateNormal];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 2;
        button.layer.borderColor = V_ORANGE_COLOR.CGColor;
        button.layer.borderWidth = 1;
        [button addTarget:self action:@selector(wordHotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        
        button.frame = CGRectMake(width + 10, 5, length + 10, 30);
        [scrolView addSubview:button];
        
        width = button.frame.origin.x + length + 15;
        
    }
    
    scrolView.contentSize = CGSizeMake(width + 10, 40);
    
    return cell;
}

#pragma mark - action
//热词点击方法
- (void)wordHotBtnAction:(UIButton *)btn {
    ELog(@"热词");
    NSString *hotWord = self.datas[0][btn.tag - 100];
    HsearchModel *model = [[HsearchModel alloc]init];
    model.searchText = hotWord;
    if ([_delegate respondsToSelector:@selector(HotWordClickedWithHotWord:)]) {
        [_delegate performSelector:@selector(HotWordClickedWithHotWord:) withObject:model];
    }
}

//清空历史搜索
- (void)deleteAllHistory:(UIButton *)btn {
    USPopView *popView = [[USPopView alloc]initTitle:@"温馨提示" descripton:@"您确定要清空历史搜索吗？" certenBlock:^{
        BOOL result;
        result =  [[VFileMnager sharedInstance] removeAllHistoryCache];
        if (result) {
            [VJDProgressHUD showTextHUD:@"清除成功"];
            [self.datas replaceObjectAtIndex:1 withObject:@[]];
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.cacheDatas removeAllObjects];//全局数组清空
            
        }
    }];
    [popView show];
}

//历史足迹
- (void)moreHistory:(UIButton *)btn {
    ELog(@"历史足迹");
    if ([_delegate respondsToSelector:@selector(moreButtonCliked)]) {
        [_delegate performSelector:@selector(moreButtonCliked) withObject:nil];
    }
}

//历史搜索
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        VScanHistoryModel *model = self.datas[2][indexPath.row];
        if ([_delegate respondsToSelector:@selector(pushDetailControllerWithModel:)]) {
            [_delegate performSelector:@selector(pushDetailControllerWithModel:) withObject:model];
        }
    }else if (indexPath.section == 1) {
        NSArray *array = self.datas[1];//获取到所有天的model数组
        HsearchModel *model = array[indexPath.row];
        if ([_delegate respondsToSelector:@selector(HotWordClickedWithHotWord:)]) {
            [_delegate performSelector:@selector(HotWordClickedWithHotWord:) withObject:model];
        }
    }
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor ylColorWithHexString:@"#f2f2f2"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[VSearchFootPrintCell class] forCellReuseIdentifier:@"thirdView"];
        
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray arrayWithObjects:@[],@[],@[], nil];
    }
    return _datas;
}

- (NSMutableArray *)cacheDatas {
    if (!_cacheDatas) {
        _cacheDatas = [NSMutableArray array];
    }
    return _cacheDatas;
}

@end
