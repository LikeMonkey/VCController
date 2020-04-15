//
//  ViewController.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "ViewController.h"
#import "textoneViewController.h"
#import "texttwoViewController.h"
#import "textthreeViewController.h"
#import "UIView+XMGExtension.h"
#define viewWidth self.view.bounds.size.width
#define viewhight self.view.bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
/** 背景 */
@property (nonatomic,strong) UIScrollView *myScrollView;
/** 当前页面角标 */
@property (nonatomic,strong) UIButton* selectBtn;
/** <#assign属性注释#> */
@property (nonatomic,strong) textoneViewController *OneVc;
/** <#assign属性注释#> */
@property (nonatomic,strong) texttwoViewController *twoVc;
/** <#assign属性注释#> */
@property (nonatomic,strong) textthreeViewController *threeVc;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIView *indicatorView;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIView *alphView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicatorView.y = 90;
    self.indicatorView.height = 10;
    self.indicatorView.width  =80;
    [self.view addSubview:self.indicatorView];
    CGFloat width = self.view.bounds.size.width/3;
    CGFloat hight = 80;
    for (int i =0; i<3; i++) {
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn setFrame:CGRectMake(i*width, 0, width, hight)];
        btn.tag = i;
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        if (i==1) {
            self.selectBtn = btn;
            self.alphView.frame = self.selectBtn.frame;
            self.indicatorView.centerX= self.selectBtn.center.x;
            btn.selected  = YES;
        }
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self setUpChildVC];
}
-(void)setUpChildVC{
    [self.view addSubview:self.myScrollView];
    [self.view addSubview:self.indicatorView];
    [self.view addSubview:self.alphView];
     
    [self.OneVc.view setFrame:CGRectMake(0, 0, viewWidth, self.view.bounds.size.height-95)];
    [self.myScrollView addSubview:self.OneVc.view];
    [self.threeVc.view setFrame:CGRectMake(viewWidth*2, 0, viewWidth,self.myScrollView.bounds.size.height)];
    self.threeVc.view.backgroundColor = [UIColor redColor];
    [self.myScrollView addSubview:self.threeVc.view];
    [self.twoVc.view setFrame:CGRectMake(viewWidth,0,viewWidth, self.view.bounds.size.height-95)];
    [self.myScrollView addSubview:self.twoVc.view];
    [self.myScrollView setContentOffset:CGPointMake(viewWidth *self.selectBtn.tag, 0)];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self changeBtntitleColorWith:scrollView.contentOffset.x/viewWidth];
}
-(void)changeBtntitleColorWith:(int)tag{
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {//判断该subViews是否是button
            //是
            if (obj.tag == tag) {//subViews的tag与按钮的tag一样
                //改变颜色
                 obj.selected  = YES;
                // 动画
                __weak typeof(self)ws = self;
                
                [UIView animateWithDuration:0.25 animations:^{
                    ws.indicatorView.centerX = obj.center.x;
                    ws.alphView.centerX = obj.center.x;
                }];
                //                //----------------------------
                //                if (obj.frame.origin.x < viewWidth/2) {
                //                    [UIView animateWithDuration:0.5 animations:^{
                //                        [UIView animateWithDuration:0.25 animations:^{
                //                            _indicatorView.centerX = obj.center.x;
                //                        }];
                //                    }];
                //                }
                //----------------------------
                
            }else{//如果obj.tag != tag
                obj.selected = NO;
            }
        }
    }];
}
-(void)btnClick:(UIButton *)sender{
    self.selectBtn.selected = !self.selectBtn.selected;
    sender.selected = !sender.selected;
    self.selectBtn = sender;
    [self confingSender:sender];
    [self changeBtntitleColorWith:(int)sender.tag];
}
-(void)confingSender:(UIButton *)sender{
    [self.myScrollView setContentOffset:CGPointMake(sender.tag*viewWidth, 0)];
    
}

#pragma mark ——— lazy
- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,95, self.view.bounds.size.width, self.view.bounds.size.height-95)];
        _myScrollView.backgroundColor = [UIColor whiteColor];
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.bounces = YES;
        _myScrollView.scrollEnabled = YES;
        _myScrollView.delegate = self;
        _myScrollView.pagingEnabled = YES;
        /** 拖动键盘消失 */
        _myScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_myScrollView setContentSize:CGSizeMake(self.view.bounds.size.width *3, 0)];
        
    }
    return _myScrollView;
}

- (textthreeViewController *)threeVc {
    if (!_threeVc) {
        _threeVc = [[textthreeViewController alloc]init];
    }
    return _threeVc;
}

- (texttwoViewController *)twoVc {
    if (!_twoVc) {
        _twoVc = [[texttwoViewController alloc]init];
    }
    return _twoVc;
}

- (textoneViewController *)OneVc {
    if (!_OneVc) {
        _OneVc = [[textoneViewController alloc]init];
    }
    return _OneVc;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.backgroundColor = [UIColor blackColor];
    }
    return _indicatorView;
}

- (UIView *)alphView {
    if (!_alphView) {
        _alphView = [[UIView alloc]init];
        UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _alphView.backgroundColor =color;
    }
    return _alphView;
}
@end

