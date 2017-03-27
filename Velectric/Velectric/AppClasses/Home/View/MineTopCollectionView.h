//
//  MineTopCollectionView.h
//  ECardTravel
//
//  Created by zlc on 16/5/11.
//  Copyright © 2016年 LXQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineTopCollectionView;

@protocol MineTopCollectionViewDelegate <NSObject>
//积分
-(void)pushToJiFenWithCollectionView:(MineTopCollectionView *)mineTopCollectionView;

//商城
-(void)pushToShangChengWithCollectionView:(MineTopCollectionView *)mineTopCollectionView;

//活动
-(void)pushToHuoDongWithCollectionView:(MineTopCollectionView *)mineTopCollectionView;


@end

@interface MineTopCollectionView : UICollectionView
@property (nonatomic, copy) NSString *jfCount;//积分账户的积分
@property (nonatomic, weak) id<MineTopCollectionViewDelegate> mtDelegate;
+(instancetype)collectionView;
@end
