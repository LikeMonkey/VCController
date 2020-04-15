//
//  CollecCell.m
//  vcContainer
//
//  Created by ios 001 on 2019/12/17.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "CollecCell.h"
#import "itemcell.h"
#define cellWidth [UIScreen mainScreen].bounds.size.width
#define cellhight 100
@interface CollecCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CollecCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    CollecCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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
    [self.contentView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor redColor];
}
#pragma mark ——— collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    itemcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([itemcell class]) forIndexPath:indexPath];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell的宽度＊cell个数＋一行的间隙个数＊间隙宽度=屏幕的宽度
    if (indexPath.item == 0) {
        return CGSizeMake(ceil(cellWidth/2), ceil(cellhight*2));
    }else{
       return CGSizeMake(ceil(cellWidth/2), ceil(cellhight));
    }

}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //cell的宽度＊cell个数＋一行的间隙个数＊间隙宽度=屏幕的宽度
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
//列
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}
//行
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled=YES;
        //_collectionView.userInteractionEnabled=NO;
        /** item 不可被点击*/
        // _collectionView.allowsSelection=YES;
        //开启分页
        _collectionView.pagingEnabled = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.showsHorizontalScrollIndicator=NO;
        //注册
        [_collectionView registerClass:[itemcell class] forCellWithReuseIdentifier:NSStringFromClass([itemcell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}
@end
