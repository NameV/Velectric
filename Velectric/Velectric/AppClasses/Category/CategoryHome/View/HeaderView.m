//
//  HeaderView.m
//  Velectric
//
//  Created by pengjingli on 16/12/1.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

//图片上面有个button，button跳转的方法
- (IBAction)taoButtonAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:BannerJumpNotification object:nil];
 
}


@end
