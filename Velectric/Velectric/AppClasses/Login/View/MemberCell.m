//
//  MemberCell.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)redIconClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(memberCellDelegateAction:)]) {
        [_delegate performSelector:@selector(memberCellDelegateAction:) withObject:btn];
    }
}

@end
