//
//  picktureContainer.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/24.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "picktureContainer.h"
#import "UIView+XMGExtension.h"

@implementation picktureContainer
{
    NSMutableArray *imageViewArr;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (int i =0; i<9; i++) {
        UIImageView *imagView = [[UIImageView alloc]init];
        [self addSubview:imagView];
        imagView.userInteractionEnabled = YES;
        imagView.tag = i;
        [temp addObject:imagView];
//        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//        [<#expression#> addGestureRecognizer:singalTap];
    }
    imageViewArr = temp;
}
-(void)setPicPathStringArray:(NSArray *)picPathStringArray{
    _picPathStringArray = picPathStringArray;
    for (long i =_picPathStringArray.count; i<imageViewArr.count; i++) {
        UIImageView *imageView = [imageViewArr objectAtIndex:i];
        imageView.hidden = YES;
    }
    if (_picPathStringArray.count == 0) {
        self.height = 0;
        self.width = 0;
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringArray];
    CGFloat itemH = 0;
    if (_picPathStringArray.count ==1) {
        UIImage *image = [UIImage imageNamed:_picPathStringArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height/image.size.width*itemW;
        }
    }else{
        itemH  = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringArray];
    CGFloat magin = 5;
    [_picPathStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx/perRowItemCount;
        UIImageView *imageView = [imageViewArr objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columnIndex*(itemW +magin), rowIndex*(itemH +magin), itemW,itemH);
    }];
    
    CGFloat w = perRowItemCount*itemW +(perRowItemCount -1) *magin;
    int columCount = ceil(_picPathStringArray.count *1.0/perRowItemCount);
    CGFloat h = columCount *itemH +(columCount -1) *magin;
    self.width = w;
    self.height  = h;
}
-(CGFloat)itemWidthForPicPathArray:(NSArray *)array{
    if (array.count == 1) {
        return 120;
        
    }else{
        CGFloat w = [UIScreen mainScreen].bounds.size.width>320?80:70;
        return w;
    }
}
-(NSInteger)perRowItemCountForPicPathArray:(NSArray *)array{
    if (array.count<3) {
        return array.count;
    }else if (array.count<=4){
        return 2;
    }else{
        return 3;
    }
}
@end
