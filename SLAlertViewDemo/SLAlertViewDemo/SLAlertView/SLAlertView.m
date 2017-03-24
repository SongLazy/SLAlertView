//
//  SLAlertView.m
//  SLAlertView
//
//  Created by Mac－pro on 17/3/20.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import "SLAlertView.h"
#import "SLAlert.h"
#import "SLActionSheet.h"

@interface SLAlertView()

@end

@implementation SLAlertView


+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SLAlertViewProtocol>)delegate preferredStyle:(SLAlertViewStyle)preferredStyle cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    
    if (preferredStyle == SLAlertViewStyleAlert) {
        
        id temDelegate = (id<SLAlertProtocol>)delegate;
        [SLAlert alertWithTitle:title message:message delegate:temDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
        
    } else {
        
        id temDelegate = (id<SLActionSheetProtocol>)delegate;
        [SLActionSheet actionSheetWithTitle:title message:message delegate:temDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles clickHandler:nil];
        
    }
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(SLAlertViewStyle)preferredStyle cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickHandler:(void (^)(SLAlertView * _Nonnull, NSInteger, NSString * _Nullable))clickHandler{

    if (preferredStyle == SLAlertViewStyleAlert) {
        
        void(^clickHandlerTemp)(SLAlert * _Nonnull, NSInteger , NSString * _Nullable) = (void(^)(SLAlert * _Nonnull , NSInteger , NSString * _Nullable))clickHandler;
        
        [SLAlert alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles clickHandler:clickHandlerTemp];
        
    } else {
        
        void(^clickHandlerTemp)(SLActionSheet * _Nonnull, NSInteger , NSString * _Nullable) = (void(^)(SLActionSheet * _Nonnull , NSInteger , NSString * _Nullable))clickHandler;
        
        [SLActionSheet actionSheetWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles clickHandler:clickHandlerTemp];
        
    }
    
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id<SLAlertViewProtocol>)delegate preferredStyle:(SLAlertViewStyle)preferredStyle cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles settingHandler:(void (^)(SLAlertView * _Nonnull))settingHandler {
    if (preferredStyle == SLAlertViewStyleAlert) {
        
        id temDelegate = (id<SLAlertProtocol>)delegate;
        
        void(^tempSettingHandler)(SLAlert * _Nonnull) = (void (^)(SLAlert * _Nonnull))settingHandler;
        
        [SLAlert alertWithTitle:title message:message delegate:temDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:tempSettingHandler clickHandler:nil];
        
    } else {
        
        id temDelegate = (id<SLActionSheetProtocol>)delegate;
        
        void(^tempSettingHandler)(SLActionSheet * _Nonnull) = (void (^)(SLActionSheet * _Nonnull))settingHandler;
        
        [SLActionSheet actionSheetWithTitle:title message:message delegate:temDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:tempSettingHandler clickHandler:nil];
        
    }
}

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(SLAlertViewStyle)preferredStyle cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles settingHandler:(void (^)(SLAlertView * _Nonnull))settingHandler clickHandler:(void (^)(SLAlertView * _Nonnull, NSInteger, NSString * _Nullable))clickHandler {
    
    if (preferredStyle == SLAlertViewStyleAlert) {
        
        void(^tempSettingHandler)(SLAlert * _Nonnull) = (void (^)(SLAlert * _Nonnull))settingHandler;
        
        void(^clickHandlerTemp)(SLAlert * _Nonnull, NSInteger , NSString * _Nullable) = (void(^)(SLAlert * _Nonnull , NSInteger , NSString * _Nullable))clickHandler;
        
        [SLAlert alertWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:tempSettingHandler clickHandler:clickHandlerTemp];
        
    } else {
        
        void(^tempSettingHandler)(SLActionSheet * _Nonnull) = (void (^)(SLActionSheet * _Nonnull))settingHandler;
        
         void(^clickHandlerTemp)(SLActionSheet * _Nonnull, NSInteger , NSString * _Nullable) = (void(^)(SLActionSheet * _Nonnull , NSInteger , NSString * _Nullable))clickHandler;
        
        [SLActionSheet actionSheetWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles settingHandler:tempSettingHandler clickHandler:clickHandlerTemp];
        
    }
}


@end
