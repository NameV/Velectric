//
//  ReceiptEditVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"

@interface ReceiptEditVC : BaseViewController

@property (copy,nonatomic) void (^receiptBlock)(NSNumber * invoiceStatus,NSNumber * invoiceType,NSString * invoiceContent,NSString * invoiceTitle);

@end
