//
//  VBannerModel.h
//  Velectric
//
//  Created by LYL on 2017/3/8.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBannerModel : NSObject

@property (nonatomic, copy) NSString *bannerTiltle;
@property (nonatomic, copy) NSString *jumpPictureUrl;   //点击图片跳转url
@property (nonatomic, copy) NSString *pictureUrl;       //图片路径
@property (nonatomic, copy) NSString *reginName;

@property (nonatomic, strong) NSNumber *regionId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *ident;
@property (nonatomic, strong) NSNumber *pictureId;

@end
