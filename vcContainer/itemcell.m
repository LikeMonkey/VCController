//
//  itemcell.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "itemcell.h"

@interface itemcell ()
/** <#assign属性注释#> */
@property (nonatomic,strong) UIImageView *bgImage;

@end
@implementation itemcell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    [self.contentView addSubview:self.bgImage];
    self.bgImage.frame = self.contentView.frame;
}

- (UIImageView *)bgImage {
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];;
        [_bgImage setImage:[UIImage imageNamed:@"headerView"]];
    }
    return _bgImage;
}
@end
