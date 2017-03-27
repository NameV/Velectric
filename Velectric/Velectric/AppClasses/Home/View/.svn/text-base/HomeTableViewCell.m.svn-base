//
//  HomeTableViewCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/17.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _typeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, (SCREEN_WIDTH - 30)/3/(125.0/140.0))];
        _typeLab.textColor = COLOR_FFFFFF;
        _typeLab.font = Font_1_F15;
        _typeLab.numberOfLines = 0;
        _typeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_typeLab];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_typeLab.right, 0, SCREEN_WIDTH - _typeLab.right, _typeLab.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = COLOR_FFFFFF;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_collectionView];
        
        _showMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 15, 30, _typeLab.height - 30)];
        [_showMoreBtn setTitle:@"查\n看\n更\n多" forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.numberOfLines = 0;
        _showMoreBtn.titleLabel.font = Font_1_F12;
        _showMoreBtn.backgroundColor = COLOR_333333_A(0.4);
        [self.contentView addSubview:_showMoreBtn];
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _typeLab.bottom-0.5, SCREEN_WIDTH, 0.5)];
        _bottomLine.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_bottomLine];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
