//
//  UIImage+LCGExt.m
//  BBE
//
//  Created by apple on 14-6-16.
//  Copyright (c) 2014年 woliwu. All rights reserved.
//

#import "UIImage+LCGExt.h"

@implementation UIImage (LCGExt)

//压缩图片
- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//截取部分图片
- (UIImage *)getSubImageWithRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return image;
}

@end
