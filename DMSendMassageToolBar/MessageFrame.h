//
//  MessageFrame.h
//  DMSendMassageToolBar
//
//  Created by liming on 15/6/29.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#define textFont [UIFont systemFontOfSize:18]
// 正文的内边距
#define TextPadding 20

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Message;

@interface MessageFrame : NSObject

/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  数据模型
 */
@property (nonatomic, strong) Message *message;



@end
