//
//  MineViewCell.h
//  MainProject
//
//  Created by 王朋 on 2018/9/3.
//  Copyright © 2018 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftTitle;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UILabel *rightContent;

@end

@interface MineHeadViewl : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nick;
@property (strong, nonatomic) IBOutlet UIImageView *iconLogo;
@property (strong, nonatomic) IBOutlet UIImageView *vipImg;
@property (strong, nonatomic) IBOutlet UILabel *currentCoin;

@end
