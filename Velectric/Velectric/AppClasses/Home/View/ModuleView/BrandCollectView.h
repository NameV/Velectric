//
//  BrandCollectView.h
//  Velectric
//
//  Created by hongzhou on 2017/1/9.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandCollectView : UIView

//品牌采集
@property (nonatomic, strong) NSMutableArray <NSString *>* brandCollectList;

//回调block
@property (nonatomic, strong) void (^changeFrameBlcok)();

@end
