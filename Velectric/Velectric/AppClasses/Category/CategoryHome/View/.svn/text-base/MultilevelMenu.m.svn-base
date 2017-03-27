//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "MultilevelMenu.h"
#import "MultilevelTableViewCell.h"
#import "MultilevelCollectionViewCell.h"
#import "CategoryMeunModel.h"
#import "UIImageView+WebCache.h"
#import "FactoryViewController.h"
#import "CategoryViewController.h"

#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kHeaderView   @"HeaderView"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface MultilevelMenu()
{
    NSMutableArray * firstData;
    NSMutableArray * twoData;
    NSMutableArray * threeData;
    NSInteger _currentIndex;//当前选中的index
}

@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@property (nonatomic, strong)UIImageView * headView;



@property (nonatomic, strong)UICollectionReusableView *view;

@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign)NSInteger isSelectNum;

@end
@implementation MultilevelMenu

-(id)initWithFrame:(CGRect)frame FirstData:(NSMutableArray *)firstdata TwoData:(NSMutableArray *)twodata ThreeData:(NSMutableArray *)threedata withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    
    if (self  == [super initWithFrame:frame]) {
//        if (firstdata.count==0||twodata==0||threedata==0) {
//            return nil;
//        }
        _block=selectIndex;
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
        self.leftBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor=[UIColor blackColor];
        
//        _selectIndex=0;
        firstData = firstdata;
        twoData = twodata;
        threeData = threedata;
//        self.needToScorllerIndex =0;
        self.backgroundColor =UIColorFromRGB(0xF3F4F6);
        
        /**
         左边的视图
         */
        UITableView * tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height) style:UITableViewStylePlain];
        self.leftTablew = tableView;
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        
        
        /**
         右边的视图
         */
        self.flowLayout=[[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing=0.1;//左右间隔
        _flowLayout.minimumLineSpacing=0.1;
        _flowLayout.headerReferenceSize = CGSizeMake(375, 200);
        //        flowLayout.footerReferenceSize = CGSizeMake(375, 100);
        float leftMargin =0;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin+8,8,kScreenWidth-kLeftWidth-leftMargin*2-14,frame.size.height-84) collectionViewLayout:_flowLayout];
        self.rightCollection.backgroundColor =self.leftBgColor;
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        
        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        UINib *head=[UINib nibWithNibName:kHeaderView bundle:nil];
        [self.rightCollection registerNib:head
               forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView];
        
        [self addSubview:self.rightCollection];
        
        self.isReturnLastOffset=YES;
        
        self.rightCollection.backgroundColor=self.leftSelectBgColor;
        
//        self.backgroundColor=self.leftSelectBgColor;
        
    }
    return self;
}

-(void)reloadDataFirstData:(NSMutableArray *)firstdata TwoData:(NSMutableArray *)twodata ThreeData:(NSMutableArray *)threedata{
    firstData = firstdata;
    twoData = twodata;
    threeData =threedata;
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
    //数据请求之后，让左侧tableview可以点击
    self.leftTablew.userInteractionEnabled = YES;
}
#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark--dcollectionView里有多少个组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return firstData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor=tableView.separatorColor;
        [cell addSubview:label];
        label.tag=100;
    }
    
    if (self.isSelectNum==indexPath.row) {
        cell.backgroundColor = RGBColor(247, 247, 247);
        cell.titile.textColor = RGBColor(242, 182, 2);

    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.titile.textColor = RGBColor(102, 102, 102);

    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary * dic = firstData[indexPath.row];
    cell.titile.text=dic[@"name"];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击当前行，不刷新界面
    if (indexPath.row == _currentIndex) {
        return;
    }
    
    //点击之后请求数据，让tableview不可点击
    self.leftTablew.userInteractionEnabled = NO;
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    cell.titile.textColor=self.leftSelectColor;
    cell.backgroundColor=self.leftSelectBgColor;
    _selectIndex=indexPath.row;
    CategoryMeunModel * title=self.allData[indexPath.row];
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=cell.backgroundColor;
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset=NO;
    [self.rightCollection reloadData];
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    else{
         [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    NSDictionary * dic = firstData[indexPath.row];
    [self.delegate passTrendValues:dic[@"id"]];
    self.needToScorllerIndex = indexPath.row;
    self.isSelectNum = indexPath.row;
    
    _currentIndex = indexPath.row;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.titile.textColor=self.leftUnSelectColor;
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=tableView.separatorColor;

    cell.backgroundColor=self.leftUnSelectBgColor;
}

#pragma mark---imageCollectionView-------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (twoData.count==0) {
        return 0;
    }
    return twoData.count-1;
}
#pragma mark---每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray * collectDataArray = threeData[section];
    
    return collectDataArray.count;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryMeunModel * title=self.allData[self.selectIndex];
    CategoryMeunModel * meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        NSArray * list=meun.nextArray;
        meun=list[indexPath.row];
    }
    NSMutableArray * collectArr = threeData[indexPath.section];
    NSDictionary * dic = collectArr[indexPath.row];
    NSInteger categoryId =[dic[@"id"] integerValue];
    NSString * categoryName = dic[@"name"];
    void (^select)(NSInteger left,NSInteger right,id info) = self.block;
    select(self.selectIndex,categoryId,categoryName);
}

#pragma mark---定义并返回每个cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    NSMutableArray * collectDataArray = threeData[indexPath.section];
    NSDictionary *dic = collectDataArray[indexPath.row];
    cell.titile.text=dic[@"name"];
    NSString *imageURL = [dic.allKeys containsObject:@"pictureUrl"] ? dic[@"pictureUrl"] : @"";
    NSString *absolutUrl = [NSString stringWithFormat:@"%@%@",V_Base_ImageURL,imageURL];
    [cell.kImageName sd_setImageWithURL:[NSURL URLWithString:absolutUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];//TODO
    return cell;
}

#pragma mark---定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    self.headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderView forIndexPath:indexPath];
    NSDictionary * dic = twoData[indexPath.section];
    self.headview.label.text = dic[@"name"];
    self.headview.allBtn.tag = indexPath.section;
    self.headview.imageView.image = [UIImage imageNamed:@"categoryPic"];
    [self.headview.allBtn addTarget:self action:@selector(allBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    return self.headview;
}


-(void)allBtnTouch:(UIButton *)btn
{
    NSDictionary * dic = twoData[btn.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(BtnPush:)]) {
        [self.delegate BtnPush:dic];
    }
}

#pragma mark---UICollectionViewDelegateFlowLayout 是UICollectionViewDelegate的子协议
#pragma mark---每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake((SCREEN_WIDTH-115)/3,SCREEN_HEIGHT*0.065);
    return CGSizeMake((SCREEN_WIDTH-115)/3,SCREEN_HEIGHT*0.12);
    
}

#pragma mark---设置cell的边界, 具体看下图
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 0, 35, 0);
}
#pragma mark---cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 9;
}
#pragma mark---
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(kScreenWidth, SCREEN_WIDTH*0.33);
    }else{
        return CGSizeMake(kScreenWidth, 45);
        
    }
}





@end




