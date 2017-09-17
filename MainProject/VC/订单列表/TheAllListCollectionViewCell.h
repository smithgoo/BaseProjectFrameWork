//
//  TheAllListCollectionViewCell.h
//  MainProject
//
//  Created by 王朋 on 2017/5/17.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheAllListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic,strong) UIViewController *superVC;
@end
