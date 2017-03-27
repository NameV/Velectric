//
//  HeaderNewView.m
//  Velectric
//
//  Created by hongzhou on 2017/1/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "HeaderNewView.h"
#import "NewHeaderModel.h"

@implementation HeaderNewView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _newsList = [NSMutableArray array];
        _newsLabList = [NSMutableArray array];
        //创建UI
        [self creatUI];
    }
    return  self;
}

#pragma mark - 创建UI
-(void)creatUI
{
    [self removeAllSubviews];
    //机电头条图片
    UIImage * image1 = [UIImage imageNamed:@"toutiao"];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, image1.size.width - 20, self.height - 10)];
    headImage.contentMode = UIViewContentModeScaleAspectFit;
    headImage.image = image1;
    [self addSubview:headImage];
    
    //分割线
    UIView * fengeView1 = [[UIView alloc]initWithFrame:CGRectMake(headImage.right + 10, 14, 0.5, 17)];
    fengeView1.backgroundColor = COLOR_DDDDDD;
    [self addSubview:fengeView1];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(fengeView1.right + 10, 0, SCREEN_WIDTH - fengeView1.right - 20, self.height)];
    _scrollView.scrollEnabled = NO;
    [self addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width, _scrollView.height*_newsList.count);
    
    for (int i=0; i<_newsList.count; i++) {
        NewHeaderModel * model = [_newsList objectAtIndex:i];
        //标题
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, i*_scrollView.height, _scrollView.width, _scrollView.height)];
        titleLab.textColor = COLOR_666666;
        titleLab.font = Font_1_F12;
        titleLab.text = model.title;
        [_scrollView addSubview:titleLab];
        [_newsLabList addObject:titleLab];
    }
    //灰色线条
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = COLOR_DDDDDD;
    [self addSubview:bottomLine];
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doCycleScroll) userInfo:nil repeats:YES];
    //加入主循环池中
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
}

#pragma mark - 进行上下滚动
-(void)doCycleScroll
{
    CGFloat offsety = _scrollView.contentOffset.y;
    offsety += _scrollView.height;
    [_scrollView setContentOffset:CGPointMake(0, offsety) animated:YES];
    if (offsety == _scrollView.contentSize.height) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

-(void)setNewsList:(NSMutableArray *)newsList
{
    _newsList = newsList;
    [_timer invalidate];
    _timer = nil;
    [self creatUI];
}

#pragma mark - 重载scrollView
-(void)reloadScrollView
{
    for (int i=0; i<_newsLabList.count; i++) {
        //标题
        UILabel * titleLab = [_newsLabList objectAtIndex:i];
        titleLab.frame = CGRectMake(0, i*_scrollView.height, _scrollView.width, _scrollView.height);
    }
}

@end
