//
//  M_AdPageView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_AdPageView.h"
#import "UtilsMacros.h"

@interface M_AdPageView ()

/** 广告展示Imgview */
@property (nonatomic,strong) UIImageView *adView;
/** 倒计时按钮 */
@property (nonatomic,strong) UIButton *countBtn;
/** 计时器 */
@property (nonatomic,strong) NSTimer *countTimer;
/** 点击手势回调 */
@property (nonatomic,copy) TapBlock tapBlock;

@end

static int const showtime = 0;//广告显示的时间

@implementation M_AdPageView

-(NSTimer *)countTimer{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

-(instancetype)initWithFrame:(CGRect)frame withTapBlcok:(TapBlock)tapBlock{
    if (self = [super initWithFrame:frame]) {
        //广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        //跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
        
        //1.判断沙盒中是逗存在广告图片，如果存在就显示
        NSString* filepath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
        BOOL isExist = [self isFileExistWithFilePath:filepath];
        
        if (isExist) {
            //图片存在
            self.filePath = filepath;
            self.tapBlock = tapBlock;
            [self show];
        }
        //2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        [self getAdvertisingImage];
    }
    return self;
}

/**
 * 初始化广告页面
 */
-(void)getAdvertisingImage{
    
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"广告页保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        } else {
            NSLog(@"广告页保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 * 根据图片名拼接路径
 */
-(NSString*)getFilePathWithImageName:(NSString*)imageName{
    if (imageName) {
        NSArray* filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* filepath = [[filePaths objectAtIndex:0] stringByAppendingString:imageName];
        return filepath;
    }
    return nil;
}

/**
 * 判断文件是否存在
 */
-(BOOL)isFileExistWithFilePath:(NSString*)filePath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

@end
