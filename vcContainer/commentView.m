//
//  commentView.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/20.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "commentView.h"
#import "Masonry.h"
#import "LikeItemsModel.h"
#import "commentObject.h"
#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
@implementation commentView
{
    CGFloat labelHeight;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
      
    }
    
    return self;
}

- (void)setUpViews {
       [self addSubview:self.bgImageView];
       [self addSubview:self.likeLabel];
       self.commentLabelArray = [NSMutableArray array];
//        CGFloat magin = 5;
//       [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.left.top.mas_offset(magin);
//              make.bottom.right.mas_offset(-magin);
//          }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
//    [self addSubview:self.likeLabelBottomLine];
//
}
-(void)setUpViewWithLikeItemsArray:(NSArray *)likeItemsArray AndCommentIOtemsArray:(NSArray *)commentItemsArray{
    self.likeitemSArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
  if (self.commentLabelArray.count>0) {
       [self.commentLabelArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
           [self removeConstraints:label.constraints];
           label.hidden = YES; //重用时先隐藏所以评论label，然后根据评论个数显示label
       }];
   }
    CGFloat magin = 5;
    UIView *lastTopView;
    if (likeItemsArray.count == 0) {
              [self.likeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.mas_offset(magin);
                  make.right.mas_offset(-magin);
                  make.top.mas_offset(0);
                  make.height.mas_equalTo(0);
              }];
              NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
              self.likeLabel.attributedText = attributedText;
              lastTopView = self.likeLabel;
          }
    if (likeItemsArray.count>0) {
        [self.likeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(magin);
            make.right.mas_offset(-magin);
            make.top.mas_offset(10);
        }];
        lastTopView = self.likeLabel;
    }
   
  
    if (commentItemsArray.count>0) {
        
           for (int i =0; i<self.commentItemsArray.count; i++) {
               UILabel *label= (UILabel *)self.commentLabelArray[i];
               CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
               label.hidden = NO;
               [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.left.mas_offset(5);
                   make.right.mas_offset(-5);
                   make.top.mas_equalTo(lastTopView.mas_bottom).mas_offset(topMargin);
               }];
               NSLog(@"+++++++++++++++++++++++%d",i);
             lastTopView = label;
               NSLog(@"lastLabel的tag%ld",label.tag);
           }
    }
    
    if(lastTopView){
        [lastTopView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.bottom.mas_offset(0);
           }];
         NSLog(@"lastTopView的tag%ld",lastTopView.tag);
    }

//    if (likeItemsArray.count==0&&commentItemsArray.count==0) {
//        
//    }
  
    
}
-(void)setCommentItemsArray:(NSArray *)commentItemsArray{
    _commentItemsArray = commentItemsArray;
    long originaLablesCoumt= self.commentLabelArray.count;
    long needSToAddCount= commentItemsArray.count>originaLablesCoumt?(commentItemsArray.count-originaLablesCoumt):0;
    for (int i =0; i<needSToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        label.tag = i;
        UIColor *highLightColor = TimeLineCellHighlightedColor;
        label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        label.numberOfLines = 0;
        [self addSubview:label];
        [self.commentLabelArray addObject:label];
        label.userInteractionEnabled = YES;
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentLabelTapped:)];
        [label addGestureRecognizer:tap];
    }
    if (commentItemsArray.count>0) {
         for (int i = 0; i < commentItemsArray.count; i++) {
                 commentObject*model = commentItemsArray[i];
                 MLLinkLabel *label = self.commentLabelArray[i];
                 label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
             }
    }
   
}
#pragma mark - private actions

- (void)commentLabelTapped:(UITapGestureRecognizer *)tap
{
    if (self.didClickCommentLabelBlock) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGRect rect = [tap.view.superview convertRect:tap.view.frame toView:window];
        commentObject *model = self.commentItemsArray[tap.view.tag];
        self.didClickCommentLabelBlock(model.firstUserName, rect);
    }
}
-(void)setLikeitemSArray:(NSMutableArray *)likeitemSArray{
    _likeitemSArray = likeitemSArray;
    
    //图片转化为富文本内容
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:@"Like"];
    attch.bounds = CGRectMake(0,-3 , 16, 16);

    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:likeIcon];
    if (_likeitemSArray.count >0) {
         for (int i =0; i<_likeitemSArray.count; i++) {
               LikeItemsModel *model = _likeitemSArray[i];
               if (i>0) {
               [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
               }
               [attributedText appendAttributedString:[self generateAttributedStringWithLikeItemModel:model]];
           }
          
           _likeLabel.attributedText = [attributedText copy];
           
           labelHeight = [self.likeLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-40-20-10, MAXFLOAT) ].height;
    }
   
}
-(NSMutableAttributedString*)generateAttributedStringWithCommentItemModel:(commentObject*)commentModel{
    NSString *text = commentModel.firstUserName;
       if (commentModel.secondUserName.length) {
           text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", commentModel.secondUserName]];
       }
       text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", commentModel.commentString]];
       NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
       [attString setAttributes:@{NSLinkAttributeName : commentModel.firstUserId} range:[text rangeOfString:commentModel.firstUserName]];
       if (commentModel.secondUserName) {
           [attString setAttributes:@{NSLinkAttributeName : commentModel.secondUserId} range:[text rangeOfString:commentModel.secondUserName]];
       }
       return attString;
    
}
-(NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(LikeItemsModel *)likeModel{
    NSString *name = likeModel.userName;
    NSMutableAttributedString *attributerString = [[NSMutableAttributedString alloc] initWithString:name];
    UIColor *highLightColor = [UIColor blueColor];
      [attributerString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : likeModel.userId} range:[name rangeOfString:likeModel.userName]];
      
      return attributerString;
}
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        UIImage *bgimage = [[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30
                             ];
        [_bgImageView setImage:bgimage];
    }
    return _bgImageView;
}

- (MLLinkLabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[MLLinkLabel alloc]init];
        _likeLabel.font = [UIFont systemFontOfSize:14];
        _likeLabel.numberOfLines = 0;
        
//        _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName:TimeLineCellHighlightedColor};
    }
    return _likeLabel;
}

- (UIView *)likeLabelBottomLine {
    if (!_likeLabelBottomLine) {
        _likeLabelBottomLine = [[UIView alloc]init];
        _likeLabelBottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];    }
    return _likeLabelBottomLine;
}

#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
}
@end
