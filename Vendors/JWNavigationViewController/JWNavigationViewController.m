//
//  JWNavigationViewController.m
//  Version 0.1
//
//  Created by Jason Wong [http://weibo.com/macji] on 13-2-8.
//  Copyright (c) 2013年 iHu.im. All rights reserved.
//

#import "JWNavigationViewController.h"

#define kPushAnimationDuration  0.4
#define kOverlayViewAlpha       0.5
#define kTransformScale         0.98
#define kBoundaryWidthRatio     0.25

@interface JWNavigationViewController () {
    NSMutableArray *_screenshotImages;
    UIView *_backgroundView;
    UIImageView *_screenshotAView;
    UIImageView *_screenshotBView;
}

@end

@implementation JWNavigationViewController

- (void)loadView {
    [super loadView];
    
    self.navigationBarHidden = YES;
    
    _screenshotImages = [[NSMutableArray alloc] init];
    _backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backgroundView];
    
    _screenshotAView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _screenshotAView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_screenshotAView];
    
    _screenshotBView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _screenshotBView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _screenshotBView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_screenshotBView.bounds cornerRadius:0.0f].CGPath;
    _screenshotBView.layer.shadowColor = [UIColor blackColor].CGColor;
    _screenshotBView.layer.shadowOpacity = 0.65f;
    _screenshotBView.layer.shadowRadius = 5.0f;
    _screenshotBView.layer.shadowOffset = CGSizeMake(0.0f, 0);
    _screenshotBView.clipsToBounds = NO;
    [self.view addSubview:_screenshotBView];
    [self hideMaskViews:YES];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    panGesture.maximumNumberOfTouches = 1;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
    tap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap];
//    LL_RELEASE_SAFELY(tap);
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor], UITextAttributeTextColor,
                                               [UIColor clearColor], UITextAttributeTextShadowColor,
                                               [UIFont boldSystemFontOfSize:18], UITextAttributeFont,
                                               [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

- (void)dealloc {
    [_screenshotImages release];
    [_screenshotAView release];
    [_screenshotBView release];
    [_backgroundView release];
    
    [super dealloc];
}

- (UIImage *)getShotWithView:(UIView *)view {
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)showMaskViewsWithImageA:(UIImage *)imageA imageB:(UIImage *)imageB {
    _screenshotAView.image = imageA;
    _screenshotBView.image = imageB;
    
    [self hideMaskViews:NO];
    [self.view bringSubviewToFront:_backgroundView];
    [self.view bringSubviewToFront:_screenshotAView];
    [self.view bringSubviewToFront:_screenshotBView];
}

- (void)hideMaskViews:(BOOL)hide {
    _backgroundView.hidden = hide;
    _screenshotAView.hidden = hide;
    _screenshotBView.hidden = hide;
    
    if (hide) {
        _screenshotAView.image = nil;
        _screenshotBView.image = nil;
    }
}

- (void)maskViewConfigWithScale:(CGFloat)scale
                           left:(CGFloat)left
                          alpha:(CGFloat)alpha {
    CGRect frame = _screenshotBView.frame;
    frame.origin.x = left;
    
    _screenshotAView.transform = CGAffineTransformMakeScale(scale, scale);
    _screenshotAView.alpha = 1 - alpha;
    _screenshotBView.frame = frame;
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    if (!_screenshotImages || self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    
    UIImage *imageA = [self getShotWithView:self.view];
    [super pushViewController:viewController animated:NO];
    if (!animated) {
        _screenshotAView.image = imageA;
        [_screenshotImages addObject:_screenshotAView.image];
        return;
    }
    
    [self showMaskViewsWithImageA:imageA imageB:[self getShotWithView:self.view]];
    [self maskViewConfigWithScale:1 left:self.view.frame.size.width alpha:0];
    
    // push view animate
    __block JWNavigationViewController *this = self;
    [UIView animateWithDuration:kPushAnimationDuration animations:^{
        [this maskViewConfigWithScale:kTransformScale left:0 alpha:kOverlayViewAlpha];
    } completion:^(BOOL finished) {
        if (_screenshotAView.image) {
            [_screenshotImages addObject:_screenshotAView.image];
        }
        [this hideMaskViews:YES];
        
        if (completion) {
            completion();
        }
    }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {    
    [self showMaskViewsWithImageA:[_screenshotImages lastObject]
                           imageB:[self getShotWithView:self.view]];
    [self maskViewConfigWithScale:kTransformScale left:0 alpha:kOverlayViewAlpha];
    
    // push view animate
    __block JWNavigationViewController *this = self;
    [UIView animateWithDuration:animated ? kPushAnimationDuration : 0 animations:^{
        [this maskViewConfigWithScale:1 left:this.view.frame.size.width alpha:0];
    } completion:^(BOOL finished) {
        [this hideMaskViews:YES];
        [_screenshotImages removeLastObject];
        UIViewController *vc = [super popViewControllerAnimated:NO];
        if ([vc isKindOfClass:[UIView class]] && [vc respondsToSelector:@selector(leaveViewControllerDoAction)]) {
//            [(UIView *)vc leaveViewControllerDoAction];
        }
    }];

    return [self.viewControllers lastObject];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    [_screenshotImages removeAllObjects];
    return [super popToRootViewControllerAnimated:animated];
}

// TODO
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSUInteger idx = [self.viewControllers indexOfObject:viewController];
    [_screenshotImages removeObjectsInRange:NSMakeRange(idx, _screenshotImages.count - idx)];
    
    return [super popToViewController:viewController animated:animated];
}

- (void)moveView:(UIPanGestureRecognizer *)sender {
    if (_screenshotImages.count < 1) return;
    
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
        if (pan.state == UIGestureRecognizerStateBegan) {
            [self showMaskViewsWithImageA:[_screenshotImages lastObject]
                                   imageB:[self getShotWithView:self.view]];
            [self maskViewConfigWithScale:kTransformScale left:0 alpha:kOverlayViewAlpha];
        }
        
        else if (pan.state == UIGestureRecognizerStateChanged) {
            CGPoint point = [pan translationInView:self.view];
            CGRect frame = _screenshotBView.frame;
            frame.origin.x = point.x > 0 ? point.x : 0;
            CGFloat scale = kTransformScale + (1 - kTransformScale) / self.view.frame.size.width * frame.origin.x;
            CGFloat alpha = kOverlayViewAlpha - kOverlayViewAlpha / self.view.frame.size.width * frame.origin.x;
            
            _screenshotBView.frame = frame;
            _screenshotAView.alpha = 1 - alpha;
            _screenshotAView.transform = CGAffineTransformMakeScale(scale, scale);
        }
        
        else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
            BOOL x = _screenshotBView.frame.origin.x > _screenshotAView.frame.size.width * kBoundaryWidthRatio;
            __block JWNavigationViewController *this = self;
            [UIView animateWithDuration:kPushAnimationDuration animations:^{
                CGFloat left  = x ? this.view.frame.size.width : 0;
                CGFloat scale = x ? 1 : kTransformScale;
                CGFloat alpha = x ? 0 : kOverlayViewAlpha;
                [this maskViewConfigWithScale:scale left:left alpha:alpha];
            } completion:^(BOOL finished) {
                [this hideMaskViews:YES];
                
                if (x) {
                    [_screenshotImages removeLastObject];
                    [super popViewControllerAnimated:NO];
                }
            }];
        }
    }
}

- (void)doTap {
    
}

@end

/*
 // 灵感来自Xcode的双指前进后退，
 // 线上实例请看 https://itunes.apple.com/cn/app/du-zhi-hu/id549386319?mt=8
 // 如果你有更好的方法，欢迎和我交流:
 //  - eMail:   me[AT]ihu.im
 //  - Weibo:   http://weibo.com/macji
 //  - Twitter: http://twitter.com/macji
 
 - 关于 Push
   1. push的前生成当前截图，
   2. push后生成截图
   3. 进行动画
 
 - 关于 Pop
   1. 获取最后一个截图
   2. 生成当前截图
   3. 进行动画
 
 - 关于手势
   1. UIGestureRecognizerStateBegan 的时候和Pop一样
   2. UIGestureRecognizerStateChanged 移动相关View
   3. UIGestureRecognizerStateEnded 动画剩余路径
 
 */