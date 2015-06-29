//
//  myView.h
//  ipod坐标测试
//
//  Created by liming on 15/6/18.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMSendMassageToolBarDelegate <NSObject>
@optional
- (void)sendMessage:(NSString*)content;

- (void)chooseEmoji:(UIImage *)image EmojiText:(NSString *)emojiText;

@end


@interface DMSendMassageToolBar : UIView

- (instancetype)initWithToolBarFrame:(CGRect)frame;
/**
 *  表情按钮
 */
@property (strong, nonatomic) UIButton *emojiBtn;
/**
 *  表情按钮背景图片
 */
@property (nonatomic,copy)NSString *emojiBtnImage;

/**
 *  文本框
 */
@property (strong, nonatomic) UITextView *textView;
/**
 *  发送按钮
 */
@property (strong, nonatomic) UIButton *sendBtn;
/**
 *  发送按钮背景图片
 */
@property (nonatomic,copy)NSString *sendBtnImage;
/**
 *   记录toolbar原始高度
 */
@property (nonatomic,assign)CGRect textViewDefaultFrame;


@property (nonatomic,weak)id<DMSendMassageToolBarDelegate>delegate;

@end
