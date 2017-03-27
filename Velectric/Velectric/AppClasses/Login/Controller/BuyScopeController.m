//
//  BuyScopeController.m
//  Velectric
//
//  Created by QQ on 2016/11/23.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BuyScopeController.h"
#import "ScopeViewController.h"
#import "MemberCell.h"

@interface BuyScopeController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArray;
    NSArray *dataArray1;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UITableView * tableView1;
@property (nonatomic, strong)NSMutableArray *tableArray; //记录选中的二级物品
@property (nonatomic, assign)BOOL isSelect;//是否选中过cell


@end

@implementation BuyScopeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(247, 247, 247);;
    self.title = @"经营范围";
    NSMutableArray * mutableArray = [NSMutableArray array];
    self.tableArray = mutableArray;
     dataArray = @[@{@"str":@"五金工具"},@{@"str":@"机电设备"},@{@"str":@"电器电缆"},@{@"str":@"密封保温"},@{@"str":@"水暖建材"},@{@"str":@"仪器仪表"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"}];
    dataArray1 = @[@{@"str":@"五金工具"},@{@"str":@"机电设备"},@{@"str":@"电器电缆"},@{@"str":@"密封保温"},@{@"str":@"水暖建材"},@{@"str":@"仪器仪表"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"}];
    
    [self creatUI];

}
-(void)creatUI
{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 140, SCREEN_HEIGHT*0.64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
//
    
    UITableView * tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(140,0, SCREEN_WIDTH-100,SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [self.view addSubview:tableView1];
    self.tableView1 = tableView1;

    
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
     [self.tableView1 selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    UIButton * quanBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.view addSubview:quanBtn];
    [quanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.offset(49);
        make.width.offset(109);
        make.left.mas_equalTo(self.tableView.mas_right);
    }];
    [quanBtn setTitle:@"全选" forState:UIControlStateNormal];
    [quanBtn setTitleColor:RGBColor(63, 58, 57) forState:UIControlStateNormal];
    quanBtn.backgroundColor = RGBColor(247, 247, 247);
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.offset(49);
        make.left.mas_equalTo(quanBtn.mas_right);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = RGBColor(242, 182, 2);

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== self.tableView) {
        return dataArray.count;
    }else{
        return dataArray1.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==self.tableView) {
        static NSString * identifier = @"ID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectedBackgroundView= [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor= RGBColor(242, 182, 2);
        cell.backgroundColor = RGBColor(247, 247, 247);
        NSDictionary * dic = dataArray[indexPath.row];
        cell.textLabel.textColor =RGBColor(102, 102, 102);
        cell.textLabel.text = dic[@"str"];
        return cell;
        }else{
            static NSString * identifier = @"listCell";
            MemberCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberCell" owner:self options:nil]objectAtIndex:1];
            if (cell.isSelect) {
                cell.listLable.textColor = [UIColor blueColor];
            }else{
                cell.listLable.textColor = [UIColor redColor];
            }
            NSDictionary * dic = dataArray1[indexPath.row];
            cell.listLable.text = dic[@"str"];
            cell.listImageView.image =nil;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView&&indexPath.row==0) {
        dataArray1 =@[@{@"str":@"五金工具"},@{@"str":@"机电设备"},@{@"str":@"电器电缆"},@{@"str":@"密封保温"},@{@"str":@"水暖建材"},@{@"str":@"仪器仪表"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"}];
        [self.tableView1 reloadData];
        
    }else if (tableView==self.tableView&&indexPath.row==1) {
        dataArray1 =@[@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"},@{@"str":@"水暖建材"},@{@"str":@"仪器"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"},@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"}];
        [self.tableView1 reloadData];
    }else if (tableView==self.tableView&&indexPath.row==2) {
        dataArray1 =@[@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"},@{@"str":@"水暖建材"},@{@"str":@"仪器"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"},@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"}];
        [self.tableView1 reloadData];
    }else if (tableView==self.tableView&&indexPath.row==3) {
        dataArray1 =@[@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"},@{@"str":@"水暖建材"},@{@"str":@"仪器"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"},@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"}];
        [self.tableView1 reloadData];
    }else if (tableView==self.tableView&&indexPath.row==4) {
        dataArray1 =@[@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"},@{@"str":@"水暖建材"},@{@"str":@"仪器"},@{@"str":@"劳保安防"},@{@"str":@"轴承标准件"},@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"}];
        [self.tableView1 reloadData];
    }else if (tableView==self.tableView&&indexPath.row==5) {
        dataArray1 =@[@{@"str":@"工具"},@{@"str":@"设备"},@{@"str":@"电器电缆"},@{@"str":@"密封"},@{@"str":@"水暖建材"}];
        [self.tableView1 reloadData];
    }

    if (tableView== self.tableView1) {
        MemberCell *cell = (MemberCell *)[tableView cellForRowAtIndexPath:indexPath];

        NSDictionary*dic = dataArray1[indexPath.row];
        if ([self.tableArray containsObject:dic]) {
            cell.isSelect = NO;
            [self.tableArray removeObject:dic];
            [self.tableView1 reloadData];
        }else{
            cell.isSelect = YES;
            [self.tableArray addObject:dic];
            [self.tableView1 reloadData];
         }
        ELog(@"%@", self.tableArray);
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"111");
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT*0.08;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
