//
//  MemberModel.m
//  Velectric
//
//  Created by user on 2016/12/31.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Id = [NSString stringWithFormat:@"%@",value];
    }
}
@end
