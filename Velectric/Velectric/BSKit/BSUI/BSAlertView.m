//
//  BSAlertView.m
//  StarterKit
//
//  Created by XiaoYang on 15/10/10.
//  Copyright © 2015年 XiaoYang. All rights reserved.
//

#import "BSAlertView.h"

@implementation BSAlertView


- (instancetype)init {
    self = [super init];
    if (self) {
        [[MMPopupWindow sharedWindow] cacheWindow];
        [MMPopupWindow sharedWindow].touchWildToHide = NO;
    }
    return self;
}


#pragma mark - alertView
+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
                     items:(NSArray *)items
           completionBlock:(BSAlertViewCompletionBlock)completionBlock {
    
    NSMutableArray *array = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BSAlertView *mAlertView = items[idx];
        
        mAlertView.block = ^(NSInteger index){
            if (completionBlock) completionBlock(index);
        };
        
        [array addObject:MMItemMake(mAlertView.title, (MMItemType)mAlertView.itemType, mAlertView.block)];
    }];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:message items:array];
    
    [alertView show];
}


+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
             alertViewType:(BSAlertViewType)type
           completionBlock:(BSAlertViewCompletionBlock)completionBlock {
    
    NSArray *array;
    if (type == BSAlertViewConfirm) {
        array = @[BSItemMake(@"确定", BSItemTypeHighlight)];
        
    } else if (type == BSAlertViewNormal) {
        array = @[BSItemMake(@"取消", BSItemTypeNormal),
                  BSItemMake(@"确定", BSItemTypeHighlight)];
    }
    
    [BSAlertView alertViewWithTitle:title
                            message:message
                              items:array
                    completionBlock:completionBlock];
}


+ (void)alertViewWithInputTitle:(NSString *)title
                   message:(NSString *)message
               placeholder:(NSString *)placeholder
           completionBlock:(void(^)(NSString *text))handler {
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithInputTitle:title
                                                              detail:message
                                                         placeholder:placeholder
                                                             handler:^(NSString *text) {
                                                                 handler(text);
                                                                 [alertView hide];
                                                             }];
    [alertView show];
    
}


@end
