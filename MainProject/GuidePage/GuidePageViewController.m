//
//  GuidePageViewController.m
//  MainProject
//
//  Created by 王朋 on 2017/4/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "GuidePageViewController.h"
@interface GuidePageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *guidePageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    //    _guidePageScrollView.bounces =NO;
    for (int index =0; index<4; index++) {
        UIImageView *imageView =[UIImageView new];
        [_guidePageScrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(index*km_screen_width));
            make.top.equalTo(_guidePageScrollView.mas_top);
            make.width.equalTo(@(km_screen_width));
            make.height.equalTo(@(km_screen_height));
        }];
        switch (index) {
            case 0:
                imageView.backgroundColor =[UIColor blackColor];
                
                break;
            case 1:
                imageView.backgroundColor =[UIColor redColor];
                
                break;
            case 2:
                imageView.backgroundColor =[UIColor grayColor];
                
                break;
            case 3:
                imageView.backgroundColor =[UIColor greenColor];
                
                break;
                
            default:
                break;
        }
    }
    
    _guidePageScrollView.contentSize =CGSizeMake(km_screen_width*4, 0);
    _guidePageScrollView.delegate =self;
    
    _guidePageScrollView.alwaysBounceHorizontal = NO;
    _guidePageScrollView.alwaysBounceVertical = NO;
    _guidePageScrollView.showsHorizontalScrollIndicator = NO;
    _guidePageScrollView.showsVerticalScrollIndicator = NO;
    _guidePageScrollView.pagingEnabled =YES;
    _pageView.numberOfPages =4;
    // Do any additional setup after loading the view from its nib.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.x-km_screen_width*3);
    float offX =scrollView.contentOffset.x-km_screen_width*3;
    if (_pageView.currentPage ==3 &&offX>=70) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLoad"];
//        [self.navigationController pushViewController:[SimpleViewController new] animated:YES];
        return;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _pageView.currentPage=((int)scrollView.contentOffset.x/km_screen_width);
    
}

@end
