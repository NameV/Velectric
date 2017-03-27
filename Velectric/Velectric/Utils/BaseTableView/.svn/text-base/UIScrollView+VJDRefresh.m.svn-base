//
//  UIScrollView+VJDRefresh.m
//  Velectric
//
//  Created by hongzhou on 2016/12/13.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "UIScrollView+VJDRefresh.h"
#import <MJRefresh.h>
#import "VJDRefreshGifHeader.h"

@implementation UIScrollView (VJDRefresh)

-(void)addHeaderWithTarget:(id)target action:(SEL)action
{
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld", i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [pullingImages addObject:image];
    }
    [header setImages:pullingImages forState:MJRefreshStateIdle];
    
    // 设置刷新状态的动画图片（刷新）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld",i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [refreshingImages addObject:image];
    }
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.mj_header=header;
}

-(void)headerBeginRefreshing
{
    [self.mj_header beginRefreshing];
}

-(void)headerEndRefreshing
{
    [self.mj_header endRefreshing];
}

-(void)removeHeader
{
    [self.mj_header removeFromSuperview];
    self.mj_header = nil;
}

-(void)addFooterWithTarget:(id)target action:(SEL)action
{
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:target refreshingAction:action];
    // 隐藏时间
    footer.refreshingTitleHidden = YES;
    // 隐藏状态
    footer.stateLabel.hidden = YES;
    
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld", i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [pullingImages addObject:image];
    }
    [footer setImages:pullingImages forState:MJRefreshStateIdle];
    
    // 设置刷新状态的动画图片（刷新）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        NSString *animationImageNameStr = [NSString stringWithFormat:@"loading%ld",i];
        UIImage *image = [UIImage imageNamed:animationImageNameStr];
        [refreshingImages addObject:image];
    }
    [footer setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.mj_footer = footer;
    
//    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
//    self.mj_footer.hidden = YES;
}

-(void)footerEndRefreshing
{
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = NO;
}

-(void)footerBeginRefreshing
{
    [self.mj_footer beginRefreshing];
}

-(void)removeFooter
{
    [self.mj_footer removeFromSuperview];
    self.mj_footer=nil;
}

@end
