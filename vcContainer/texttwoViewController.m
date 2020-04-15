//
//  texttwoViewController.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "texttwoViewController.h"
#import "SearchResultViewController.h"
#import "UIView+XMGExtension.h"
#define viewWidth self.view.bounds.size.width
#define viewhight self.view.bounds.size.height

#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径
@interface texttwoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
/** <#assign属性注释#> */
@property (nonatomic,strong) UITableView *tableView;
/** u */
@property (nonatomic,strong) UIView *tagView;
/** n */
@property (nonatomic,strong) NSMutableArray *histories;
/** <#assign属性注释#> */
@property (nonatomic,strong) UISearchBar *searchBar;
/** <#assign属性注释#> */
@property (nonatomic,strong) SearchResultViewController *searchResultVc;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *tagsArray;

/** <#assign属性注释#> */
@property (nonatomic,strong) UIView *headerView;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *searchHistoriesCachePath;

@property (nonatomic, assign) NSUInteger searchHistoriesCount;
@end

@implementation texttwoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
  
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    btn.centerY = self.searchBar.height/2;
    btn.x = self.searchBar.x+_searchBar.width+10;
    btn.width = 80;
    btn.height = 40;
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
   

    [self.view addSubview:self.tableView];
    [_tableView setFrame:CGRectMake(0, 80, viewWidth, viewhight-80)];
    _searchHistoriesCount = 20;
    UIView *headerView = [[UIView alloc]init];
    UILabel *headlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    headlabel.text = @"热门搜索";
    headlabel.font =[UIFont systemFontOfSize:17];
    [headerView addSubview:headlabel];
    [headerView addSubview:self.tagView];
    _tagView.x = 10;
    _tagView.y = headlabel.y+30;
    _tagView.width = viewWidth-20;
    _tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 30)];
    UILabel *footLabel = [[UILabel alloc]initWithFrame:footView.frame];
    footLabel.text = @"清空历史记录";
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.userInteractionEnabled = YES;
    footLabel.font = [UIFont systemFontOfSize:17];
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emptySearchHistoryDidClick)];
    [footLabel addGestureRecognizer:singalTap];

    [footView addSubview:footLabel];
    
    _tableView.tableFooterView = footView;
    [self tagsWithTag];
}
-(void)tagsWithTag{
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    
    for (int i =0; i<self.tagsArray.count; i++) {
        if (i!=self.tagsArray.count-1) {
            CGFloat width = [self getwidthWithTitle:_tagsArray[i+1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth+width+10>self.tagView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }else{
            CGFloat width = [self getwidthWithTitle:_tagsArray[_tagsArray.count-1] font:[UIFont systemFontOfSize:14]];
            if (allLabelHeight+width+10>_tagView.frame.size.width) {
                 rowHeight++;
                 allLabelWidth = 0;
                 allLabelHeight = rowHeight*40;
            }
        }
        UILabel *tagLable = [[UILabel alloc]init];
        tagLable.userInteractionEnabled = YES;
        tagLable.font =[UIFont systemFontOfSize:14];
        tagLable.textColor = [UIColor whiteColor];
        tagLable.backgroundColor  =[UIColor grayColor];
        tagLable.text = _tagsArray[i];
        tagLable.textAlignment = NSTextAlignmentCenter;
        [tagLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getwidthWithTitle:_tagsArray[i] font:[UIFont systemFontOfSize:14]];
        tagLable.layer.cornerRadius =5;
        tagLable.layer.masksToBounds = YES;
        tagLable.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [_tagView addSubview:tagLable];
        allLabelWidth = allLabelWidth+10+labelWidth;
    }
    _tagView.height = rowHeight*40 +40;
    _headerView.height = _tagView.y+_tagView.height+10;
    
}
-(CGFloat)getwidthWithTitle:(NSString *)title font:(UIFont *)font{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 0)];
    [label setFont:font];
    label.text = title;
    [label sizeToFit];
    return label.frame.size.width+10;
}
-(void)tagDidCLick:(UITapGestureRecognizer *)gr{
    UILabel *label =(UILabel *)gr.view;
    _searchBar.text = label.text;
    _tableView.tableFooterView.hidden = NO;
    self.searchResultVc.view.hidden = NO;
    _tableView.hidden = YES;
    [self saveSearchCacheAndRefreshView];
    [self.view bringSubviewToFront:_searchResultVc.view];
}
- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.histories = nil;

    [self.tableView reloadData];
}

-(void)saveSearchCacheAndRefreshView{
    [self.searchBar resignFirstResponder];
    
    [self.histories removeObject:_searchBar.text];
    [_histories insertObject:_searchBar.text atIndex:0];
    if (_histories.count>_searchHistoriesCount) {
        [_histories removeLastObject];
    }
    [NSKeyedArchiver archiveRootObject:_histories toFile:_searchHistoriesCachePath];
    [_tableView reloadData];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        self.searchResultVc.view.hidden = YES;
        self.tableView.hidden = NO;
    }
    else
    {
        self.searchResultVc.view.hidden = NO;
        self.tableView.hidden = YES;
        [self.view bringSubviewToFront:self.searchResultVc.view];
        
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":searchText}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    
    
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.histories.count!=0?self.histories.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
   // 添加关闭按钮
   UIButton *closetButton = [[UIButton alloc] init];
   // 设置图片容器大小、图片原图居中
   closetButton.size = CGSizeMake(10,10);
   [closetButton setTitle:@"x" forState:UIControlStateNormal];
   [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
   cell.accessoryView = closetButton;
   [closetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   
   cell.textLabel.textColor = [UIColor grayColor];
   cell.textLabel.font = [UIFont systemFontOfSize:14];
   cell.textLabel.text = self.histories[indexPath.row];
   
    return cell;
}
- (void)closeDidClick:(UIButton *)sender
{
    // 获取当前cell
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    // 移除搜索信息
    [self.histories removeObject:cell.textLabel.text];
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.histories toFile:PYSEARCH_SEARCH_HISTORY_CACHE_PATH];
    if (self.histories.count == 0) {
        self.tableView.tableFooterView.hidden = YES;
    }
    
    // 刷新
    [self.tableView reloadData];
}
/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick
{
    self.tableView.tableFooterView.hidden = YES;
    // 移除所有历史搜索
    [self.histories removeAllObjects];
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.histories toFile:_searchHistoriesCachePath];
    
    [self.tableView reloadData];
    
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (_histories.count !=0) {
//        return @"搜索历史";
//    }
//    return nil;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, viewWidth-10, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = @"搜索历史";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _searchBar.text = cell.textLabel.text;
    [self saveSearchCacheAndRefreshView];
    _searchResultVc.view.hidden  = NO;
    _tableView.hidden = YES;
    [self saveSearchCacheAndRefreshView];
}
- (SearchResultViewController *)searchResultVc {
    if (!_searchResultVc) {
        _searchResultVc = [[SearchResultViewController alloc]initWithStyle:UITableViewStylePlain];
        _searchResultVc.view.frame = CGRectMake(0, 80, viewWidth, viewhight);
        [self.view addSubview:_searchResultVc.view];
         __weak typeof(self)ws = self;
        _searchResultVc.didSelectText = ^(NSString * _Nonnull selectedText) {
            if ([selectedText isEqualToString:@""]) {
                [ws.searchBar resignFirstResponder];
            }else{
                ws.searchBar.text = selectedText;
                [ws saveSearchCacheAndRefreshView];
            }
        };
                
    }
    return _searchResultVc;
}
-(UITableView *)tableView {
    
    if(!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    return _tableView;
    
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, viewWidth-100, 80)];
        _searchBar.placeholder = @"搜索内容";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UIView *)tagView {
    if (!_tagView) {
        _tagView = [[UIView alloc]init];
    }
    return _tagView;
}

- (NSMutableArray *)tagsArray {
    if (!_tagsArray) {
        _tagsArray = @[@"葡萄",@"西虹市",@"古力娜扎",@"西虹市",@"古力娜扎",@"1",@"西虹市",@"古力娜扎",@"西虹市",@"古力娜扎"].mutableCopy;
    }
    return _tagsArray;
}

- (NSMutableArray *)histories {
    if (!_histories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _histories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:_searchHistoriesCachePath]];
    }
    return _histories;
}
/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

@end
