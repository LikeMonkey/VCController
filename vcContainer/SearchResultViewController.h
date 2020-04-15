//
//  SearchResultViewController.h
//  vcContainer
//
//  Created by ios 001 on 2019/12/18.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UITableViewController
@property (nonatomic, copy) void(^didSelectText)(NSString *selectedText);
@end

NS_ASSUME_NONNULL_END
