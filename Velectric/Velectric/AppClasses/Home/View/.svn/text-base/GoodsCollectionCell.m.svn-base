//
//  GoodsCollectionCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/17.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "GoodsCollectionCell.h"
#import "HomeHotGoodsModel.h"

@implementation GoodsCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
        _nameLab.textColor = COLOR_1A1A1A;
        _nameLab.font = Font_1_F12;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLab];
        
        _photoView = [[UIImageView  alloc]initWithFrame:CGRectMake(22, 30, self.width - 44, self.width - 44)];
        _photoView.clipsToBounds = YES;
        [self.contentView addSubview:_photoView];
        
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _photoView.bottom, self.width, 20)];
        _priceLab.textColor = COLOR_999999;
        _priceLab.font = Font_1_F12;
        _priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLab];
        
        _fengeLine = [[UIView alloc]initWithFrame:CGRectMake(self.width - 0.5, 0, 0.5, self.height)];
        _fengeLine.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_fengeLine];
    }
    return self;
}

-(void)setGoodsModel:(HomeGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    NSURL * picUrl = [NSURL URLWithString:CreateRequestApiPictureUrl(goodsModel.pictureUrl)];
    [self.photoView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLab.text = goodsModel.name;
    self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",goodsModel.minPrice];
}

@end
