//
//  ChatTableViewCell.m
//  DMSendMassageToolBar
//
//  Created by liming on 15/6/29.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//



#import "ChatTableViewCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "UIImage+Extension.h"

@interface ChatTableViewCell()
@property (nonatomic,weak)UIButton *textView;
@end

@implementation ChatTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc]init];
        
    
        // 正文
        UIButton *textView = [[UIButton alloc] init];
        textView.titleLabel.numberOfLines = 0; // 自动换行
        textView.titleLabel.font = textFont;
        textView.contentEdgeInsets = UIEdgeInsetsMake(TextPadding, TextPadding, TextPadding, TextPadding);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    Message *message =  messageFrame.message;
    
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
    [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_me"] forState:UIControlStateNormal];
    
}





@end
