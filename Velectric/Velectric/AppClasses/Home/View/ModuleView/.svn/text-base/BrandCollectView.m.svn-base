//
//  BrandCollectView.m
//  Velectric
//
//  Created by hongzhou on 2017/1/9.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "BrandCollectView.h"

@implementation BrandCollectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self creatUI];
    }
    return  self;
}

-(void)setBrandCollectList:(NSMutableArray<NSString *> *)brandCollectList
{
    _brandCollectList = brandCollectList;
    [self creatUI];
}

#pragma mark - 创建 UI
-(void)creatUI
{
    [self removeAllSubviews];
    CGFloat originX = 10;
    //品牌采集
    UIImage * collectImg = [UIImage imageNamed:@"gougougou"];
    UIImageView * collectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(originX, 5, collectImg.size.width, collectImg.size.height)];
    collectImageV.image = collectImg;
    [self addSubview:collectImageV];
    
    UIView * lastView;
    for (int i=0; i<_brandCollectList.count; i++) {
        UIImage * image = [UIImage imageNamed:@"news1"];
        NSURL * url = [NSURL URLWithString:[_brandCollectList objectAtIndex:i]];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, lastView.bottom + originX, SCREEN_WIDTH - originX*2, (SCREEN_WIDTH - originX*2)/(image.size.width/image.size.height))];
        imageView.layer.cornerRadius = 2;
        imageView.clipsToBounds = YES;
        if (i==0) {
            imageView.frame = CGRectMake(originX, collectImageV.bottom + originX, SCREEN_WIDTH - originX*2, (SCREEN_WIDTH - originX*2)/(image.size.width/image.size.height));
        }
        [imageView sd_setImageWithURL:url placeholderImage:image];
        [self addSubview:imageView];
        lastView = imageView;
    }
    //白色分隔view
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, lastView.bottom, SCREEN_WIDTH, 20)];
    whiteView.backgroundColor = COLOR_FFFFFF;
    [self addSubview:whiteView];
    
    self.frame = CGRectMake(0, self.top, self.width, whiteView.bottom);
    if (_changeFrameBlcok) {
        _changeFrameBlcok();
    }
}

@end
