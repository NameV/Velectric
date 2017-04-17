//
//  BuyScoreView.m
//  Velectric
//
//  Created by QQ on 2016/11/28.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BuyScoreView.h"
#import "MemberCell.h"

@implementation BuyScoreView{
    NSInteger _currentIndex;//当前选中的分类index
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = RGBColor(247, 247, 247);;
        [self creatjingYingScore];
        [self updataNetWorking];
    }
    return  self;
}
//请求网络数据
-(void)updataNetWorking
{
    [self initDataCategoryId:@"1"];
}

//一级分类
- (void)initDataCategoryId:(NSString *)categoryId{
        [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters = @{@"categoryId":categoryId
                                  };
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *respronseObject) {
        ELog(@"成功");
        if (dataArray) {
            dataArray = respronseObject[@"result"][@"children"];
            //[VJDProgressHUD showTextHUD:@"请求成功"];
            [VJDProgressHUD dismissHUD];
        }else{
            [VJDProgressHUD showTextHUD:@"数据请求错误，请稍后重试"];
            return ;
        }
        [self.tableView2 reloadData];
        [self creatMoRen];
        [self categoryTwoNetworkingCategoryId:dataArray[0][@"id"]];

        } failure:^(NSError *error) {
        ELog(@"失败");
            [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    }];
    
}
-(void)creatMoRen
{
    if (dataArray) {
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView2 selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
//二级分类

-(void)categoryTwoNetworkingCategoryId:(NSString *)categoryId
{
    NSDictionary * parameters = @{@"categoryId":categoryId};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        dataArray1 = responseObject[@"result"][@"children"];
        [self.tableView1 reloadData];
        if (dataArray1.count*SCREEN_HEIGHT*0.08>=SCREEN_HEIGHT-64-49) {
            _tableView1.frame = CGRectMake(SCREEN_WIDTH*0.32,0, SCREEN_WIDTH*0.64,SCREEN_HEIGHT-64-49);
        }else{
        _tableView1.frame = CGRectMake(SCREEN_WIDTH*0.32,0, SCREEN_WIDTH*0.64,dataArray1.count*SCREEN_HEIGHT*0.08);
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}
-(void)creatjingYingScore
{
  
    self.backgroundColor = RGBColor(247, 247, 247);;
    NSMutableArray * mutableArray = [NSMutableArray array];
    self.tableArray = mutableArray;
    dataArray = [NSArray array];
    dataArray1 = [NSArray array];

    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.32, SCREEN_HEIGHT*0.64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView2 = tableView;
    
    //
    
    UITableView * tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.32,0, SCREEN_WIDTH*0.64,0) style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [self addSubview:tableView1];
    self.tableView1 = tableView1;
   
    UIButton * quanBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tableView2.frame),self.frame.size.height-49, SCREEN_WIDTH*0.32, 49)];
    [self addSubview:quanBtn];
    [quanBtn addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [quanBtn setTitle:@"全选" forState:UIControlStateNormal];
    [quanBtn setTitleColor:RGBColor(63, 58, 57) forState:UIControlStateNormal];
    [quanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -100, 0,-50)];
    [quanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -90, 0, -50)];
    [quanBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];

    quanBtn.tag = 1001;
    quanBtn.backgroundColor = RGBColor(247, 247, 247);
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(quanBtn.frame),self.frame.size.height-49, SCREEN_WIDTH*0.32, 49)];
    [self addSubview:sureBtn];
     [sureBtn addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag = 1002;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = RGBColor(242, 182, 2);
}

-(void)buttonTouch:(UIButton *)btn
{
    if (btn.tag == 1002) {
        ELog(@"确定");
        if (self.delegate && [self.delegate respondsToSelector:@selector(backRootViewController)]) {
            [self.delegate backRootViewController];
        }
        NSString * manaerStr = nil;
        NSString * myId = nil;
        for (NSDictionary * managerDic in self.tableArray) {
            NSString * dicStr = managerDic[@"name"];
            NSString * dicId = managerDic [@"id"];
            if (manaerStr) {
                manaerStr = [NSString stringWithFormat:@"%@,%@",manaerStr,dicStr];
            }else{
                manaerStr =dicStr;
            }
            if (myId) {
                myId = [NSString stringWithFormat:@"%@,%@",myId,dicId];
            }else{
                myId = dicId;
            }
        }
        
        if (_buyScreeningBlcok) {
            _buyScreeningBlcok(manaerStr,myId);
        }
        
    }else if (btn.tag==1001){
        
        self.isSelect = !self.isSelect;
        if (self.isSelect) {
            [btn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
            self.tableArray = [NSMutableArray arrayWithArray:dataArray1];
        }else{
            [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
            [self.tableArray removeAllObjects];
        }
        
        [self.tableView1 reloadData];
        ELog(@"全选");
        if (self.delegate && [self.delegate respondsToSelector:@selector(allThingSelect)]) {
            [self.delegate allThingSelect];
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== self.tableView2) {
        return dataArray.count;
    }else{
        return dataArray1.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==self.tableView2) {
        static NSString * identifier = @"ID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectedBackgroundView= [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor= COLOR_F2B602;
        cell.backgroundColor = RGBColor(247, 247, 247);
        NSDictionary * dic = dataArray[indexPath.row];
        cell.textLabel.textColor =RGBColor(102, 102, 102);
        cell.textLabel.text = dic[@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;
    }else{
        
        static NSString * identifier = @"listCell";
        MemberCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberCell" owner:self options:nil]objectAtIndex:1];
        if (self.isSelect) {
            cell.listLable.textColor = RGBColor(242, 182, 2);
        }else{
            cell.listLable.textColor = RGBColor(102, 102, 102);
        }
        NSDictionary * dic = dataArray1[indexPath.row];
        cell.listLable.tag = indexPath.row+10;
        cell.listLable.text = [NSString stringWithFormat:@"   %@",dic[@"name"]];
        cell.listImageView.image =nil;
        cell.listLable.font = [UIFont systemFontOfSize:13];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.tableView2) {
        if (_currentIndex == indexPath.row) {
            return;
        }
        //切换左面的分类，右面的数组清空
        self.isSelect = NO;
        [self.tableArray removeAllObjects];
        NSDictionary * dic = dataArray[indexPath.row];
        [self categoryTwoNetworkingCategoryId:dic[@"id"]];
        [self.tableView1 reloadData];
        self.name = dic[@"name"];
        _currentIndex = indexPath.row;
    }
    
    if (tableView== self.tableView1) {
        UILabel *find_label = (UILabel *)[self viewWithTag:indexPath.row+10];
        NSDictionary*dic = dataArray1[indexPath.row];
        if ([self.tableArray containsObject:dic]) {
            [self.tableArray removeObject:dic];
            find_label.textColor = COLOR_666666;
        }else{
            [self.tableArray addObject:dic];
            find_label.textColor = RGBColor(241, 182, 42);
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT*0.08;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.tableView1) {
        return 0;
    }
    return 0;
}


@end
