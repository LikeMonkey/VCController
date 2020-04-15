//
//  FriendModel.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendModel : NSObject
/** <#assign属性注释#> */
@property (nonatomic,strong)  UIImage*iconImage;
/**  */
@property (nonatomic,copy) NSString *name;
/** con */
@property (nonatomic,copy) NSString *content;
/** <#assign属性注释#> */
@property (nonatomic,assign) BOOL shouldFolder;
/** <#assign属性注释#> */
@property (nonatomic,assign) BOOL isOpening;
/** <#assign属性注释#> */
@property (nonatomic,assign) BOOL isliked;
/** n */
@property (nonatomic,strong) NSMutableArray *likeItemsArray;
/** <#assign属性注释#> */
@property (nonatomic,strong) NSArray *commentItemsArray;
/** <#assign属性注释#> */
@property (nonatomic,strong) NSArray *picNamesArray;


@end

NS_ASSUME_NONNULL_END
