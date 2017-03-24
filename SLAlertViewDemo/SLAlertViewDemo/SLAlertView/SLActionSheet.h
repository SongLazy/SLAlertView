//
//  SLActionSheet.h
//  SLAlertView
//
//  Created by Mac－pro on 17/3/21.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLActionSheet;
@protocol SLActionSheetProtocol <NSObject>

@optional
- (void)actionSheet:(SLActionSheet * _Nonnull)actionSheet didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;

@end

@interface SLActionSheet : UIView

@property (nonatomic, weak) _Nullable id<SLActionSheetProtocol> delegate;

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


+ (void)actionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id<SLActionSheetProtocol>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles clickHandler:(nullable void (^)(SLActionSheet * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;

+ (void)actionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id<SLActionSheetProtocol>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles settingHandler:(nullable void (^)( SLActionSheet * _Nonnull actionSheet))settingHandler clickHandler:(nullable void (^)(SLActionSheet * _Nonnull alertView,NSInteger buttonIndex,NSString * _Nullable buttonTitle))clickHandler;

@end
