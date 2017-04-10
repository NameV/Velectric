//
//  BSAlertView.h
//  StarterKit
//
//  Created by XiaoYang on 15/10/10.
//  Copyright © 2015年 XiaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPopupItem.h"
#import "MMAlertView.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"


typedef NS_ENUM(NSUInteger, BSAlertViewType) {
    BSAlertViewConfirm,     // 只有一个确定按钮的alertView
    BSAlertViewNormal       // 普通（确认/取消）alertView
};

typedef NS_ENUM(NSUInteger, BSItemType) {
    BSItemTypeNormal,       // 默认alertView按钮状态
    BSItemTypeHighlight,    // 高亮状态
    BSItemTypeDisabled      // 不能点击状态
};

/**
 *  alertView 按钮点击事件
 *
 *  @param buttonIndex 按钮下标
 */
typedef void (^BSAlertViewCompletionBlock) (NSInteger buttonIndex);



#pragma mark - interface
@interface BSAlertView : NSObject

/**
 *  按钮点击事件block
 */
@property (nonatomic, copy) MMPopupItemHandler block;

/**
 *  按钮title
 */
@property (nonatomic, copy) NSString *title;

/**
 *  按钮类型
 */
@property (nonatomic, assign) BSItemType itemType;


#pragma mark - created alertView
/**
 *  自定义alertView
 *
 *  @param title           -alertView标题
 *  @param message         -alertView内容
 *  @param items           -alertView按钮集合
 *  @param completionBlock -按钮点击事件block
 */
+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
                     items:(NSArray *)items
           completionBlock:(BSAlertViewCompletionBlock)completionBlock;


/**
 *  默认alertView
 *
 *  @param title           -alertView标题
 *  @param message         -alertView内容
 *  @param type            -alertView类型（0-只有一个确定按钮的alertView；1-普通（确认/取消）alertView）
 *  @param completionBlock -按钮点击事件block
 */
+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
             alertViewType:(BSAlertViewType)type
           completionBlock:(BSAlertViewCompletionBlock)completionBlock;


/**
 *  带输入框alertView
 *
 *  @param title       -alertView标题
 *  @param message     -alertView内容
 *  @param placeholder -alertView输入框placeholder
 *  @param handler     -携带输入信息的block回调
 */
+ (void)alertViewWithInputTitle:(NSString *)title
                   message:(NSString *)message
               placeholder:(NSString *)placeholder
           completionBlock:(void(^)(NSString *text))handler;

@end




NS_INLINE BSAlertView *BSItemMake (NSString *title, BSItemType itemType) {
    BSAlertView *item = [BSAlertView new];
    
    item.title = title;
    item.itemType = itemType;
    
    return item;
}
