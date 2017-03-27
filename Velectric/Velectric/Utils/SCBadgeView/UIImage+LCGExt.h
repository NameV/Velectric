//
//  UIImage+LCGExt.h
//  BBE
//
//  Created by apple on 14-6-16.
//  Copyright (c) 2014年 woliwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LCGExt)

//压缩图片
- (UIImage *)scaleToSize:(CGSize)size;

//截取部分图片
- (UIImage *)getSubImageWithRect:(CGRect)rect;

@end
