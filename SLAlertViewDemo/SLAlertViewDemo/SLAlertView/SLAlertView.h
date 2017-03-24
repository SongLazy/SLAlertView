//
//  SLAlertView.h
//  SLAlertView
//
//  Created by Mac－pro on 17/3/20.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SLAlertViewStyle){
    SLAlertViewStyleAlert = 0,
    SLAlertViewStyleActionSheet = 1,
};


@class SLAlertView;
@class SLAlert;
@class SLActionSheet;

@protocol SLAlertViewProtocol <NSObject>

@optional
- (void)alertView:(SLAlert * _Nonnull)alertView didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;
- (void)actionSheet:(SLActionSheet * _Nonnull)actionSheet didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;

@end

@interface SLAlertView : UIView
/** 主题颜色（暂时没用） */
@property (nonatomic, strong)  UIColor * _Nullable tintColor; // 暂时没用
/** title字体颜色 */
@property (nonatomic, strong)  UIColor * _Nullable titleColor;
/** message字体颜色 */
@property (nonatomic, strong)  UIColor * _Nullable messageColor;
/** title背景颜色 */
@property (nonatomic, strong)  UIColor * _Nullable titleBackgroundColor;
/** message背景颜色 */
@property (nonatomic, strong)  UIColor * _Nullable messageBackgroundColor;
/** 取消按钮的字体颜色 */
@property (nonatomic, strong)  UIColor * _Nullable cancelTitleColor;
/** 取消按钮的背景颜色 */
@property (nonatomic, strong)  UIColor * _Nullable cancelBackgroundColor;
/** 其他按钮的字体颜色 */
@property (nonatomic, strong)  UIColor * _Nullable otherTitleColor;
/** 其他按钮的背景颜色 */
@property (nonatomic, strong)  UIColor * _Nullable otherBackgroundColor;
/** 分割线的颜色 默认是透明的 */
@property (nonatomic, strong)  UIColor * _Nullable separatorColor;
/** title字体 */
@property (nonatomic, strong)  UIFont * _Nullable titleFont;
/** message字体 */
@property (nonatomic, strong)  UIFont * _Nullable messageFont;
/** 取消按钮字体 */
@property (nonatomic, strong)  UIFont * _Nullable cancelTitleFont;
/** 其他按钮字体 */
@property (nonatomic, strong)  UIFont * _Nullable otherTitleFont;



/**
 *  创建并弹出使用代理监听点击事件的默认的alertView
 *  param title   标题
 *  param message   提示文字内容
 *  param delegate  代理 可通过设置代理监听按钮的点击
 *  param preferredStyle    弹出样式
 *  param cancelButtonTitle     取消按钮文字
 *  param otherButtonTitles     其他按钮文字（数组）@[@"other1",@"other2"]
 */
+ (void)alertViewWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
                  delegate:(nullable id<SLAlertViewProtocol>)delegate
            preferredStyle:(SLAlertViewStyle)preferredStyle
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitles:(nullable NSArray *)otherButtonTitles;

/**
 *  创建并弹出使用block监听点击事件的默认的alertView
 *  param title   标题
 *  param message   提示文字内容
 *  param preferredStyle    弹出样式
 *  param cancelButtonTitle     取消按钮文字
 *  param otherButtonTitles     其他按钮文字（数组）@[@"other1",@"other2"]
 *  param clickHandler     点击按钮的回调
 */
+ (void)alertViewWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
            preferredStyle:(SLAlertViewStyle)preferredStyle
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitles:(nullable NSArray *)otherButtonTitles
              clickHandler:(nullable void (^)(SLAlertView * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;


/**
 *  创建并弹出使用代理监听点击事件的可自定义的alertView
 *  param title   标题
 *  param message   提示文字内容
 *  param delegate  代理 可通过设置代理监听按钮的点击
 *  param preferredStyle    弹出样式
 *  param cancelButtonTitle     取消按钮文字
 *  param otherButtonTitles     其他按钮文字（数组）@[@"other1",@"other2"]
 *  param settingHandler    自定义设置的回调 可通过此block设置各种背景颜色、字体颜色和字体。
    自定义设置方式：
    alertView.titleColor = [UIColor blackColor];
    alertView.messageColor = [UIColor blackColor];
    ...
 */
+ (void)alertViewWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
                  delegate:(nullable id<SLAlertViewProtocol>)delegate
            preferredStyle:(SLAlertViewStyle)preferredStyle
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitles:(nullable NSArray *)otherButtonTitles
            settingHandler:(nullable void (^)( SLAlertView * _Nonnull alertView))settingHandler;

/**
 *  创建并弹出使用block监听点击事件的可自定义的alertView
 *  param title   标题
 *  param message   提示文字内容
 *  param preferredStyle    弹出样式
 *  param cancelButtonTitle     取消按钮文字
 *  param otherButtonTitles     其他按钮文字（数组）@[@"other1",@"other2"]
 *  param settingHandler    自定义设置的回调 可通过此block设置各种背景颜色、字体颜色和字体。
    自定义设置方式：
    alertView.titleColor = [UIColor blackColor];
    alertView.messageColor = [UIColor blackColor];
    ...
 *  param clickHandler     点击按钮的回调
 */
+ (void)alertViewWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
            preferredStyle:(SLAlertViewStyle)preferredStyle
         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitles:(nullable NSArray *)otherButtonTitles
            settingHandler:(nullable void (^)( SLAlertView * _Nonnull alertView))settingHandler
              clickHandler:(nullable void (^)(SLAlertView * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;

@end
