//
//  FriendTableViewCell.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "OperationViiew.h"
#import "UIView+XMGExtension.h"
#import "commentView.h"
#import "picktureContainer.h"
CGFloat maxContentLabelHeight = 0;
CGFloat magin = 10;
@interface FriendTableViewCell ()
/** <#assign属性注释#> */
@property (nonatomic,strong) UIImageView *headerImageView;
/** <#assign属性注释#> */
@property (nonatomic,strong) UILabel *nameLable;

/** <#assign属性注释#> */
@property (nonatomic,strong) UILabel *contentlabel;
/** <#assign属性注释#> */
@property (nonatomic,strong) UILabel *morelabel;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIButton *operationbtn;
/** <#assign属性注释#> */
@property (nonatomic,assign) BOOL shouldOpenContentLabel;
/** <#assign属性注释#> */
@property (nonatomic,strong) OperationViiew * operationView;
/** <#assign属性注释#> */
@property (nonatomic,strong) commentView *commentView;
/** <#assign属性注释#> */
@property (nonatomic,strong) picktureContainer *picktureContainer;

/** <#assign属性注释#> */
@property (nonatomic,strong) UIView *lastBottomView;



@end

@implementation FriendTableViewCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    FriendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    _shouldOpenContentLabel = NO;
    
    _headerImageView = [[UIImageView alloc]init];
    
    _nameLable = [[UILabel alloc]init];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentlabel  = [[UILabel alloc]init];
    _contentlabel.font = [UIFont systemFontOfSize:14];
    _contentlabel.textColor = [UIColor blackColor];
    _contentlabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentlabel.font.lineHeight *3+2*(8+(_contentlabel.font.lineHeight - _contentlabel.font.pointSize));
    }
    
    _morelabel = [[UILabel alloc]init];
    _morelabel.text = @"全文";
    _morelabel.textColor = [UIColor blueColor];
    [_morelabel setFont:[UIFont systemFontOfSize:14]];
    _morelabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreBtnClick)];
    [_morelabel addGestureRecognizer:singalTap];
    
    _morelabel.textAlignment = NSTextAlignmentLeft;

    _picktureContainer = [[picktureContainer alloc]init];
    _operationbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_operationbtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationbtn addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    _operationView = [[OperationViiew alloc]init];
    _operationView.likeBtnClickBlock = ^{
        //成功后的回调
        if ([self.deleagte respondsToSelector:@selector(successClickLikeBtn:)]) {
            [self.deleagte successClickLikeBtn:self];
        }
    };
    _operationView.commentBtnClickBlock = ^{
        if ([self.deleagte respondsToSelector:@selector(successClickCommetnBtn:)]) {
            [self.deleagte successClickCommetnBtn:self];
        }
    };
    _commentView = [[commentView alloc]init];
    [_commentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _commentView.didClickCommentLabelBlock = ^(NSString * _Nonnull commentId, CGRect rectInWindow) {
        if (self.didClickCommentLabelBlock) {
            self.didClickCommentLabelBlock(commentId, rectInWindow,self.indexPath);
        }
    };
    UIView *content = self.contentView;

    [content addSubview:_headerImageView];
    [content addSubview:_nameLable];
    [content addSubview:_contentlabel];
    [content addSubview:_picktureContainer];
    [content addSubview:_morelabel];
    [content addSubview:_operationbtn];
    [content addSubview:_operationView];
    [content addSubview:_commentView];
    
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(magin);
        make.top.mas_offset(magin);
        make.height.width.mas_equalTo(40);
    }];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(magin);
        make.top.mas_equalTo(_headerImageView.mas_top);
        make.height.mas_equalTo(18);
        make.width.mas_lessThanOrEqualTo(200);
    }];
    [_contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLable);
        make.top.mas_equalTo(_nameLable.mas_bottom).mas_offset(magin);
        make.right.mas_offset(-magin);
//        make.height.mas_equalTo(60);
    }];
    [_morelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentlabel);
        make.top.mas_equalTo(_contentlabel.mas_bottom).mas_offset(magin);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
//    if (friendModel.picNamesArray.count>0) {
//        picContainTopMagin = 10;
//    }
    [_picktureContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_morelabel.mas_left);
        make.top.mas_equalTo(_morelabel.mas_bottom).mas_offset(5);
        make.height.width.mas_equalTo(0);
    }];
    [_operationbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-magin);
        make.top.mas_equalTo(_picktureContainer.mas_bottom);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
        
    }];
    [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_operationbtn.mas_left);
        make.centerY.mas_equalTo(self->_operationbtn.mas_centerY);
        make.width.mas_equalTo(0.01);
        make.height.mas_equalTo(36);
       
    }];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(_morelabel.mas_left);
           make.right.mas_equalTo(_operationbtn.mas_right);
           make.top.mas_equalTo(_operationbtn.mas_bottom);
        make.bottom.mas_offset(-10);
       }];
    
}
-(void)setFriendModel:(FriendModel *)friendModel{
    //设置文字两端对齐
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:friendModel.content];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 8;
    NSDictionary * dic =@{
        NSParagraphStyleAttributeName:paragraphStyle1,
    };
    [attributedString1 setAttributes:dic range:NSMakeRange(0, attributedString1.length)];
  
    _contentlabel.attributedText = attributedString1;
      _contentlabel.lineBreakMode=NSLineBreakByTruncatingTail;
    _friendModel = friendModel;
    [_headerImageView setImage:friendModel.iconImage];
    [_nameLable setText:friendModel.name];
    //shoufolder  是否展示全文BTN
    if (friendModel.shouldFolder) {
      
        if (friendModel.isOpening) {
            //计算文字高度
//       [_contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(100);
//           }];
            [_contentlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.left.mas_equalTo(_nameLable);
                    make.top.mas_equalTo(_nameLable.mas_bottom).mas_offset(magin);
                    make.right.mas_offset(-magin);
                    make.height.lessThanOrEqualTo(@(10000));
            }];
              [_morelabel setText:@"收起"];
        }else{
//        [_contentlabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(maxContentLabelHeight);
//                   }];
            [_contentlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.left.mas_equalTo(_nameLable);
                      make.top.mas_equalTo(_nameLable.mas_bottom).mas_offset(magin);
                      make.right.mas_offset(-magin);
                      make.height.mas_equalTo(maxContentLabelHeight);
            }];
            [_morelabel setText:@"全文"];
        }
    }else{
        _morelabel.hidden = YES;
    }

     _picktureContainer.picPathStringArray = friendModel.picNamesArray;

     __weak typeof(_picktureContainer) pickConer = _picktureContainer;
    [_picktureContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(pickConer.width);
        make.height.mas_equalTo(pickConer.height);
    }];

    [_commentView setUpViewWithLikeItemsArray:friendModel.likeItemsArray AndCommentIOtemsArray:friendModel.commentItemsArray];
    
}

-(void)moreBtnClick{
   
    if (self.moreBtnclickBlock) {
        self.moreBtnclickBlock(self.indexPath);
    }
}
-(void)operationButtonClicked:(UIButton *)sender{
    
    _operationView.show = !_operationView.show;
}
@end
