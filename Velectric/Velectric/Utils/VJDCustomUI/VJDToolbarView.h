//
//  VJDToolbarView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

//排序方式
typedef enum{
    OrderBy_NO      = 0,    //没有
    OrderBy_Up      = 1,    //升序
    OrderBy_Down    = 2,    //降序
}OrderByType;

@interface VJDToolbarView : UIView

//按钮list
@property (strong,nonatomic) NSArray * itemsList;

//排序方式
@property (assign,nonatomic) OrderByType orderByType;

//是否变更(按钮)状态
@property (assign,nonatomic) BOOL isChangeStatus;

//回调block
@property (copy,nonatomic) void (^toolbarViewBlock)(NSInteger clickInxex,NSInteger orderby);

@end
