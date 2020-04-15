//
//  OperationViiew.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperationViiew : UIView
/** <#assign属性注释#> */
@property (nonatomic,assign) BOOL show;
// <#属性block#>
@property (nonatomic, copy) void(^likeBtnClickBlock)(void);
// <#属性block#>
@property (nonatomic, copy) void(^commentBtnClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
