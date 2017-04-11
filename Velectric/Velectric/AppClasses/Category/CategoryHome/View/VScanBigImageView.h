//
//  VScanBigImageView.h
//  Velectric
//
//  Created by LYL on 2017/4/11.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VScanBigImageView : UIView

/**
 *  选中的index
 */
@property (nonatomic, assign) NSInteger index;

/* 数据源 */
@property (nonatomic, strong) NSMutableArray *datas;

//浏览大图
@property (nonatomic, strong) UICollectionView *collectionView;

@end
