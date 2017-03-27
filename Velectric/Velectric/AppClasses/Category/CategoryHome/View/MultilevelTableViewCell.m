//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "MultilevelTableViewCell.h"

@implementation MultilevelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setZero{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins=UIEdgeInsetsZero;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset=UIEdgeInsetsZero;
    }

}
@end
