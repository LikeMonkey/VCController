//
//  commentObject.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/23.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface commentObject : NSObject
@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;
@end

NS_ASSUME_NONNULL_END
