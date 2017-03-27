//
//  MineTopCollectionView.m
//  ECardTravel
//
//  Created by zlc on 16/5/11.
//  Copyright © 2016年 LXQ. All rights reserved.
//

#import "MineTopCollectionView.h"
#import "Header.h"
#import "LableCell.h"

#define JFCollectionID1 @"LableCell"


@interface MineTopCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataSource1;

@end

@implementation MineTopCollectionView

+(instancetype)collectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/4,SCREEN_HEIGHT*0.1);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [[self alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor whiteColor];
    self.scrollEnabled = YES;
//    [self registerClass:[LableCell class] forCellWithReuseIdentifier:JFCollectionID1];
    [self registerNib:[UINib nibWithNibName:@"LableCell" bundle:nil] forCellWithReuseIdentifier:@"LableCell"];
}

#pragma mark-代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JFCollectionID1 forIndexPath:indexPath];
    cell.toolLable.text = @"鼓风机";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == 0) {
        if ([self.mtDelegate respondsToSelector:@selector(pushToJiFenWithCollectionView:)]) {
            [self.mtDelegate pushToJiFenWithCollectionView:self];
        }
    }else if (indexPath.item == 1){
        
        if ([self.mtDelegate respondsToSelector:@selector(pushToShangChengWithCollectionView:)]) {
            [self.mtDelegate pushToShangChengWithCollectionView:self];
        }
    }else{
    
        if ([self.mtDelegate respondsToSelector:@selector(pushToHuoDongWithCollectionView:)]) {
            [self.mtDelegate pushToHuoDongWithCollectionView:self];
        }
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){70,50};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 30, 30, 30);
}

#pragma mark-懒加载
- (NSArray *)dataSource1{
    
    if (!_dataSource1) {
        _dataSource1 = [NSArray arrayWithObjects:@{@"title":@"未开通",@"subTitle":@"积分",@"imageName":@"JiFen"},
                       @{@"title":@"商城",@"imageName":@"ShangCheng"},
                       @{@"title":@"活动",@"imageName":@"HuoDong"},nil];
    }
    
    return _dataSource1;
}

@end
