//
//  VJDToolbarView.m
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "VJDToolbarView.h"

@implementation VJDToolbarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        _orderByType = OrderBy_Down;
    }
    return self;
}

-(void)setItemsList:(NSArray *)itemsList
{
    _itemsList = itemsList;
    [self creatSubviews];
}

#pragma mark - 创建子视图
-(void)creatSubviews
{
    CGFloat btnWidth = SCREEN_WIDTH / _itemsList.count;
    for (int i=0; i<_itemsList.count; i++) {
        NSDictionary * dic = [_itemsList objectAtIndex:i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * btnWidth, 0, btnWidth-1, self.height);
        button.titleLabel.font = Font_1_F15;
        button.tag = i;
        
        [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        NSString * title = [dic objectForKey:@"text"];
        [button setTitle:title forState:UIControlStateNormal];
        NSString * imageName = [dic objectForKey:@"icon"];
        if (imageName) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            UIImage * image = [UIImage imageNamed:imageName];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.width/2 + 15, 0, 0);
            [button setImage:image forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 20-image.size.width, 0, 0);
        }
        if (i==1) {
            [button setImage:[UIImage imageNamed:@"orderbydown"] forState:UIControlStateNormal];
        }
        if (i==3) {
            [button setImage:[UIImage imageNamed:@"shaixuaned"] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

#pragma mark - 按钮点击事件
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        
    }else if (sender.tag == 1){
        if (_isChangeStatus) {
            if (_orderByType == OrderBy_Down) {
                _orderByType = OrderBy_Up;
                [sender setImage:[UIImage imageNamed:@"orderbyup"] forState:UIControlStateNormal];
            }else if (_orderByType == OrderBy_Up){
                _orderByType = OrderBy_Down;
                [sender setImage:[UIImage imageNamed:@"orderbydown"] forState:UIControlStateNormal];
            }
            //TODO YHZ
//            else if (_orderByType == OrderBy_Down){
//                _orderByType = OrderBy_NO;
//                [sender setImage:[UIImage imageNamed:@"orderbyno"] forState:UIControlStateNormal];
//            }
        }
    }
    else if (sender.tag == 2){
        
    }
    else if (sender.tag == 3){
        if (_isChangeStatus) {
            //TODO YHZ
//            UIImage * image = [UIImage imageNamed:@"shaixuaned"];
//            if ([sender.currentImage isEqual:image]) {
//                [sender setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
//            }else{
//                [sender setImage:[UIImage imageNamed:@"shaixuaned"] forState:UIControlStateNormal];
//            }
        }
    }
    if (_toolbarViewBlock) {
        _toolbarViewBlock(sender.tag,_orderByType);
    }
}

@end
