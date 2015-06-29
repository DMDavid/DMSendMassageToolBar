


//
//  myView.m
//  ipod坐标测试
//
//  Created by liming on 15/6/18.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//


#import "DMSendMassageToolBar.h"

@interface DMSendMassageToolBar()<UITextViewDelegate>


@end


@implementation DMSendMassageToolBar

- (instancetype)initWithToolBarFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
        /**
         *  初始化UI
         */
        [self setupUI];
        /**
         *  保存初始化值
         */
        self.textViewDefaultFrame = frame;
        /**
         *  键盘通知
         */
        [self listeningKeyboard];
    }
    return self;
}

- (void)setEmojiBtnImage:(NSString *)emojiBtnImage
{
    [self.emojiBtn setImage:[UIImage imageNamed:emojiBtnImage] forState:UIControlStateNormal];
}

- (void)setSendBtnImage:(NSString *)sendBtnImage
{
    [self.sendBtn setImage:[UIImage imageNamed:sendBtnImage] forState:UIControlStateNormal];
}

/**
 *  初始化UI
 */
- (void)setupUI{
    _emojiBtn = [[UIButton alloc]init];
    [_emojiBtn setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    [_emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _emojiBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_emojiBtn];
    
    _textView = [[UITextView alloc]init];
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textView];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16.f];
    
    
    _sendBtn = [[UIButton alloc]init];
    [_sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    _sendBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendBtn setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [self addSubview:_sendBtn];
    
    
    
    
    NSArray *consH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_emojiBtn(35)]-8-[_textView]-8-[_sendBtn(45)]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emojiBtn,_textView,_sendBtn)];
    [self addConstraints:consH];
    
    
    NSArray *emojiBtnV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_emojiBtn(35)]-8-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_emojiBtn)];
    [self addConstraints:emojiBtnV];
    
    NSArray *writeTextViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_textView]-8-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_textView)];
    [self addConstraints:writeTextViewV];
    
    
    NSArray *sendBtnV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sendBtn(35)]-8-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_sendBtn)];
    [self addConstraints:sendBtnV];

}

#pragma mark - 监听键盘通知
/**
 *    监听键盘通知
 */
- (void)listeningKeyboard
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)keyboardWillShow:(NSNotification *)showNot{
    //    1.取出键盘frame
    CGRect keyboardFrame= [showNot.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat upRectFrame = keyboardFrame.size.height;
    
    //    2.键盘弹出的时间
    CGFloat duration=[showNot.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    3.执行动画
    [UIView animateWithDuration:duration animations:^{
        //        self.LoginView.transform=CGAffineTransformMakeTranslation(0,-keyboardFrame.size.height);
        self.transform=CGAffineTransformMakeTranslation(0,-upRectFrame);
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)hideNot{
    //    2.键盘弹出的时间
    CGFloat duration=[hideNot.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.transform=CGAffineTransformIdentity;
    }];
}

//释放通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    
    // Resize ToolView according to content size of textview
    CGSize contentSize = self.textView.contentSize;
    
    float height = contentSize.height + 16;
    if (height <= 150) {
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y - (height - frame.size.height);
        frame.size.height = height;
        self.frame = frame;
    }
    
}

/**
 *  发送文本
 *
 *  @param textView 文本框
 *  @param range    输入字范围
 *  @param text     文字
 *
 *  @return 是否可以继续输入
 */
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //  点击发送按钮send
    if ([text isEqualToString:@"\n"])
    {
        [self sendMassage];
        return NO;
    }
    return YES;
}


- (void)emojiBtnClick
{
    [self chooseEmoji];
}

- (void)sendClick
{
    [self sendMassage];
}


/**
 *  发送代理事件
 */
- (void)sendMassage{
    if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
        [self.delegate sendMessage:self.textView.text];
    }
    self.textView.text = @"";
    [self.textView resignFirstResponder];
    self.frame = self.textViewDefaultFrame;
}

/**
 *  EMOJI代理事件
 */
- (void)chooseEmoji{
    if ([self.delegate respondsToSelector:@selector(chooseEmoji:EmojiText:)]) {
        [self.delegate chooseEmoji:nil EmojiText:nil];
    }
}





@end
