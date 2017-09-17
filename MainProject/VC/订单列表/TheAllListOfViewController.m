//
//  TheAllListOfViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "TheAllListOfViewController.h"
#import "TheAllListCollectionViewCell.h"
@interface TheAllListOfViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation TheAllListOfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI{
    NSArray *arr =@[@"全部",@"待付款",@"待收货",@"已完成",@"已取消"];
    [_segmentView initWithSectionTitles:arr];
    
    _segmentView.backgroundColor = [UIColor whiteColor];
    _segmentView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentView.selectionIndicatorColor = km_rgb_hex(0xDE031F);
    _segmentView.selectionIndicatorHeight = 2.0;
    _segmentView.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    _segmentView.titleTextAttributes = @{NSForegroundColorAttributeName:km_rgb_hex(0x999999), NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
    _segmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:km_rgb_hex(0xDE031F), NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
    
    __block typeof(self) wkself =self;
    [_segmentView setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"%ld",index);
        [wkself collectionViewScrollLocaltion:index];
    }];
    
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    layout.itemSize=CGSizeMake(km_screen_width, km_screen_height - 108);
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize=CGSizeZero;
    layout.footerReferenceSize=CGSizeZero;
    
    [_collection setCollectionViewLayout:layout];
    [_collection registerNib:[UINib nibWithNibName:@"TheAllListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TheAllListCollectionViewCell"];
    _collection.pagingEnabled = YES;
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
    TheAllListCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"TheAllListCollectionViewCell" forIndexPath:indexPath];
    cell.superVC =self;
    if (indexPath.item ==0) {
        cell.backgroundColor =[UIColor whiteColor];
    } else if (indexPath.item ==1) {
        cell.backgroundColor =[UIColor redColor];
    } else if (indexPath.item ==2) {
        cell.backgroundColor =[UIColor blueColor];
    } else if (indexPath.item ==3) {
        cell.backgroundColor =[UIColor grayColor];
    } else if (indexPath.item ==4) {
        cell.backgroundColor =[UIColor greenColor];
    }
    
    return cell;
}

-(void)collectionViewScrollLocaltion:(NSInteger )itemIndex {
    
    NSLog(@"%ld-----item",itemIndex);

    
    NSIndexPath *indexPath =[NSIndexPath indexPathForItem:itemIndex inSection:0];
    
    [_collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    if(_titleArr.count == 0)
//        return;
    if(scrollView == _collection){
        CGFloat offsetX = scrollView.contentOffset.x;
        int index = (offsetX /km_screen_width);
        if (_segmentView.selectedSegmentIndex != index) {
//            _topName =[_titleArr objectAtIndex:index];
//            [_totalListArr removeAllObjects];
            _segmentView.selectedSegmentIndex =index;
//            _requestIndex =[_idArr objectAtIndex:index];
//            _pageIndex =1;
//            [self initWebData:_requestIndex];
        }
//        [_collection reloadData];
        
    }
}

@end
