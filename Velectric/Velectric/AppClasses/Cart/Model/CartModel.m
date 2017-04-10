//
//  CartModel.m
//  Velectric
//
//  Created by user on 2016/12/24.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//- (void)setSelected:(BOOL)selected {
//    
//    NSString *urlString;
//    if (selected == YES) {
//        urlString = GetCartSelectURL;
//    }else {
//        urlString = GetCartUnselectURL;
//    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:CartViewReloadView object:nil];
//    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName ? GET_USER_INFO.loginName : @"",
//                                  @" basketId"  : _basketId ? _basketId : @"" ,
//                                  @"itemId" :   _itemId ? _itemId : @""
//                                  };
//    [VJDProgressHUD showProgressHUD:nil];
//    [SYNetworkingManager GetOrPostWithHttpType:2
//                                 WithURLString:urlString
//                                    parameters:parameters
//                                       success:^(NSDictionary *responseObject) {
//                                           [VJDProgressHUD dismissHUD];
//                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
//                                               _selected = selected;
//                                           }else{
//                                               _selected = !selected;
//                                           }
//                                           [[NSNotificationCenter defaultCenter]postNotificationName:CartViewReloadView object:nil];
//        
//    } failure:^(NSError *error) {
//        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
//        _selected = !selected;
//        [[NSNotificationCenter defaultCenter]postNotificationName:CartViewReloadView object:nil];
//    }];
//}

@end
