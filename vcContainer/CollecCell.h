//
//  CollecCell.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollecCell : UITableViewCell
/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;
/**  */
@property (nonatomic,strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
