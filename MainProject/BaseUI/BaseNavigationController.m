//
//  KMNavigationController.m
//  yxzj
//
//  Created by tokee on 15/9/19.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "BaseNavigationController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    /* UINavigationControllerDelegate */
////    self.delegate = self;
////    
////    /* swipe gesture */
////    __weak typeof(self) weakSelf = self;
////    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
////        /* UIGestureRecognizerDelegate */
////        self.interactivePopGestureRecognizer.delegate = weakSelf;
////        self.interactivePopGestureRecognizer.enabled = NO;
////    }
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///* set gesture no when pushViewController */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}
//
///* set gesture yes when showViewController */
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//    
//    /* if rootViewController, set delegate nil */
//    if (navigationController.viewControllers.count == 1) {
//        navigationController.interactivePopGestureRecognizer.enabled = NO;
//        navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

@end
