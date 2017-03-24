//
//  SLActionSheet.m
//  SLAlertView
//
//  Created by Mac－pro on 17/3/21.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import "SLActionSheet.h"
#import "UIView+SLAutolayout.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define shadowW self.frame.size.width
#define shadowH self.frame.size.height
#define animationTime 0.4

#define margin_partTopart 10
#define margin_partTobottom 10
#define margin_leading_trailling 10
#define margin_edge 20



#define margin_viewToview 1
#define buttonHeight 50.0f
#define titleViewHeight 40
#define margin_btnTobtn 1.0f
#define separatorHeight 1

#define DefaultCornerRadius 15

#define DefaultTranslucenceColor [UIColor colorWithRed:255 / 255.0f green:255 / 255.0 blue:255 / 255.0 alpha:0.9]
#define DefaultSeparatorColor [UIColor clearColor]
#define DefaultBackgroundColor DefaultTranslucenceColor
#define DefaultTextColor [UIColor lightGrayColor]
#define DefaultOtherBtnTextColor [UIColor darkGrayColor]
#define DefaultCancelBtnBtnTextColor [UIColor darkGrayColor]

@interface SLActionSheet()

@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *sheet;

@property (nonatomic, copy) void(^clickHandler)(SLActionSheet * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle);

@end

@implementation SLActionSheet

+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SLActionSheetProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles settingHandler:(void (^)(SLActionSheet * _Nonnull))settingHandler clickHandler:(nullable void (^)(SLActionSheet * _Nonnull, NSInteger, NSString * _Nullable))clickHandler{
    UIView *currentView = [SLActionSheet getCurrentVc].view;
    SLActionSheet *sheet = [[SLActionSheet alloc] initWithFrame:currentView.frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:settingHandler clickHandler:clickHandler];
    [currentView addSubview:sheet];

}

+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SLActionSheetProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickHandler:(nullable void (^)(SLActionSheet * _Nonnull, NSInteger, NSString * _Nullable))clickHandler{
    
    UIView *currentView = [SLActionSheet getCurrentVc].view;
    SLActionSheet *sheet = [[SLActionSheet alloc] initWithFrame:currentView.frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:nil clickHandler:clickHandler];
    [currentView addSubview:sheet];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message delegate:(id<SLActionSheetProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles settingHandler:(void (^)(SLActionSheet * _Nonnull))settingHandler clickHandler:(nullable void (^)(SLActionSheet * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler{
    
    self = [self initWithFrame:frame];
    if (self) {
        
        if (settingHandler) {
            settingHandler(self);
        }
        
        if (clickHandler) {
            _clickHandler = clickHandler;
        }
        
        _delegate = delegate;
        
        UIView *shadowView = [[UIView alloc] initWithFrame:frame];
        shadowView.backgroundColor = [UIColor colorWithRed:10 / 255.0 green:10 / 255.0 blue:10 / 255.0 alpha:0.0];
        [self addSubview:shadowView];
        _shadowView = shadowView;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        UITapGestureRecognizer *backtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenSheetView)];
        [shadowView addGestureRecognizer:backtap];
        
        CGFloat x = 0;
        CGFloat y = shadowH;
        CGFloat w = shadowW;
        CGFloat h = 300;
        
        UIView *sheet = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        sheet.backgroundColor = [UIColor clearColor];
        self.sheet = sheet;
        [self addSubview:sheet];
        
        [self prepareSheetWithFrame:frame title:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
        
    }
    return self;
}

- (void)prepareSheetWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message delegate:(id<SLActionSheetProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    // 下半部分
    UIView *underPart = [[UIView alloc] init];
    underPart.backgroundColor = [UIColor whiteColor];
    underPart.layer.cornerRadius = DefaultCornerRadius;
    underPart.layer.masksToBounds = YES;
    
    if (cancelButtonTitle) {
        
        [_sheet addSubview:underPart];
        [underPart addConstraint:NSLayoutAttributeLeft equalTo:_sheet offset:margin_leading_trailling];
        [underPart addConstraint:NSLayoutAttributeRight equalTo:_sheet offset:-margin_leading_trailling];
        [underPart addConstraint:NSLayoutAttributeBottom equalTo:_sheet offset:-margin_partTobottom];
        [underPart addConstraint:NSLayoutAttributeHeight equalTo:nil offset:buttonHeight];
        // cancel button
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.tag = 0;
        if (_cancelBackgroundColor) {
            [cancelBtn setBackgroundColor:_cancelBackgroundColor];
        } else {
            [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        }
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        if (_cancelTitleColor) {
            [cancelBtn setTitleColor:_cancelTitleColor forState:UIControlStateNormal];
        } else {
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (_cancelTitleFont) {
            cancelBtn.titleLabel.font = _cancelTitleFont;
        } else {
            cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        
        [cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [underPart addSubview:cancelBtn];
        [cancelBtn addConstraint:NSLayoutAttributeTop equalTo:underPart offset:0];
        [cancelBtn addConstraint:NSLayoutAttributeLeft equalTo:underPart offset:0];
        [cancelBtn addConstraint:NSLayoutAttributeRight equalTo:underPart offset:0];
        [cancelBtn addConstraint:NSLayoutAttributeBottom equalTo:underPart offset:0];
        
        [cancelBtn layoutIfNeeded];
        [underPart layoutIfNeeded];
    }
    
    
    
    // 上半部分
    UIView *upperPart = [[UIView alloc] init];
    upperPart.backgroundColor = [UIColor clearColor];
    upperPart.layer.cornerRadius = DefaultCornerRadius;
    upperPart.layer.masksToBounds = YES;
    [_sheet addSubview:upperPart];
    
    if (cancelButtonTitle) {
        [upperPart addConstraint:NSLayoutAttributeBottom equalTo:underPart toAttribute:NSLayoutAttributeTop offset:-margin_partTopart];
    } else {
        [upperPart addConstraint:NSLayoutAttributeBottom equalTo:_sheet toAttribute:NSLayoutAttributeBottom offset:-margin_partTopart];
    }
    
    [upperPart addConstraint:NSLayoutAttributeLeft equalTo:_sheet offset:margin_leading_trailling];
    [upperPart addConstraint:NSLayoutAttributeRight equalTo:_sheet offset:-margin_leading_trailling];
    [upperPart addConstraint:NSLayoutAttributeTop equalTo:_sheet offset:0];
    
    UIView *titleView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    if (title) {
        // title view
        
        [upperPart addSubview:titleView];
        
        [titleView addConstraint:NSLayoutAttributeLeft equalTo:upperPart offset:0];
        [titleView addConstraint:NSLayoutAttributeRight equalTo:upperPart offset:0];
        [titleView addConstraint:NSLayoutAttributeTop equalTo:upperPart offset:0];
        
        // title label
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.backgroundColor = [UIColor clearColor];
        if (_titleFont) {
            titleLabel.font = _titleFont;
        } else {
            titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.numberOfLines = 0;
        [titleView addSubview:titleLabel];
        
        [titleLabel addConstraint:NSLayoutAttributeLeft equalTo:titleView offset:margin_edge];
        [titleLabel addConstraint:NSLayoutAttributeRight equalTo:titleView offset:-margin_edge];
        [titleLabel addConstraint:NSLayoutAttributeTop equalTo:titleView offset:margin_edge];
        [titleLabel addConstraint:NSLayoutAttributeBottom equalTo:titleView offset:-margin_edge];
        
        UIView *line_title_msg =[[UIView alloc] init];
        if (_separatorColor) {
            line_title_msg.backgroundColor = _separatorColor;
        } else {
            line_title_msg.backgroundColor = DefaultSeparatorColor;
        }
        [_sheet addSubview:line_title_msg];
        [line_title_msg addConstraint:NSLayoutAttributeHeight equalTo:nil offset:1];
        [line_title_msg addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom offset:0];
        [line_title_msg addConstraint:NSLayoutAttributeLeft equalTo:titleView offset:0];
        [line_title_msg addConstraint:NSLayoutAttributeRight equalTo:titleView offset:0];
        
        
    }
    
    
    
    //---
    // message view
    UIView *messageView = [[UIView alloc] init];
    UILabel *messageLabel = [[UILabel alloc] init];
    if (message) {
        [upperPart addSubview:messageView];
        
        [messageView addConstraint:NSLayoutAttributeLeft equalTo:upperPart offset:0];
        [messageView addConstraint:NSLayoutAttributeRight equalTo:upperPart offset:0];
        if (title) {
            [messageView addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom offset:separatorHeight];
        } else {
            [messageView addConstraint:NSLayoutAttributeTop equalTo:upperPart toAttribute:NSLayoutAttributeTop offset:0];
        }
        
        
        // message label
        
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.text = message;
        messageLabel.backgroundColor = [UIColor clearColor];
        [messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
        messageLabel.numberOfLines = 0;
        if (_messageFont) {
            messageLabel.font = _messageFont;
        } else {
            messageLabel.font = [UIFont systemFontOfSize:13];
        }
        
        [messageView addSubview:messageLabel];
        
        [messageLabel addConstraint:NSLayoutAttributeLeft equalTo:messageView offset:margin_edge];
        [messageLabel addConstraint:NSLayoutAttributeRight equalTo:messageView offset:-margin_edge];
        [messageLabel addConstraint:NSLayoutAttributeTop equalTo:messageView offset:margin_edge];
        [messageLabel addConstraint:NSLayoutAttributeBottom equalTo:messageView offset:-margin_edge];

    }
    

   
    
    
    
    [titleLabel layoutIfNeeded];
    [titleView layoutIfNeeded];
    [messageLabel layoutIfNeeded];
    
    CGRect messageViewFrame = messageView.frame;
    messageViewFrame.size.height = messageLabel.frame.size.height + 2 * margin_edge;
    messageView.frame = messageViewFrame;
    [messageView layoutIfNeeded];
    [upperPart layoutIfNeeded];
    
    [_sheet layoutIfNeeded];
    
    // other button
    
    __block CGFloat otherButtonsHeight = 0;
    
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
            
            [_sheet addSubview:otherBtn];
            
            [otherBtn addConstraint:NSLayoutAttributeHeight equalTo:nil offset:buttonHeight];
           
            if (title) {
                if (message) { // 有title 有message
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:messageView offset:0];
                    [otherBtn addConstraint:NSLayoutAttributeRight equalTo:messageView offset:0];
                } else { // 有title 没有message
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:titleView offset:0];
                    [otherBtn addConstraint:NSLayoutAttributeRight equalTo:titleView offset:0];
                }
            } else {
                if (message) { // 没有title 有message
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:messageView offset:0];
                    [otherBtn addConstraint:NSLayoutAttributeRight equalTo:messageView offset:0];
                } else { // 没有title 没有message
                    [otherBtn addConstraint:NSLayoutAttributeLeft equalTo:upperPart offset:0];
                    [otherBtn addConstraint:NSLayoutAttributeRight equalTo:upperPart offset:0];
                }
            }
            
            
            UIView *line_otherBtn =[[UIView alloc] init];
            if (_separatorColor) {
                line_otherBtn.backgroundColor = _separatorColor;
            } else {
                line_otherBtn.backgroundColor = DefaultSeparatorColor;
            }
            
            if (message) {
                [_sheet addSubview:line_otherBtn];
                [line_otherBtn addConstraint:NSLayoutAttributeLeft equalTo:messageView offset:0];
                [line_otherBtn addConstraint:NSLayoutAttributeRight equalTo:messageView offset:0];
                [line_otherBtn addConstraint:NSLayoutAttributeHeight equalTo:nil offset:1];
            }
            
           
            
            if (idx == 0) {
                if (message) {
                    [otherBtn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:margin_btnTobtn];
                    [line_otherBtn addConstraint:NSLayoutAttributeTop equalTo:messageView toAttribute:NSLayoutAttributeBottom offset:0];
                } else {
                    if (title) {
                        [otherBtn addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom offset:margin_btnTobtn];
                        [line_otherBtn addConstraint:NSLayoutAttributeTop equalTo:titleView toAttribute:NSLayoutAttributeBottom offset:0];
                    } else {
                        [otherBtn addConstraint:NSLayoutAttributeBottom equalTo:upperPart toAttribute:NSLayoutAttributeBottom offset:0];
                    }
                }
                
            } else {
                if (!title && !message) {
                    [otherBtn addConstraint:NSLayoutAttributeBottom equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeTop offset:-margin_btnTobtn];
                    // separator
                    [line_otherBtn addConstraint:NSLayoutAttributeBottom equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeTop offset:0];
                } else {
                    [otherBtn addConstraint:NSLayoutAttributeTop equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeBottom offset:margin_btnTobtn];
                    // separator
                    [line_otherBtn addConstraint:NSLayoutAttributeTop equalTo:otherBtns[idx - 1] toAttribute:NSLayoutAttributeBottom offset:0];
                }
                
                
            }
            
            [otherBtn layoutIfNeeded];
            
            if (!title && !message) {
                if (idx == 0) {
                    
                    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:otherBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(DefaultCornerRadius, DefaultCornerRadius)];
                    
                    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                    
                    maskLayer.frame = otherBtn.bounds;
                    
                    maskLayer.path = maskPath.CGPath;
                    
                    otherBtn.layer.mask = maskLayer;
                    
                }
                if (idx == otherButtonTitles.count - 1) {
                    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:otherBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(DefaultCornerRadius, DefaultCornerRadius)];
                    
                    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                    
                    maskLayer.frame = otherBtn.bounds;
                    
                    maskLayer.path = maskPath.CGPath;
                    
                    otherBtn.layer.mask = maskLayer;
                }
            } else {
                if (idx == otherButtonTitles.count - 1) {
                    
                    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:otherBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(DefaultCornerRadius, DefaultCornerRadius)];
                    
                    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                    
                    maskLayer.frame = otherBtn.bounds;
                    
                    maskLayer.path = maskPath.CGPath;
                    
                    otherBtn.layer.mask = maskLayer;
                    
                }

            }
            
            if (cancelButtonTitle) {
                otherBtn.tag = idx + 1;
            } else {
                otherBtn.tag = idx;
            }
            
            CGFloat hei = buttonHeight + margin_btnTobtn;
            otherButtonsHeight += hei;
            
        }];
    }
    
    [upperPart layoutIfNeeded];
    
    [_sheet layoutIfNeeded];
    
    [self setupColorsForTitleView:titleView titleLabel:titleLabel messageView:messageView messageLabel:messageLabel];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect sheetFrame = _sheet.frame;
        
        if (cancelButtonTitle) {
            if (message) {
                sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + margin_edge + underPart.frame.size.height + otherButtonsHeight;
            } else {
                
                sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + underPart.frame.size.height  + otherButtonsHeight - margin_edge;
            }
            
        } else {
            sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + margin_partTobottom + otherButtonsHeight;
            if (message) {
                sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + margin_partTobottom + otherButtonsHeight;
            } else {
                sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + 0 + otherButtonsHeight;
                if (title) {
                    sheetFrame.size.height = titleView.frame.size.height + messageView.frame.size.height + otherButtonsHeight - margin_edge - margin_partTobottom;
                } 
            }
        }
        
        sheetFrame.origin.y = screenH - sheetFrame.size.height;
        
        self.sheet.frame = sheetFrame;
        
        self.shadowView.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.4];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenSheetView {
    
    CGRect frame = self.sheet.frame;
    
    frame.origin.y = shadowH;
//    frame.size.height = 0;
    
    [UIView animateWithDuration:animationTime delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:0 animations:^{
        self.sheet.frame = frame;
        _shadowView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)buttonClick:(UIButton *)sender {
    [self hidenSheetView];
    if ([self.delegate respondsToSelector:@selector(actionSheet:didSelectedButtonWithButtonIndex:buttonTitle:)]) {
        [self.delegate actionSheet:self didSelectedButtonWithButtonIndex:sender.tag buttonTitle:sender.titleLabel.text];
    }
    if (_clickHandler) {
        _clickHandler(self,sender.tag,sender.titleLabel.text);
    }
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
