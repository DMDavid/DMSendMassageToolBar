//
//  ChatTableViewCell.h
//  DMSendMassageToolBar
//
//  Created by liming on 15/6/29.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrame;
@interface ChatTableViewCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MessageFrame *messageFrame;


@end
