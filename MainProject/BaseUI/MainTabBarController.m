//
//  MainTabBarController.m
//  findbabyapp
//
//  Created by Mike on 2016/12/13.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "HomePageViewController.h"
#import "CircleOfFriendsViewController.h"
#import "MineViewController.h"
#import "QuickLoginViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

 
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //示例代码
    HomePageViewController *homePage =[HomePageViewController new];
    [self createTabBarItem:homePage title:@"首页" image:@"huayihuaweixuanzhong" imageSelected:@"huayihuaxuanzhong"];
    BaseNavigationController *indexNav = [[BaseNavigationController alloc ]initWithRootViewController:homePage];
    [self addChildViewController:indexNav];
    
    
    CircleOfFriendsViewController *circleOfFriends =[[CircleOfFriendsViewController alloc] initWithNibName:@"CircleOfFriendsViewController" bundle:nil];
    [self createTabBarItem:circleOfFriends title:@"朋友圈" image:@"huayihuaweixuanzhong" imageSelected:@"huayihuaxuanzhong"];
    BaseNavigationController *circleNav = [[BaseNavigationController alloc ]initWithRootViewController:circleOfFriends];
    [self addChildViewController:circleNav];
    
    QuickLoginViewController *mine =[[QuickLoginViewController alloc] initWithNibName:@"QuickLoginViewController" bundle:nil];
    [self createTabBarItem:mine title:@"我的" image:@"huayihuaweixuanzhong" imageSelected:@"huayihuaxuanzhong"];
    mine.isNeedThirdLogin =YES;
    BaseNavigationController *mineNav = [[BaseNavigationController alloc ]initWithRootViewController:mine];
    [self addChildViewController:mineNav];
    
    
    
}


//修改字体大小颜色和图片 图片位置已经注释掉 假设有单独图片不需要文字的 只要解开注释调试就行
- (void)createTabBarItem:(UIViewController *)vc title:(NSString *)title image:(NSString *)image imageSelected:(NSString *)imageSelected {
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"Helvetica" size:15.0], NSFontAttributeName, nil]
                        forState:UIControlStateNormal];
    
//    UIOffset offset;
//    offset.horizontal = 0.0;
//    
//    if ([BaseInfo isEmptyOrNil:title]) {
//        [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)]; 
//    }
//    else {
//        offset.vertical = -2.0;
//        [vc.tabBarItem setTitlePositionAdjustment:offset];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[BaseNavigationController class]]) {
//        BaseNavigationController *selectedVC = (BaseNavigationController *)self.selectedViewController;
//        PublishedCircleOfFriendsViewController *publishVC = [[PublishedCircleOfFriendsViewController alloc]initWithNibName:@"PublishedCircleOfFriendsViewController" bundle:nil];
//        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:publishVC];
//        [selectedVC.viewControllers.firstObject presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}
@end
