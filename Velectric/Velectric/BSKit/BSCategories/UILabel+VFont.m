//
//  UILabel+VFont.m
//  Velectric
//
//  Created by LYL on 2017/2/23.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "UILabel+VFont.h"

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale ((SCREEN_HEIGHT > 568) ? SCREEN_HEIGHT/568 : 1)

@implementation UILabel (VFont)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aCoder {
    [self myInitWithCoder:aCoder];
    if (self) {
        //部分不想字体自适应的字体，tag设置为333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
        }
    }
    return self;
}

@end

@implementation UIButton (VFont)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aCoder {
    [self myInitWithCoder:aCoder];
    if (self) {
        //部分不想自适应的字体，tag设置为333跳过
        if (self.titleLabel.tag != 333) {
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}

@end

@implementation UITextField (VFont)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aCoder {
    [self myInitWithCoder:aCoder];
    if (self) {
        //部分不想字体自适应的字体，tag设置为333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
        }
    }
    return self;
}

@end

@implementation UITextView (VFont)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aCoder {
    [self myInitWithCoder:aCoder];
    if (self) {
        //部分不想字体自适应的字体，tag设置为333跳过
        if (self.tag != 333) {
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
        }
    }
    return self;
}

@end
