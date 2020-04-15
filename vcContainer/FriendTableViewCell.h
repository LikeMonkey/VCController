//
//  FriendTableViewCell.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "FriendModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FriendTableViewCellDelegate <NSObject>

@required // 必须实现的方法 默认

@optional // 可选实现的方法
- (void)successClickLikeBtn:(UITableViewCell *)cell;
- (void)successClickCommetnBtn:(UITableViewCell *)cell;

@end
@interface FriendTableViewCell : UITableViewCell


@property(nonatomic, weak) id<FriendTableViewCellDelegate> deleagte;
/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;
/** <#assign属性注释#> */
@property (nonatomic,strong) FriendModel *friendModel;
// <#属性block#>
@property (nonatomic, copy) void(^moreBtnclickBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath *indexPath;
+(CGFloat)returnCellHeight;
@end

NS_ASSUME_NONNULL_END
