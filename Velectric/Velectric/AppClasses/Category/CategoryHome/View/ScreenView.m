//
//  ScreenView.m
//  Velectric
//
//  Created by QQ on 2016/12/5.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "ScreenView.h"
#import "ChineseString.h"

@implementation ScreenView

- (id)initWithFrame:(CGRect)frame Arr:(NSMutableArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = RGBColor(247, 247, 247);
        self.backgroundColor = RGBColor(247, 247, 247);
        indexList = [NSMutableArray array];
        _selectArr = [NSMutableArray array];
        dataArray = [NSMutableArray array];
        self.muArr = [arr mutableCopy];
        
        [self creatSectionName:arr];
        
        [self creatUI];
       
        [self reloadBrandsView];
    }
    return  self;
}

-(void)creatSectionName:(NSArray *)arr
{
    NSMutableArray * arrName = [NSMutableArray array];
    for (BrandsModel * model  in arr) {
        [arrName addObject:model.brandName];
    }
    [indexList addObjectsFromArray:[ChineseString IndexArray:arrName]];
    NSArray * newNameArray = [ChineseString LetterSortArray:arrName];
    self.seactionArray = newNameArray;
    
    for (NSArray * brandArr in newNameArray) {
        NSMutableArray * muNameArr = [NSMutableArray array];
        for (NSString * name in brandArr) {
            for (BrandsModel * model1 in arr) {
                if ([model1.brandName isEqualToString:name]) {
                    [muNameArr addObject:model1];
                }
            }
        }
        [dataArray addObject:muNameArr];
    }
}

#pragma mark - 重载 品牌view

-(void)reloadBrandsView
{
    CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
    CGFloat btnWidth = (SCREEN_WIDTH - alphaWidth - 40)/3;

    //移除旧的按钮
    for (UIView * obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }
    
    UIView * lastBtn;
    //添加按钮
    for (int i=0; i<self.selectArr.count; i++) {
        BrandsModel * model = [self.selectArr objectAtIndex:i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10+(i%3)*(btnWidth + 10), 64 + 40 + 40*(i/3), btnWidth, 30)];
        [self addSubview:button];
        [button addTarget:self action:@selector(deleteSelectBrands:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = Font_1_F13;
        button.layer.cornerRadius = 2;
        button.tag = i;
        UIImage * image = [UIImage imageNamed:@"X"];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.width - 5 -image.size.width, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width * 1.3, 0, image.size.width +5);
        
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:model.brandName forState:UIControlStateNormal];
        button.backgroundColor = COLOR_FFFFFF;
        [button setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        lastBtn = button;
    }
    
    
    //已经有选中的品牌
    if (_selectArr.count == 0) {
        _selectLab.hidden = YES;
        //改变frame
        self.btnView.frame = CGRectMake(self.btnView.left, 64, self.btnView.width, self.btnView.height);
        
        CGRect rect = CGRectMake(0, self.btnView.bottom, SCREEN_WIDTH - alphaWidth, SCREEN_HEIGHT - self.btn.bottom);
        self.tableView.frame = rect;
        self.tableView2.frame = rect;
    }else{
        _selectLab.hidden = NO;
        
        self.btnView.frame = CGRectMake(self.btnView.left, lastBtn.bottom + 10, self.btnView.width, self.btnView.height);
        
        CGRect rect = CGRectMake(0, self.btnView.bottom, SCREEN_WIDTH - alphaWidth, SCREEN_HEIGHT - self.btn.bottom);
        self.tableView.frame = rect;
        self.tableView2.frame = rect;
    }
}

#pragma mark 删除选中的品牌
-(void)deleteSelectBrands:(UIButton *)btn
{
    BrandsModel * model = [_selectArr objectAtIndex:btn.tag];
    model.isSelect = !model.isSelect;
    [_selectArr removeObject:model];
    [self reloadBrandsView];
    
    if (self.tableView.hidden) {
        [self.tableView2 reloadData];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - 创建UI
-(void)creatUI
{
    for (BrandsModel * model in self.muArr) {
        if (model.isSelect) {
            [self.selectArr addObject:model];
        }
    }
    
    CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-alphaWidth, 64)];
    navView .backgroundColor = [UIColor blackColor];
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 26, 30, 30)];
    [backBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"backJianTou-1"] forState:UIControlStateNormal];
    self.backBtn = backBtn;
    [navView addSubview:backBtn];
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-115, 23, 50, 40)];
    self.sureBtn = sureBtn;
    [sureBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [navView addSubview:sureBtn];
    [self addSubview:navView];
    
    _selectLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-alphaWidth, 40)];
    _selectLab.text = @"您已选择";
    _selectLab.textColor = COLOR_666666;
    _selectLab.font = Font_1_F15;
    _selectLab.textAlignment = NSTextAlignmentCenter;
    _selectLab.hidden = YES;
    [self addSubview:_selectLab];
    
    _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 180,SCREEN_WIDTH-alphaWidth, 44)];
    [self addSubview:_btnView];
    _btnView.backgroundColor = COLOR_FFFFFF;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.15, 0,self.frame.size.width*0.25, 44)];
    self.btn = btn;
    [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"推荐品牌" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:RGBColor(242, 182, 42)  forState:UIControlStateNormal];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.5,0,self.frame.size.width*0.25 , 44)];
    [btn2 setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    self.btn2 = btn2;
    [btn2 addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"字母排序" forState:UIControlStateNormal];
    [_btnView addSubview:btn];
    [_btnView addSubview:btn2];
    
    UIView * _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _btnView.height - 0.5, _btnView.width, 0.5)];
    _lineView.backgroundColor = COLOR_DDDDDD;
    [_btnView addSubview:_lineView];
    
    //创建一个tableView
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH-alphaWidth, SCREEN_HEIGHT-180)];
    tableView.hidden = NO;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    
    UITableView * tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH-alphaWidth, SCREEN_HEIGHT-150)];
    self.tableView2 = tableView2;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    tableView2.hidden = YES;
    [self addSubview:tableView2];
}

//导航栏确定点击方法
-(void)btnTouch:(UIButton *)btn
{
    if (btn == self.btn) {
        self.tableView.hidden = NO;
        self.tableView2.hidden = YES;
        btn.titleLabel.textColor =RGBColor(242, 182, 42);
        self.btn2.titleLabel.textColor = COLOR_666666;

    }else if(btn == self.btn2){
        self.tableView.hidden = YES;
        self.tableView2.hidden =NO;
        btn.titleLabel.textColor =RGBColor(242, 182, 42) ;
        self.btn.titleLabel.textColor =COLOR_666666;

    }else if (btn == self.sureBtn){
        if (_selectArr.count) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sendAndBack:)]) {
                [self.delegate sendAndBack:_selectArr];
            }
        }else{
            [VJDProgressHUD showTextHUD:@"请选择品牌"];
            return;

        }
    }else if (btn == self.backBtn){
        if (self.delegate && [self.delegate respondsToSelector:@selector(backRootViewController)]) {
            [self.delegate backRootViewController];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tableView) {
        
        return 1;
    }else{
        
        return self.seactionArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        return self.muArr.count;
    }
    NSArray * arrmodel = dataArray[section];
    return arrmodel.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);//分割线左靠边
    tableView.layoutMargins = UIEdgeInsetsMake(0, 5, 0, 0);
    tableView.cellLayoutMarginsFollowReadableWidth = false;
    BrandsModel * model;
    if (tableView==self.tableView) {
        model = _muArr[indexPath.row];
    }else{
        NSArray * arrmodel = dataArray[indexPath.section];
        model = arrmodel[indexPath.row];
    }
    if (model.isSelect) {
        cell.textLabel.textColor =RGBColor(242, 182, 42);
    }else{
        cell.textLabel.textColor =RGBColor(155, 155, 155);
    }
    cell.textLabel.text = model.brandName;
    
    if (model.isSelect) {
        cell.imageView.image = [UIImage imageNamed:@"yixuan"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"weixuan"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    BrandsModel * model;
    if (tableView==self.tableView) {
        model = _muArr[indexPath.row];
    }else{
        NSArray * arrmodel = dataArray[indexPath.section];
        model = arrmodel[indexPath.row];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.selectArr.count>4&& !model.isSelect) {
        [VJDProgressHUD showTextHUD:@"最多只能选择5项"];
        return;
    }
    if (model.isSelect) {
        model.isSelect = NO;
        if ([self.selectArr containsObject:model]) {
            [self.selectArr removeObject:model];
            cell.textLabel.textColor = [UIColor redColor];
        }
    }else{
        model.isSelect = YES;
        [self.selectArr addObject:model];
        cell.textLabel.textColor= RGBColor(241, 182, 42);
    }
      [self.tableView reloadData];
      [self.tableView2 reloadData];
      [self reloadBrandsView];


}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if (tableView == self.tableView) {
        return 0;
    }else{
    return indexList;
        
     }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==self.tableView) {
        return 0;
    }else{
    return SCREEN_HEIGHT *0.06;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView2) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        view.backgroundColor = COLOR_F7F7F7;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 100, 25)];
        label.text = indexList[section];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = COLOR_666666;
        [view addSubview:label];

        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}


@end
