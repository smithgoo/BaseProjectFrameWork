//
//  FirstTableViewCell.m
//  MainProject
//
//  Created by 王朋 on 2017/5/2.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

+(NSString*)kind {
    
    return @"FirstTableViewCell";
    
}

+(instancetype)cellWithTableView:(UITableView*)tableView {
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FirstTableViewCell kind]];
    
    if (!cell) {
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FirstTableViewCell kind]];
    }
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor =[UIColor whiteColor];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    [self setupUI];
    
    return self;
}

-(void)setupUI {


}

@end
