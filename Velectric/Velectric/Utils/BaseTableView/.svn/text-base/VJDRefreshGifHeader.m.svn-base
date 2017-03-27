//
//  VJDRefreshGifHeader.m
//  Velectric
//
//  Created by hongzhou on 2016/12/13.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "VJDRefreshGifHeader.h"

@implementation VJDRefreshGifHeader

- (void)prepare
{
    [super prepare];
    
    // 设置下拉状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld", i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [pullingImages addObject:image];
    }
    [self setImages:pullingImages forState:MJRefreshStateIdle];
    
    
    // 设置刷新状态的动画图片（刷新）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld",i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [refreshingImages addObject:image];
    }
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
