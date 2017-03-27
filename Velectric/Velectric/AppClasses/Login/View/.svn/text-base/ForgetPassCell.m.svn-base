//
//  ForgetPassCell.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "ForgetPassCell.h"

@implementation ForgetPassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)getBtnToch:(id)sender {
    
        __block int timeout=59; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){
                //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    self.getBtncode.backgroundColor = RGBColor(52, 158, 251);
                    self.getBtncode.enabled =YES;
                    [self.getBtncode setTitle:@"获取验证码" forState:UIControlStateNormal];
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d秒后再次获取", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.getBtncode setTitle:strTime forState:UIControlStateNormal];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
