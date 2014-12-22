//
//  XXStatusCell.h
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXStatusFrame;

@interface XXStatusCell : UITableViewCell

@property (nonatomic, strong) XXStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
