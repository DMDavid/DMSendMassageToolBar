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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
 * 初始化控件
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
    [self.dataArray addObject:content];
//    NSIndexPath *index=[NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.ChatTableView reloadData];
}

//- (void)chooseEmoji:(UIImage *)image EmojiText:(NSString *)emojiText
//{
//    NSLog(@"选择emoji");
//}







- (void)setupChatTableView
{
    self.ChatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    self.ChatTableView.backgroundColor = [UIColor lightGrayColor];
    self.ChatTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.ChatTableView];
    
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
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}










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
