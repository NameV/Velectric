//
//  VGoodsCollectCell.h
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VGoodsCollectCellModel;
typedef void(^cancelCollectBlock)(NSInteger index);

@interface VGoodsCollectCell : UITableViewCell

@property (nonatomic, strong) VGoodsCollectCellModel *model;

@property (nonatomic, assign) NSInteger index;          //选中的index
@property (nonatomic, copy) cancelCollectBlock block;   //选中之后的block

@end
