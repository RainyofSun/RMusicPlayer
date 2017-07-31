//
//  R_WebViewController.h
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/7/22.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "R_RootViewController.h"

@interface R_WebViewController : R_RootViewController

/** origin url */
@property (nonatomic,copy) NSString *url;

/** embed webView */
@property (nonatomic,strong) UIWebView *webView;

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
