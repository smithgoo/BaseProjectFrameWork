//
//  ShoppingCarRecommendCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ShoppingCarRecommendCell.h"
#import "RecommendCell.h"
@interface ShoppingCarRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end
@implementation ShoppingCarRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    layout.itemSize=CGSizeMake(km_screen_width/2, km_screen_width/2+80);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize=CGSizeZero;
    layout.footerReferenceSize=CGSizeZero;
    
    [_collection setCollectionViewLayout:layout];
    [_collection registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:@"RecommendCell"];
    _collection.pagingEnabled = YES;
    _collection.scrollEnabled =NO;
    _collection.backgroundColor =[UIColor whiteColor];
    _collection.showsHorizontalScrollIndicator =NO;
    _collection.bounces =NO;
    
    _collection.dataSource = self;
    _collection.delegate = self;
 
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCell" forIndexPath:indexPath];
    cell.layer.borderWidth =0.3;
    cell.layer.borderColor =km_rgb_hex(0xdfdfdf).CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"indexpath%@",indexPath);
}



@end
