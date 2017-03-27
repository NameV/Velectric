//
//  MemberCell.h
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberCellDelegate <NSObject>

- (void)memberCellDelegateAction:(UIButton *)btn;

@end

@interface MemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tableHeadLable;
@property (weak, nonatomic) IBOutlet UITextField *intoMainField;
@property (weak, nonatomic) IBOutlet UILabel *listLable;
@property (weak, nonatomic) IBOutlet UILabel *shuangchuanLable;
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (nonatomic,assign)BOOL isSelect;
@property (weak, nonatomic) IBOutlet UITextField *picBtn;

//没有通过信息时的红色图标
@property (weak, nonatomic) IBOutlet UIButton *redIconButton;

@property (nonatomic, assign) id<MemberCellDelegate> delegate;

@end
