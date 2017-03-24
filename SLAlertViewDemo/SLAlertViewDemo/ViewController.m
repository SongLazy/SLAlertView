//
//  ViewController.m
//  SLAlertViewDemo
//
//  Created by Mac－pro on 17/3/21.
//  Copyright © 2017年 Pandai. All rights reserved.
//

#import "ViewController.h"
#import "SLAlertView.h"

@interface ViewController () <SLAlertViewProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - delegate method
- (void)actionSheet:(SLActionSheet *)actionSheet didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString *)buttonTitle {
    NSLog(@"actionSheet:didSelectedButtonWithButtonIndex:%ld buttonTitle:%@",index,buttonTitle);
}
- (void)alertView:(SLAlert *)alertView didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString *)buttonTitle {
    NSLog(@"alertView:didSelectedButtonWithButtonIndex:%ld buttonTitle:%@",index,buttonTitle);
}

#pragma mark - actionSheet
- (IBAction)sheet_default:(id)sender {
    // 通过block回调方式创建
    [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_default" preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2",@"other3"] clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
         NSLog(@"block sheet_default %ld-%@",buttonIndex,buttonTitle);
    }];
}

- (IBAction)sheet_longTitleAndLongMessage:(id)sender {
    [SLAlertView alertViewWithTitle:@"sheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheet" message:@"sheet_longTitleAndLongMessage sheet_longTitleAndLongMessage sheet_longTitleAndLongMessage sheet_longTitleAndLongMessage sheet_longTitleAndLongMessage sheet_longTitleAndLongMessage sheet_longTitleAndLongMessagesheet_longTitleAndLongMessagesheet_longTitleAndLongMessagesheet_longTitleAndLongMessagesheet_longTitleAndLongMessagesheet_longTitleAndLongMessagesheet_longTitleAndLongMessage" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2"]];
}

- (IBAction)sheet_noTitle:(id)sender {
    [SLAlertView alertViewWithTitle:nil message:@"this is message" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"]];
}

- (IBAction)sheet_noMessage:(id)sender {
    [SLAlertView alertViewWithTitle:@"this is title" message:nil delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"]];
}

- (IBAction)sheet_noOtherBtns:(id)sender {
    [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_noOtherBtns" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:nil];
}

- (IBAction)sheet_noCancelBtn:(id)sender {
    [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_noCancelBtn" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:nil otherButtonTitles:@[@"other"]];
}

- (IBAction)sheet_onlyTitle:(id)sender {
    [SLAlertView alertViewWithTitle:@"sheet_onlyTitle" message:nil delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:nil otherButtonTitles:nil];
}

- (IBAction)sheet_onlyMessage:(id)sender {
    [SLAlertView alertViewWithTitle:nil message:@"sheet_onlyMessage" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:nil otherButtonTitles:nil];
}

- (IBAction)sheet_onlyOtherBtns:(id)sender {
    [SLAlertView alertViewWithTitle:nil message:nil delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:nil otherButtonTitles:@[@"other1",@"other2",@"other3"]];
}

- (IBAction)sheet_onlyCancelBtn:(id)sender {
    [SLAlertView alertViewWithTitle:nil message:nil delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:nil];
}

- (IBAction)sheet_noTitleAndNoMsg:(id)sender {
     [SLAlertView alertViewWithTitle:nil message:nil delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2"]];
}
- (IBAction)sheet_noButton:(id)sender {
    [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_noButton sheet_noButtonsheet_noButtonsheet_noButtonsheet_noButtonsheet_noButtonsheet_noButtonsheet_noButtonsheet_noButtonsheet_noButton" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:nil otherButtonTitles:nil];
}
- (IBAction)sheet_customBackgroundColor:(id)sender {
    // 通过block回调方式创建
    [SLAlertView alertViewWithTitle:@"sheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheetsheet" message:@"sheet_customBackgroundColor sheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColorsheet_customBackgroundColor"preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2"] settingHandler:^(SLAlertView * _Nonnull alertView) {
        
        alertView.titleBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.messageBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.otherBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.cancelBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        
    } clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
        
        NSLog(@"block sheet_customBackgroundColor %ld-%@",buttonIndex,buttonTitle);
        
    }];
}
- (IBAction)sheet_customTextColor:(id)sender {
     [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_customTextColor sheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColorsheet_customTextColor" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2",@"other3"] settingHandler:^(SLAlertView * _Nonnull alertView) {
         
         alertView.titleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
         alertView.messageColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
         alertView.otherTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
         alertView.cancelTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
         
     }];
}
- (IBAction)sheet_customTextFont:(id)sender {
    [SLAlertView alertViewWithTitle:@"actionSheet" message:@"sheet_customTextFont sheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFontsheet_customTextFont" delegate:self preferredStyle:SLAlertViewStyleActionSheet cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2",@"other3"] settingHandler:^(SLAlertView * _Nonnull alertView) {
        
        alertView.separatorColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.titleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
        alertView.messageFont = [UIFont fontWithName:@"AmericanTypewriter" size:16];
        alertView.otherTitleFont = [UIFont fontWithName:@"DBLCDTempBlack" size:16];
        alertView.cancelTitleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
        
    }];
}

#pragma mark - alert
- (IBAction)alert_default:(id)sender {
    // 通过block回调方式创建
    [SLAlertView alertViewWithTitle:@"title" message:@"message" preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"] clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
        
        NSLog(@"block %ld-%@",buttonIndex,buttonTitle);
        
    }];
    
}
- (IBAction)alert_onlyCancel:(id)sender {
    // 使用代理
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:nil];
}
- (IBAction)alert_onlyOneOther:(id)sender {
    
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:nil otherButtonTitles:@[@"other"]];
}
- (IBAction)alert_moreOthers:(id)sender {
     [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:nil otherButtonTitles:@[@"other1",@"other2",@"other3"]];
}
- (IBAction)alert_cancelAndMoreOtherbtns:(id)sender {
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other1",@"other2",@"other3"]];
}
- (IBAction)alert_customBackgrondColor:(id)sender {
    // block
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"] settingHandler:^(SLAlertView * _Nonnull alertView) {
        alertView.titleBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.messageBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.otherBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.cancelBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
    } clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
        NSLog(@"block %ld-%@",buttonIndex,buttonTitle);
    }];
}
- (IBAction)alert_customTextColor:(id)sender {
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"] settingHandler:^(SLAlertView * _Nonnull alertView) {
        alertView.titleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.messageColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.otherTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.cancelTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
    }];
}
- (IBAction)alert_customTextFont:(id)sender {
    [SLAlertView alertViewWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage" delegate:self preferredStyle:SLAlertViewStyleAlert cancelButtonTitle:@"cancel" otherButtonTitles:@[@"other"] settingHandler:^(SLAlertView * _Nonnull alertView) {
        alertView.separatorColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        alertView.titleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
        alertView.messageFont = [UIFont fontWithName:@"AmericanTypewriter" size:16];
        alertView.otherTitleFont = [UIFont fontWithName:@"DBLCDTempBlack" size:16];
        alertView.cancelTitleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
    }];
}


@end
