//
//  SLAlert.m
//  SLAlertView
//
//  Created by Mac－pro on 17/3/21.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import "SLAlert.h"
#import "UIView+SLAutolayout.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define alertX 50
#define alertH 400
#define margin_viewToview 1
#define buttonHeight 40
#define titleViewHeight 40
#define margin_btnTobtn 1

#define DefaultTranslucenceColor [UIColor colorWithRed:255 / 255.0f green:255 / 255.0 blue:255 / 255.0 alpha:0.9]
#define DefaultSeparatorColor [UIColor clearColor]
#define DefaultBackgroundColor DefaultTranslucenceColor
#define DefaultTextColor [UIColor darkGrayColor]
#define DefaultOtherBtnTextColor [UIColor darkGrayColor]
#define DefaultCancelBtnBtnTextColor [UIColor darkGrayColor]

@interface SLAlert()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, copy) void(^clickHandler)(SLAlert * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle);

@end

@implementation SLAlert

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SLAlertProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles settingHandler:(void (^)(SLAlert * _Nonnull))settingHandler clickHandler:(void (^)(SLAlert * _Nonnull, NSInteger, NSString * _Nullable))clickHandler {
    UIView *currentView = [SLAlert getCurrentVc].view;
    
    SLAlert *alert = [[SLAlert alloc] initWithFrame:currentView.frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:settingHandler clickHandler:clickHandler];
    
    [currentView addSubview:alert];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles clickHandler:(void (^)(SLAlert * _Nonnull, NSInteger, NSString * _Nullable))clickHandler {
    
    UIView *currentView = [SLAlert getCurrentVc].view;
    
    SLAlert *alert = [[SLAlert alloc] initWithFrame:currentView.frame title:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:nil clickHandler:clickHandler];
    
    [currentView addSubview:alert];
    
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles settingHandler:(void (^)(SLAlert * _Nonnull))settingHandler {
    
    UIView *currentView = [SLAlert getCurrentVc].view;
    
    SLAlert *alert = [[SLAlert alloc] initWithFrame:currentView.frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:settingHandler clickHandler:nil];
    
    [currentView addSubview:alert];
    
}

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles {
    UIView *currentView = [SLAlert getCurrentVc].view;
    SLAlert *alert = [[SLAlert alloc] initWithFrame:currentView.frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles handler:nil clickHandler:nil];
    [currentView addSubview:alert];
}



- (instancetype)initWithFrame:(CGRect)frame title:(nullable NSString *)title message:(nullable NSString *)message delegate:(id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles handler:(void (^)(SLAlert * _Nonnull alert))handler clickHandler:(nullable void (^)(SLAlert * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (handler) {
            handler(self);
        }
        
        if (clickHandler) {
            _clickHandler = clickHandler;
        }
        
        _delegate = delegate;
        UIView *shadowView = [[UIView alloc] initWithFrame:frame];
        shadowView.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:10 / 255.0 blue:10 / 255.0 alpha:0.0];
        [self addSubview:shadowView];
        _shadowView = shadowView;
        
        
            
        [self prepareAlertWithFrame:frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
        // TODO: 记得删掉alert样式的shadow的手势
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
//        UITapGestureRecognizer *backtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenAlertView)];
//        [shadowView addGestureRecognizer:backtap];
    }
    return self;
}

- (void)prepareAlertWithFrame:(CGRect)frame title:(nullable NSString *)title message:(nullable NSString *)message delegate:(id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles {
    // alert view
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake(alertX, (screenH - alertH) / 2, screenW - 2 * alertX , alertH)];
    alert.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:10 / 255.0 blue:10 / 255.0 alpha:0.0];
    alert.layer.cornerRadius = 15.0f;
    alert.layer.masksToBounds = YES;
    [self addSubview:alert];
    _alertView = alert;
    
    // title view
    UIView *titleView = [[UIView alloc] init];
    [alert addSubview:titleView];
    
    [titleView addConstraint:NSLayoutAttributeLeft equalTo:alert offset:0];
    [titleView addConstraint:NSLayoutAttributeRight equalTo:alert offset:0];
    [titleView addConstraint:NSLayoutAttributeTop equalTo:alert offset:0];
    [titleView addConstraint:NSLayoutAttributeHeight equalTo:nil offset:titleViewHeight];
    
    [titleView layoutIfNeeded];
    
    // title label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    if (_titleFont) {
        titleLabel.font = _titleFont;
    } else {
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.numberOfLines = 0;
    
    [titleView addSubview:titleLabel];
    
    [titleLabel addConstraint:NSLayoutAttributeLeft equalTo:titleView offset:0];
    [titleLabel addConstraint:NSLayoutAttributeRight equalTo:titleView offset:0];
    [titleLabel addConstraint:NSLayoutAttributeCenterY equalTo:titleView offset:0];
    
    UIView *line_title_msg =[[UIView alloc] init];
    if (_separatorColor) {
        line_title_msg.backgroundColor = _separatorColor;
    } else {
        line_title_msg.backgroundColor = DefaultSeparatorColor;
    }
    [alert addSubview:line_title_msg];
    [line_title_msg addConstraint:NSLayoutAttributeHeight equalTo:nil offset:1];
    [line_title_msg addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom offset:0];
    [line_title_msg addConstraint:NSLayoutAttributeLeft equalTo:alert offset:0];
    [line_title_msg addConstraint:NSLayoutAttributeRight equalTo:alert offset:0];
    
    // message view
    UIView *messageView = [[UIView alloc] init];
    messageView.backgroundColor = [UIColor whiteColor];
    [alert addSubview:messageView];
    
    [messageView addConstraint:NSLayoutAttributeLeft equalTo:alert offset:0];
    [messageView addConstraint:NSLayoutAttributeRight equalTo:alert offset:0];
    [messageView addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom  offset:margin_viewToview];
    
    // message label
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    if (_messageFont) {
        messageLabel.font = _messageFont;
    } else {
        messageLabel.font = [UIFont systemFontOfSize:14];
    }
    
    messageLabel.text = message;
    [messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
    messageLabel.numberOfLines = 0;
    [alert addSubview:messageLabel];
    
    [messageLabel addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeTop offset:10];
    [messageLabel addConstraint:NSLayoutAttributeLeft equalTo:alert offset:20];
    [messageLabel addConstraint:NSLayoutAttributeRight equalTo:alert offset:-20];
    
    [messageView addConstraint:NSLayoutAttributeHeight equalTo:messageLabel offset:20];
    
    [messageLabel layoutIfNeeded];
    [messageView layoutIfNeeded];
    
    
    // cancel button
    UIButton *cancelBtn = [[UIButton alloc] init];
    if (cancelButtonTitle) {
        cancelBtn.tag = 0;
        if (_cancelTitleFont) {
            cancelBtn.titleLabel.font = _cancelTitleFont;
        } else {
            cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        
        if (_cancelBackgroundColor) {
            [cancelBtn setBackgroundColor:_cancelBackgroundColor];
        } else {
            [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        }
        if (_cancelBackgroundColor) {
            [cancelBtn setBackgroundColor:_cancelBackgroundColor];
        } else {
            [cancelBtn setBackgroundColor:DefaultBackgroundColor];
        }
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        if (_cancelTitleColor) {
            [cancelBtn setTitleColor:_cancelTitleColor forState:UIControlStateNormal];
        } else {
            [cancelBtn setTitleColor:DefaultCancelBtnBtnTextColor forState:UIControlStateNormal];
        }
        [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [alert addSubview:cancelBtn];
        
        [cancelBtn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:margin_viewToview];
        [cancelBtn addConstraint:NSLayoutAttributeLeft equalTo:alert toAttribute:NSLayoutAttributeLeft offset:0];
        [cancelBtn addConstraint:NSLayoutAttributeHeight equalTo:nil offset:buttonHeight];
        if (otherButtonTitles.count) {
            [cancelBtn addConstraint:NSLayoutAttributeWidth equalTo:nil offset:(screenW - 2 * alertX) / (otherButtonTitles.count + 1)];
        } else {
            [cancelBtn addConstraint:NSLayoutAttributeWidth equalTo:nil offset:(screenW - 2 * alertX) / 1];
        }
        
        UIView *line_msg_btn =[[UIView alloc] init];
        if (_separatorColor) {
            line_msg_btn.backgroundColor = _separatorColor;
        } else {
            line_title_msg.backgroundColor = DefaultSeparatorColor;
        }
        
        [alert addSubview:line_msg_btn];
        
        [line_msg_btn addConstraint:NSLayoutAttributeHeight equalTo:nil offset:1];
        [line_msg_btn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:0];
        [line_msg_btn addConstraint:NSLayoutAttributeLeft equalTo:alert offset:0];
        [line_msg_btn addConstraint:NSLayoutAttributeRight equalTo:alert offset:0];
        
        [cancelBtn layoutIfNeeded];
    }
    
    // other button
    NSMutableArray *otherBtns = [NSMutableArray array];
    if (otherButtonTitles.count) {
        
        [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *otherBtn = [[UIButton alloc] init];
            if (_otherTitleFont) {
                otherBtn.titleLabel.font = _otherTitleFont;
            } else {
                otherBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            }
            
            [otherBtn setBackgroundColor:[UIColor whiteColor]];
            [otherBtns addObject:otherBtn];
            if (_otherTitleColor) {
                [otherBtn setTitleColor:_otherTitleColor forState:UIControlStateNormal];
            } else {
                [otherBtn setTitleColor:DefaultOtherBtnTextColor forState:UIControlStateNormal];
            }
            if (_otherBackgroundColor) {
                [otherBtn setBackgroundColor:_otherBackgroundColor];
            } else {
                [otherBtn setBackgroundColor:DefaultBackgroundColor];
            }
            [otherBtn setTitle:obj forState:UIControlStateNormal];
            [otherBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [alert addSubview:otherBtn];
            
            [otherBtn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:margin_viewToview];
            [otherBtn addConstraint:NSLayoutAttributeHeight equalTo:nil offset:buttonHeight];
            
            // separator
            UIView *line_otherBtn =[[UIView alloc] init];
            if (_separatorColor) {
                line_otherBtn.backgroundColor = _separatorColor;
            } else {
                line_otherBtn.backgroundColor = DefaultSeparatorColor;
            }
            [alert addSubview:line_otherBtn];
            
            [line_otherBtn addConstraint:NSLayoutAttributeWidth equalTo:nil offset:1];
            [line_otherBtn addConstraint:NSLayoutAttributeHeight equalTo:otherBtn offset:0];
            [line_otherBtn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:margin_viewToview];
            
            if (cancelButtonTitle) {
                otherBtn.tag = idx + 1;
                [otherBtn addConstraint:NSLayoutAttributeWidth equalTo:nil offset:(screenW - 2 * alertX) / (otherButtonTitles.count + 1)];
                
                if (idx == 0) {
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:cancelBtn toAttribute:NSLayoutAttributeRight offset:margin_btnTobtn];
                    [line_otherBtn addConstraint:NSLayoutAttributeLeft equalTo:cancelBtn toAttribute:NSLayoutAttributeRight offset:0];
                } else {
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeRight offset:margin_btnTobtn];
                    [line_otherBtn addConstraint:NSLayoutAttributeLeft equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeRight offset:0];
                    
                }
            } else {
                otherBtn.tag = idx;
                [otherBtn addConstraint:NSLayoutAttributeWidth equalTo:nil offset:(screenW - 2 * alertX) / otherButtonTitles.count];
                if (idx == 0) {
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:alert toAttribute:NSLayoutAttributeLeft offset:0];
                    [line_otherBtn addConstraint:NSLayoutAttributeLeft equalTo:otherBtn toAttribute:NSLayoutAttributeRight offset:0];
                } else {
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeRight offset:margin_btnTobtn];
                    [line_otherBtn addConstraint:NSLayoutAttributeLeft equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeRight offset:0];
                }
            }
            [otherBtn layoutIfNeeded];
            
        }];
    }
    
    [alert layoutIfNeeded];
    
    [self setupColorsForTitleView:titleView titleLabel:titleLabel messageView:messageView messageLabel:messageLabel];
    
    // animate show
//    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:0 animations:^{
    [UIView animateWithDuration:0.25 animations:^{
         _shadowView.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:10 / 255.0 blue:10 / 255.0 alpha:0.4];
    }];
    
        // 根据内容更新高度
        CGRect alertFrame = alert.frame;
        alertFrame.origin.x = alertX;
        alertFrame.size.width = screenW - 2 * alertX;
        if (cancelButtonTitle && otherButtonTitles.count == 0) {
            alertFrame.size.height = CGRectGetMaxY(cancelBtn.frame);
        } else {
            alertFrame.size.height = CGRectGetMaxY(alert.subviews.lastObject.frame);
        }
        alertFrame.origin.y = (screenH - alertFrame.size.height) / 2;
        
        alert.frame = alertFrame;
        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.4;
    
    [self.alertView.layer addAnimation:animation forKey:@"showAlert"];

    
}

- (void)setupColorsForTitleView:(UIView *)titleView titleLabel:(UILabel *)titleLabel messageView:(UIView *)messageView messageLabel:(UILabel *)messageLabel {
    if (_titleBackgroundColor) {
        titleView.backgroundColor = _titleBackgroundColor;
    } else {
        titleView.backgroundColor = DefaultBackgroundColor;
    }
    if (_titleColor) {
        titleLabel.textColor = _titleColor;
    } else {
        titleLabel.textColor = DefaultTextColor;
    }
    if (_messageBackgroundColor) {
        messageView.backgroundColor = _messageBackgroundColor;
    } else {
        messageView.backgroundColor = DefaultBackgroundColor;
    }
    if (_messageColor) {
        messageLabel.textColor = _messageColor;
    } else {
        messageLabel.textColor = DefaultTextColor;
    }
}

- (void)buttonClick:(UIButton *)sender {
    [self hidenAlertView];
    if ([self.delegate respondsToSelector:@selector(alertView:didSelectedButtonWithButtonIndex:buttonTitle:)]) {
        [self.delegate alertView:self didSelectedButtonWithButtonIndex:sender.tag buttonTitle:sender.titleLabel.text];
    }
    
    if (_clickHandler) {
        _clickHandler(self,sender.tag,sender.titleLabel.text);
    }
    
}

- (void)hidenAlertView {
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:0 animations:^{
        
        _shadowView.alpha = 0.0f;
        _alertView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



// 获取当前控制器的view
- (UIView *)getCurrentView {
    return [self getCurrentVC].view;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIViewController *)getCurrentVc
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
