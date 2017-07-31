//
//  R_RootWebViewController.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_RootViewController.h"
/**
 * webView 基类
 */
@interface R_RootWebViewController : R_RootViewController

/** origin url */
@property (nonatomic,copy) NSString *url;

/** tint color of progress view */
@property (nonatomic,strong) UIColor *progressViewColor;

/**
 * get instance with url
 * @param url       url
 */
-(instancetype)initWithUrl:(NSString*)url;

/**
 * reload webview
 */
-(void)reloadWebView;

@end
