//
//  textthreeViewController.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "textthreeViewController.h"
#import "FriendTableViewCell.h"
#import "FriendModel.h"
#import "LikeItemsModel.h"
#import "commentObject.h"
#import "UIView+XMGExtension.h"

@interface textthreeViewController ()<UITableViewDataSource,UITableViewDelegate,FriendTableViewCellDelegate,UITextFieldDelegate>
/** <#assign属性注释#> */
@property (nonatomic,strong) UITableView *tableView;
/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, copy) NSString *commentToUser;
@property (nonatomic,strong)NSMutableDictionary *heightCache;
@end

@implementation textthreeViewController
{
     CGFloat _totalKeybordHeight;
}

-(void)viewDidLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.view addSubview:self.tableView];
    [self setupTextField];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    self.view.backgroundColor = [UIColor redColor];

//    self.currentEditingIndexthPath = [[NSIndexPath alloc]init];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
    
}
-(void)creatData{
    for (int i =0; i<10; i++) {
           FriendModel *friendmodel =[[FriendModel alloc]init];
           friendmodel.iconImage = [UIImage imageNamed:@"headerView"];
               friendmodel.name = @"耿陆超";
            NSArray *picImageNamesArray = @[ @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView",
                                               @"headerView"
                                               ];
               friendmodel.content = @"从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山从前有座剑灵山";
               friendmodel.shouldFolder = YES;
               friendmodel.isOpening = NO;
               NSArray *namesArray = @[@"GSD_iOS",
                                           @"风口上的猪",
                                           @"当今世界网名都不好起了",
                                           @"我叫郭德纲",
                                           @"Hello Kitty"];
                  NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                                                @"正宗好凉茶，正宗好声音。。。",
                                                @"1183415193@qq.com",
                                                @"http://www.baidu.com",
                                                @"你瞅啥？",
                                                @"瞅你咋地？？？！！！",
                                                @"hello，看我",
                                                @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                                                @"人艰不拆",
                                                @"咯咯哒",
                                                @"呵呵~~~~~~~~",
                                                @"我勒个去，啥世道啊",
                                                @"真有意思啊你💢💢💢"];
             int likeRandom = arc4random_uniform(3);
                      NSMutableArray *tempLikes = [NSMutableArray array];
                      for (int i = 0; i <likeRandom ; i++) {
                           LikeItemsModel *model = [LikeItemsModel new];
                              model.userName = @"从前有座剑灵山从前有座剑灵山从前有座剑灵山";
                              model.userId = @"1";
                              friendmodel.isliked = NO;
                          [tempLikes addObject:model];
                      }
                      
                      friendmodel.likeItemsArray = [tempLikes copy];
        
           int random = arc4random_uniform(9);
            
            NSMutableArray *temp = [NSMutableArray array];
            for (int i = 0; i < random; i++) {
                int randomIndex = arc4random_uniform(9);
                [temp addObject:picImageNamesArray[randomIndex]];
            }
            if (temp.count) {
                friendmodel.picNamesArray = [temp copy];
            }
                 
               
              
               // 模拟随机评论数据
                   int commentRandom = arc4random_uniform(4);
                    NSMutableArray *tempComments = [NSMutableArray array];
                    for (int i = 0; i < commentRandom; i++) {
                        commentObject *commentItemModel = [commentObject new];
                        int index = arc4random_uniform((int)namesArray.count);
                        commentItemModel.firstUserName = namesArray[index];
                        commentItemModel.firstUserId = @"666";
                        if (arc4random_uniform(10) < 5) {
                            commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                            commentItemModel.secondUserId = @"888";
                        }
                        commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
                        [tempComments addObject:commentItemModel];
                    }
                   friendmodel.commentItemsArray = [tempComments copy];
           
           [self.dataArr addObject:friendmodel];
       }
      
}
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor redColor];
    _textField.frame = CGRectMake(0,self.view.frame.size.height , self.view.frame.size.width, 50);
//    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    [self.view addSubview:_textField];
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}
#pragma mark ——— celldelegate
-(void)successClickLikeBtn:(UITableViewCell *)cell{
    
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    FriendModel*friendModel =self.dataArr[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:friendModel.likeItemsArray];
    if (!friendModel.isliked) {
        LikeItemsModel *model = [[LikeItemsModel alloc]init];
        model.userName = @"你大爷" ;
        model.userId = @"23";
        [temp addObject:model];
        friendModel.isliked = YES;
    }else{
        LikeItemsModel *tempLikeModel = nil;
               for (LikeItemsModel *likeModel in friendModel.likeItemsArray) {
                   if ([likeModel.userName isEqualToString:@"你大爷"]) {
                       tempLikeModel = likeModel;
                       [temp removeObject:tempLikeModel];
                        friendModel.isliked = NO;
                       break;
                   }
               }
    }
    friendModel.likeItemsArray = [temp copy];
    
    
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)successClickCommetnBtn:(UITableViewCell *)cell{
      [_textField becomeFirstResponder];
       _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];

       [self adjustTableViewToFitKeyboard];
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendTableViewCell *cell=[FriendTableViewCell cellWithTableView:tableView withIdentifier:NSStringFromClass( [FriendTableViewCell class]) indexPath:indexPath];
    FriendModel*friendModel = self.dataArr[indexPath.row];
    NSLog( @"当前1cell ++++%ld",indexPath.row);
    cell.friendModel = friendModel;
    cell.indexPath = indexPath;
    cell.deleagte = self;
    cell.moreBtnclickBlock = ^(NSIndexPath * _Nonnull indexPath) {
        FriendModel *model = self.dataArr[indexPath.row];
        model.isOpening = !model.isOpening;
        
        [UIView performWithoutAnimation:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
            
      
    };
    cell.didClickCommentLabelBlock = ^(NSString * _Nonnull commentId, CGRect rectInWindow, NSIndexPath * _Nonnull indexPath) {
        self.textField.placeholder = [NSString stringWithFormat:@" 回复：%@",commentId];
        self.currentEditingIndexthPath = indexPath;
        NSLog( @"选中1的cell ++++%ld",indexPath.row);
         NSLog( @"选中2的cell ++++%ld", self.currentEditingIndexthPath.row);
        self.isReplayingComment = YES;
        [self.textField becomeFirstResponder];
        [self adjustTableViewToFitKeyboardWithRect:rectInWindow];
         self.commentToUser = commentId;
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* heightNum =  self.heightCache[indexPath];
    return heightNum?heightNum.floatValue:120;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight =  CGRectGetHeight(cell.frame);
    self.heightCache[indexPath] = @(cellHeight);
}
-(NSMutableDictionary *)heightCache
{
    if (!_heightCache) {
        _heightCache = [[NSMutableDictionary alloc]init];
     }
    return _heightCache;
}
#pragma mark - UITextFieldDelegate

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y-50-95, rect.size.width, 50);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = CGRectMake(0, self.view.frame.size.height, rect.size.width, 50);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + 50;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    [self.tableView setContentOffset:offset animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        FriendModel *model = self.dataArr[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        commentObject *commentItemModel = [commentObject new];
        if (self.isReplayingComment) {
            commentItemModel.firstUserName = @"你大爷";
            commentItemModel.firstUserId = @"你大爷";
            commentItemModel.secondUserName = self.commentToUser;
            commentItemModel.secondUserId = self.commentToUser;
            commentItemModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentItemModel.firstUserName = @"你大爷";
            commentItemModel.commentString = textField.text;
            commentItemModel.firstUserId = @"你大爷";
        }
        [temp addObject:commentItemModel];
        model.commentItemsArray = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadData];
       NSLog( @"刷新的2的cell ++++%ld", _currentEditingIndexthPath.row);
        _textField.text = @"";
        
        return YES;
    }
    return NO;
}
#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(UITableView *)tableView {
    
    if(!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        [_tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FriendTableViewCell class]) ];
    }
    
    return _tableView;
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
