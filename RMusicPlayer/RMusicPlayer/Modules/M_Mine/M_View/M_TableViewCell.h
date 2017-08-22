//
//  M_TableViewCell.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/16.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M_TableViewCell : UITableViewCell

/**
 * Cell的复用
 */
+(instancetype)cellWithTableView:(UITableView*)tableView;

/**
 * 数据源
 */
@property (nonatomic,strong) NSDictionary *dataSource;

@end
