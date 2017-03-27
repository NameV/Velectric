//
//  VSelectAllView.m
//  Velectric
//
//  Created by LYL on 2017/3/2.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSelectAllView.h"

@interface VSelectAllView ()



@end

@implementation VSelectAllView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor ylColorWithHexString:@"#666666"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.selectAllBtn];
    [self addSubview:self.deleteBtn];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.height.equalTo(self);
        make.width.mas_equalTo(125);
    }];
    
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.height.equalTo(self);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark - getter

- (UIButton *)selectAllBtn {
    if (!_selectAllBtn) {
        _selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_selectAllBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    }
    return _selectAllBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:V_ORANGE_COLOR];
    }
    return _deleteBtn;
}

@end
