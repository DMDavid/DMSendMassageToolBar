//
//  ViewController.m
//  ipod坐标测试
//
//  Created by liming on 15/6/17.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import "ChatViewController.h"
#import "DMSendMassageToolBar.h"
#import "ChatTableViewCell.h"
#import "MessageFrame.h"
#import "Message.h"

@interface ChatViewController ()<DMSendMassageToolBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *ChatTableView;

@property (nonatomic,strong)DMSendMassageToolBar *toolBar;

@end

@implementation ChatViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  聊天tableview
     */
    [self setupChatTableView];
    /**
     * 初始化控件
     */
    [self setupSendMassageToolBar];
    /**
     *   注册监听
     */
    [self.ChatTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}
/**
 *  初始化控件
 *
 *  @return 控件
 */
- (void)setupSendMassageToolBar{
    self.toolBar=[[DMSendMassageToolBar alloc]initWithToolBarFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width , 50)];
    self.toolBar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.toolBar];
    self.toolBar.delegate = self;
}


#pragma mark - DMSendMassageToolBarDelegate
- (void)sendMessage:(NSString *)content{
    NSLog(@"%@",content);
    Message *message = [[Message alloc]init];
    message.text = content;
    
    MessageFrame *messageFrame = [[MessageFrame alloc]init];
    messageFrame.message = message;
    
    [self.dataArray addObject:messageFrame];
    NSIndexPath *index=[NSIndexPath indexPathForRow:self.dataArray.count-1  inSection:0];
    [self.ChatTableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil]  withRowAnimation:UITableViewRowAnimationFade];
}





#pragma mark - 聊天tableview
- (void)setupChatTableView
{
    self.ChatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    self.ChatTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.ChatTableView];
    
    self.ChatTableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.ChatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.ChatTableView.allowsSelection = NO; // 不允许选中
    
    self.ChatTableView.dataSource = self;
    self.ChatTableView.delegate = self;
}




#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell = [ChatTableViewCell cellWithTableView:tableView];
    cell.messageFrame = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrame *messageFrame = self.dataArray[indexPath.row];
    return messageFrame.cellHeight;
    
}


#pragma mark - KVO
//设置监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //   滚动scrollview
    if (self.ChatTableView.contentSize.height > self.ChatTableView.frame.size.height) {
        [self changeScroolViewContentOffset];
    }
}

/**
 *  滚动scrollview
 */
- (void)changeScroolViewContentOffset
{
    //    滚动范围
    CGFloat contentSizeH = self.ChatTableView.contentSize.height;
    
    //    可视范围高度
    CGFloat seeSizeH = self.ChatTableView.frame.size.height;
    
    //  设置滚动到底部
    CGFloat changeBottomH = contentSizeH - seeSizeH;
    [self.ChatTableView setContentOffset:CGPointMake(0, changeBottomH) animated:YES];
    
}

- (void)dealloc
{
    [self.ChatTableView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

@end
