//
//  KMViewController.h
//  yxzj
//
//  Created by tokee on 15/9/19.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

/**
 用于 ViewController 回调
 */
@property (nonatomic, copy) void (^callback)(id model);

//类似模态视图的push
- (void)pushAniMation:(NSString*)VCStr withPropertyDic:(NSDictionary*)dic;
//类似模态视图的pop
- (void)popAnimation;

 @end
