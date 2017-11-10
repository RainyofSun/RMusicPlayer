//
//  M_BaseImageView.m
//  RMusicPlayer
//
//  Created by 刘冉 on 2017/8/27.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "M_BaseImageView.h"

@implementation M_BaseImageView

- (void)setImageWithUrl:(NSString *)url {
    [self setImageWithUrl:url placeHolder:nil];
}
- (void)setImageWithURL:(NSURL *)URL {
    [self setImageWithURL:URL placeHolder:nil];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image {
    [self setImageWithUrl:url placeHolder:image finishHandle:nil];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image {
    [self setImageWithURL:URL placeHolder:image finishHandle:nil];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {
    [self setImageWithUrl:url placeHolder:image progressHandle:nil finishHandle:finishHandle];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image finishHandle:(void (^)(BOOL, UIImage *))finishHandle {
    [self setImageWithURL:URL placeHolder:image progressHandle:nil finishHandle:finishHandle];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {
    [self setImageWithURL:[NSURL URLWithString:url] placeHolder:image progressHandle:progressHandle finishHandle:finishHandle];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {
    
    [self setImageWithURL:URL placeholder:image options:YYWebImageOptionAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressHandle) {
            progressHandle(receivedSize * 1.0 / expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (finishHandle) {
            finishHandle(error == nil, image);
        }
    }];
}

-(void)setImageWithUrl:(NSString *)url placeHolderImage:(UIImage *)image loadingFailImage:(UIImage *)failImage{
    //清除图片缓存
    //    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    //    [[YYImageCache sharedCache].diskCache removeAllObjects];
    
    __weak typeof(&*self)weakSelf = self;
    [self setImageWithURL:[NSURL URLWithString:url] placeholder:image options:YYWebImageOptionAllowInvalidSSLCertificates | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error) {
            weakSelf.image = failImage;
        }
    }];
}

-(void)setRadiusWithSize:(CGSize)radiusSize{
    [self layoutIfNeeded];
    //切出部分圆角
    CGRect rect = self.bounds;
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radiusSize];
    CAShapeLayer* maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end
