//
//  M_TableViewCell.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/16.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_TableViewCell.h"

static NSString* cellID = @"mine";

@interface M_TableViewCell ()

/** 小三角 */
@property (nonatomic,strong) UIImageView *triangle;
/** type */
@property (nonatomic,strong) UILabel *typeLabel;

@end

@implementation M_TableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    M_TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[M_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    if (dataSource[@"title"]) {
        self.typeLabel.text = dataSource[@"title"];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.triangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];
}

#pragma mark - getter
-(UIImageView *)triangle{
    if (!_triangle) {
        _triangle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_Triangle"]];
        [self.contentView addSubview:_triangle];
    }
    return _triangle;
}

-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
