//
//  OperationViiew.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "OperationViiew.h"
#import "Masonry.h"
#import "UIView+XMGExtension.h"
@implementation OperationViiew
{
    UIButton *_likeBtn;
    UIButton*_commentBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius =5;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)setUpViews {
    _likeBtn = [self creatBtnWithTitle:@"赞" imagw:[UIImage imageNamed:@"AlbumLike"] target:self selector:@selector(likeBtnClick)];
     _commentBtn = [self creatBtnWithTitle:@"评论" imagw:[UIImage imageNamed:@"AlbumComment"] target:self selector:@selector(commentBtnClick)];
    UIView *line  = [[UIView alloc]init];
    line.backgroundColor  = [UIColor redColor];
    [self addSubview:_likeBtn];
    [self addSubview:_commentBtn];
    [self addSubview:line];
    CGFloat magin = 5;
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(magin);
        make.top.bottom.mas_offset(0);
        make.width.mas_equalTo(80);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_likeBtn.mas_right).mas_offset(magin);
        make.top.mas_offset(magin);
        make.bottom.mas_offset(-magin);
        make.width.mas_equalTo(1);
    }];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_offset(-magin);
         make.width.mas_equalTo(80);
         make.left.mas_equalTo(line.mas_right).mas_offset(magin);
         make.top.bottom.mas_equalTo(_likeBtn);
     }];
    
    
}
-(void)likeBtnClick{
    if (self.likeBtnClickBlock) {
        self.likeBtnClickBlock();
    }
      self.show = NO;
}
-(void)commentBtnClick{
    if (self.commentBtnClickBlock) {
        self.commentBtnClickBlock();
    }
    self.show = NO;
}
-(UIButton *)creatBtnWithTitle:(NSString *)title imagw:(UIImage *)image target:(id)target selector:(SEL)seletor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:seletor forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    return btn;
}
-(void)setShow:(BOOL)show{
    _show = show;
    [UIView animateWithDuration:0.1 animations:^{
        if (!show) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0.01);
            }];
        }else{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                           make.width.mas_equalTo(180);
                       }];
        }
        [self.superview layoutIfNeeded];
    }];
}
@end
