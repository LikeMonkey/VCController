//
//  textoneViewController.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "textoneViewController.h"
#import "CollecCell.h"
#define headerViewHeight 200
@interface textoneViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
/** <#assign属性注释#> */
@property (nonatomic,strong) UITableView *tableView;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIImageView *headerView;

@property(nonatomic,strong)  UIImageView * imageView ;

@property(nonatomic)     CGRect originalFrame;
@end

@implementation textoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.originalFrame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    UIView * headerView = [[UIView alloc]initWithFrame:self.originalFrame];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView= headerView;
    //  需要在创建一个imageView 放图片,g如果直接用imageView 作为headerView,tablview 容易错位变形
    UIImageView * imageView = [[UIImageView alloc]initWithFrame: self.originalFrame];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.image = [UIImage imageNamed:@"headerView"];
    self.imageView  = imageView;
    [self.view addSubview:imageView];
  
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollecCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CollecCell class])];
    return cell;
}
#pragma mark - <UITableViewDelegate>

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blueColor];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        //  向上滑动
          CGRect frame = self.originalFrame ;
         frame.origin.y = frame.origin.y - yOffset;
         self.imageView.frame  = frame;
    }else{
        // 向下滑动,会放大
        CGRect frame =  self.originalFrame ;
        frame.size.height = frame.size.height - yOffset;
        frame.size.width = frame.size.height * (self.originalFrame.size.width / self.originalFrame.size.height);
        frame.origin.x = frame.origin.x - (frame.size.width - self.originalFrame.size.width) * 0.5;
        self.imageView.frame  = frame;
    }

}
-(UITableView *)tableView {
    
    if(!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[CollecCell class] forCellReuseIdentifier:NSStringFromClass([CollecCell class])];
//        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    
    return _tableView;
    
}


@end
