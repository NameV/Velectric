//
//  VBacthListModel.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBacthListModel.h"

static CGFloat kpadding = 15.0f;
static CGFloat timeHeight = 15.0f;
static CGFloat separatHeight = 1 + 1 + 10 ;

static CGFloat const contentFont = 15.f;                     //内容字号

@implementation VBacthListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"batchProducts"   :   [VBatchCellModel class]
             };
}

@end


@implementation VBatchCellModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ident" : @"id"
             };
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 2 * kpadding; // 屏幕宽度减去左右间距
        CGFloat contentH = [self.context boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentFont]}
                                                      context:nil].size.height;
        /*
            contentH：内容高度
            kpadding * 3 间隙高度
            timeHeight：时间高度
            separatHeight：空隙高度
            20：底部删除编辑按钮高度
         */
        _cellHeight = contentH + kpadding * 3 + timeHeight + separatHeight + 20;
    }
    return _cellHeight;
}

@end
