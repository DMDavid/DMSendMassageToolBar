//
//  MessageFrame.m
//  DMSendMassageToolBar
//
//  Created by liming on 15/6/29.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import "MessageFrame.h"
#import "Message.h"
#import "NSString+Extension.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message
{
    _message = message;
    
    // 间距
    CGFloat padding = 10;
    // 屏幕的宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 正文
    CGFloat textY = padding;
    // 文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    // 文字计算出来的真实尺寸(按钮内部label的尺寸)
    CGSize textRealSize = [message.text sizeWithFont:textFont maxSize:textMaxSize];
    // 按钮最终的真实尺寸
    CGSize textBtnSize = CGSizeMake(textRealSize.width + TextPadding * 2, textRealSize.height + TextPadding * 2);
    
    CGFloat textX = screenW - padding - textBtnSize.width;
    
    _textF = (CGRect){{textX, textY}, textBtnSize};
    
    // cell的高度
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    _cellHeight = textMaxY + padding;
}




@end
