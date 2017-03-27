//
//  USPopView.h
//  Sales
//
//  Created by liuyulei on 16/7/15.
//  Copyright © 2016年 XiaoYang. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

typedef void(^USPopViewCertenBlock)();

@interface USPopView : MMPopupView

@property (nonatomic, copy) USPopViewCertenBlock certenBlcok;//确定按钮block

+ (instancetype)shareManager;


//只有一个button的提示框
- (instancetype)initWithIcon:(BOOL)icon
                      title:(NSString *)title
                 descripton:(NSString *)desc
                buttonTitle:(NSString *)buttonTitle
                certenBlock:(USPopViewCertenBlock)certenBlock;

//只有一个button的提示框---简化版
- (instancetype)initWithDescripton:(NSString *)desc
                 certenBlock:(USPopViewCertenBlock)certenBlock;

//有两个button的提示框
- (instancetype)initWithIcon:(BOOL)icon
                       title:(NSString *)title
                  descripton:(NSString *)desc
                 certenTitle:(NSString *)certenTitle
                 cancelTitle:(NSString *)cancelTitle
                 certenBlock:(USPopViewCertenBlock)certenBlock;

//有两个button的提示框，上面方法的简化版
- (instancetype)initTitle:(NSString *)title
                  descripton:(NSString *)desc
                 certenBlock:(USPopViewCertenBlock)certenBlock;

@end
