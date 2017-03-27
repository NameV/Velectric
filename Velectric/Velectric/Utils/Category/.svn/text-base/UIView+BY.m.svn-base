//
//  UIView+BY.m
//  千丁
//
//  Created by snake on 14-10-17.
//  Copyright (c) 2014年 www.qdingnet.com. All rights reserved.
//

#import "UIView+BY.h"

#pragma mark - UIView (Frame)

@implementation UIView (Frame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

#pragma mark - UIView (Gesture)
@implementation UIView (Gesture)

- (void)addTapAction:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer: tapGestureRecognizer];
}

-(void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end


#pragma mark - UIScrollView (Frame)
@implementation UIScrollView (Frame)

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)height {
    CGSize size = self.contentSize;
    size.height = height;
    self.contentSize = size;
}

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)width {
    CGSize size = self.contentSize;
    size.width = width;
    self.contentSize = size;
}

- (CGFloat)contentOffsetLeft {
    return self.contentOffset.x;
}

- (void)setContentOffsetLeft:(CGFloat)contentOffsetLeft {
    CGPoint point = self.contentOffset;
    point.x = contentOffsetLeft;
    self.contentOffset = point;
}

- (CGFloat)contentOffsetTop {
    return self.contentOffset.y;
}

- (void)setContentOffsetTop:(CGFloat)contentOffsetTop {
    CGPoint point = self.contentOffset;
    point.y = contentOffsetTop;
    self.contentOffset = point;
}

@end
