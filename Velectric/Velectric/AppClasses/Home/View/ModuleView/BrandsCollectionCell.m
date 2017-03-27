//
//  BrandsCollectionCell.m
//  Velectric
//
//  Created by hongzhou on 2017/1/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "BrandsCollectionCell.h"

@implementation BrandsCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat distance = SCREEN_WIDTH/4;
        
        //logo
        _photoView = [[UIImageView  alloc]initWithFrame:CGRectMake(10, 10, distance - 20, distance - 20)];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_photoView];
        
        //横线1
        _horizontalView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, distance, 0.5)];
        _horizontalView1.backgroundColor = COLOR_DDDDDD;
        [self addSubview:_horizontalView1];
        
        //横线2
        _horizontalView2 = [[UIView alloc]initWithFrame:CGRectMake(0, distance, distance, 0.5)];
        _horizontalView2.backgroundColor = COLOR_DDDDDD;
        [self addSubview:_horizontalView2];
        
        //竖线
        UIView * verticalView = [[UIView alloc]initWithFrame:CGRectMake(distance, 0, 0.5, distance)];
        verticalView.backgroundColor = COLOR_DDDDDD;
        [self addSubview:verticalView];
    }
    return self;
}

@end
