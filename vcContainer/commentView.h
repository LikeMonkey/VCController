//
//  commentView.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/20.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface commentView : UIView<MLLinkLabelDelegate>
/** <#assign属性注释#> */
@property (nonatomic,strong) NSArray *likeitemSArray;
/**  */
@property (nonatomic,strong) NSArray *commentItemsArray;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIImageView *bgImageView;
/** <#assign属性注释#> */
@property (nonatomic,strong) MLLinkLabel *likeLabel;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIView  *likeLabelBottomLine;
/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *commentLabelArray;


-(void)setUpViewWithLikeItemsArray:(NSArray *)likeItemsArray AndCommentIOtemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);
@end

NS_ASSUME_NONNULL_END
