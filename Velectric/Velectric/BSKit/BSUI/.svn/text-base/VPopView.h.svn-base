//
//  VPopView.h
//  Velectric
//
//  Created by LYL on 2017/2/28.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMPopupView/MMPopupView.h>

typedef void(^VPopViewBlock)(NSString *content, NSInteger type);

@interface VPopView : MMPopupView

@property (nonatomic, copy) VPopViewBlock block;//确定按钮block


- (instancetype)initTitle:(NSString *)title
              certenBlock:(VPopViewBlock)block;

@end
