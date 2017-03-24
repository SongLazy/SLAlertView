//
//  SLAlert.h
//  SLAlertView
//
//  Created by Mac－pro on 17/3/21.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLAlert;
@protocol SLAlertProtocol <NSObject>

@optional
- (void)alertView:(SLAlert * _Nonnull)alertView didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;

@end


@interface SLAlert : UIView

@property (nonatomic, weak) _Nullable id<SLAlertProtocol> delegate;

@property (nonatomic, strong)  UIColor * _Nullable tintColor;
@property (nonatomic, strong)  UIColor * _Nullable titleColor;
@property (nonatomic, strong)  UIColor * _Nullable messageColor;
@property (nonatomic, strong)  UIColor * _Nullable titleBackgroundColor;
@property (nonatomic, strong)  UIColor * _Nullable messageBackgroundColor;
@property (nonatomic, strong)  UIColor * _Nullable cancelTitleColor;
@property (nonatomic, strong)  UIColor * _Nullable cancelBackgroundColor;
@property (nonatomic, strong)  UIColor * _Nullable otherTitleColor;
@property (nonatomic, strong)  UIColor * _Nullable otherBackgroundColor;
@property (nonatomic, strong)  UIColor * _Nullable separatorColor;
@property (nonatomic, strong)  UIFont * _Nullable titleFont;
@property (nonatomic, strong)  UIFont * _Nullable messageFont;
@property (nonatomic, strong)  UIFont * _Nullable cancelTitleFont;
@property (nonatomic, strong)  UIFont * _Nullable otherTitleFont;

// clickHandler:(nullable void (^)(SLAlertView * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id <SLAlertProtocol>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles;

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles clickHandler:(nullable void (^)(SLAlert * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;

+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id <SLAlertProtocol> )delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles settingHandler:(nullable void (^)( SLAlert * _Nonnull alert))settingHandler clickHandler:(nullable void (^)(SLAlert * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;



@end
