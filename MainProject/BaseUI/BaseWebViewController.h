//
//  BaseWebViewController.h
//  yxzj
//
//  Created by tokee on 15/11/25.
//  Copyright © 2015年 tokee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
            urlString:(NSString *)urlString
          titleString:(NSString *)titleString;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
