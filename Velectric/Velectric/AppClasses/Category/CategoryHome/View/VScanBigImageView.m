//
//  VScanBigImageView.m
//  Velectric
//
//  Created by LYL on 2017/4/11.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VScanBigImageView.h"
#import "VBigImageCell.h"

@interface VScanBigImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/* 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation VScanBigImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configViews];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)configViews {
    [self addSubview:self.collectionView];
    [self addSubview:self.titleLabel];
}

#pragma mark - setter

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    //滚动到相应的位置
    if (self.datas.count) {
        NSIndexPath *indexPath  = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - collectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    self.titleLabel.text = [NSString stringWithFormat:@"%ld/%lu",_index+1,(unsigned long)self.datas.count];
    
    VBigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VBigImageCell class]) forIndexPath:indexPath];
    cell.kImage = self.datas[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0001;
}

#pragma mark - UIScrollView delegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.collectionView.frame.size.width; // 在滚动超过页面宽度的50%的时候，切换到新的页面
    int page = floor((self.collectionView.contentOffset.x + pageWidth/2)/pageWidth);
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%lu",page+1,(unsigned long)self.datas.count];
    
}

#pragma mark - setter

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[VBigImageCell class] forCellWithReuseIdentifier:NSStringFromClass([VBigImageCell class])];
        if (self.datas.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_index inSection:0];
            [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        }
    }
    return _collectionView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:V_WHITE_COLOR font:14];
        _titleLabel.frame = CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
