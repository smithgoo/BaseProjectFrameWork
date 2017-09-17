//
//  BaseWebViewController.m
//  yxzj
//
//  Created by tokee on 15/11/25.
//  Copyright © 2015年 tokee. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>

@end

@implementation BaseWebViewController
{
    BOOL _isLoad;
    NSString *_urlString;
    NSString *_titleString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil urlString:(NSString *)urlString titleString:(NSString *)titleString {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _urlString = urlString;
        _titleString = titleString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![BaseInfo isEmptyOrNil:_titleString]) {
        self.lblTitle.text = _titleString;
    }
    
//    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self)
//        [BaseInfo showLoadingMessage];
//        [self.webView reload];
//    }];
    
    [[self.btnBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    if ([self->_titleString isEqualToString:@"公益人员"]) {
        
    }
    else if ([self->_titleString isEqualToString:@"功能介绍"]) {
        
    }
    _isLoad = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isLoad) {
        _isLoad = YES;
//        [BaseInfo showLoadingMessage];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }
}

- (void)dealloc {
    NSLog(@"%@:dealloc", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    if ([_titleString isEqualToString:@"实时视频"]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([_titleString isEqualToString:@"实时视频"]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [BaseInfo hideMessage];
//    [self.webView.scrollView.mj_header endRefreshing];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [BaseInfo showLoadingMessage];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [BaseInfo hideMessage];
//    [self.webView.scrollView.mj_header endRefreshing];
}

@end
