//
//  M_TableView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/16.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_TableView.h"
#import "M_TableViewCell.h"

@interface M_TableView ()<UITableViewDelegate,UITableViewDataSource>

/** 数据源 */
@property (nonatomic,strong) NSArray *dictArray;

@end

@implementation M_TableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.hidden = YES;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dictArray = @[@{@"title":@"我的资料"},
                           @{@"title":@"我的收藏"},
                           @{@"title":@"我的下载"},
                           @{@"title":@"我的音乐"}];
    }
    return self;
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dictArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    M_TableViewCell* cell = [M_TableViewCell cellWithTableView:self];
    cell.dataSource = self.dictArray[indexPath.row];
    return cell;
}

@end
