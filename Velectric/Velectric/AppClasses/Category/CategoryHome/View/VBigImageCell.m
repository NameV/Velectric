//
//  VBigImageCell.m
//  Velectric
//
//  Created by LYL on 2017/4/11.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBigImageCell.h"

#define SelfWidth self.contentView.frame.size.width
#define SelfHeight self.contentView.frame.size.height

@interface VBigImageCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation VBigImageCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self loadView];
    }
    return self;
}

-(void)loadView {
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.bigImage];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImage;
}

//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.bigImage.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)resetBigImageFrameWithImage:(UIImage *)image {
    self.scrollView.zoomScale = 1.0;
    if (image) {
        NSString *sizeString = NSStringFromCGSize(image.size);
        if (sizeString) {
            NSArray *sizeArray = [sizeString componentsSeparatedByString:@","];
            NSString *widthStirng = sizeArray[0];
            NSString *heightString = sizeArray[1];
            CGFloat width = [[widthStirng substringFromIndex:1] floatValue];
            CGFloat height = [[heightString substringToIndex:heightString.length-1] floatValue];
            CGFloat x;
            CGFloat y;
            
            if (width>height) {
                height = height * SelfWidth / width;
                width = SelfWidth;
                x = 0;
                y = (SelfHeight-height)/2.0;
            }else{
                width = width * SelfHeight / height ;
                height = SelfHeight;
                y = 0;
                x = (SelfWidth-width)/2.0;
                if (width>SCREEN_WIDTH) {
                    height = height * SelfWidth / width;
                    width = SCREEN_WIDTH;
                    x = 0;
                    y = (SelfHeight-height)/2.0;
                }
            }
           
            self.bigImage.frame = CGRectMake(x, y, width, height);
            self.scrollView.contentSize = self.bigImage.frame.size;
            
            
        }
    }
}

#pragma mark - setter

- (void)setKImage:(UIImage *)kImage {
    _kImage = kImage;
    [self resetBigImageFrameWithImage:kImage];
    self.bigImage.image = kImage;
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _scrollView.delegate =self;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)bigImage {
    if (!_bigImage) {
        _bigImage = [[UIImageView alloc]init];
    }
    return _bigImage;
}



@end
