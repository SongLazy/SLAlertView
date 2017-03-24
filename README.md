# SLAlertView
简约系统风格自由定制的弹窗Alert&amp;ActionSheet

# 效果图

![Simulator Screen Shot 2017年3月24日 下午3.06.40.png](http://upload-images.jianshu.io/upload_images/1733477-cb4f4562ceee7c38.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.06.47.png](http://upload-images.jianshu.io/upload_images/1733477-cd7749f764256ff9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.07.22.png](http://upload-images.jianshu.io/upload_images/1733477-e84b97058b8d4790.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.07.47.png](http://upload-images.jianshu.io/upload_images/1733477-86b556112db5c016.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.08.30.png](http://upload-images.jianshu.io/upload_images/1733477-9f438b9cef0af0ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.08.45.png](http://upload-images.jianshu.io/upload_images/1733477-0db417b7f9770bb8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.08.51.png](http://upload-images.jianshu.io/upload_images/1733477-75a26dccb5a40450.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.08.53.png](http://upload-images.jianshu.io/upload_images/1733477-b01283e40e32bb28.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)
![Simulator Screen Shot 2017年3月24日 下午3.09.27.png](http://upload-images.jianshu.io/upload_images/1733477-e1a1c9f7e9fa8c56.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)




# 项目介绍
* 这是一款简约系统风格的弹窗，开发者可通过一句代码创建并弹出。
* 开发者可以选择通过代理的方式或者block的方式来监听按钮的点击事件。
* 开发者可通过settingHandler设置弹窗的背景颜色、字体颜色、字体以及分割线的颜色以满足不同风格的app的需求
* 更加详尽的使用情况请下载demo

# 使用说明
### 安装
将demo中的SLAlertView文件夹拖入项目

![SLAlertView文件夹.png](http://upload-images.jianshu.io/upload_images/1733477-f5457010e934b4d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
### 接口说明
```
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


// 代理方法
- (void)alertView:(SLAlert * _Nonnull)alertView didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;
- (void)actionSheet:(SLActionSheet * _Nonnull)actionSheet didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString * _Nullable)buttonTitle;

```
### 调用
* 导入头文件
```
#import "SLAlertView.h"
```
* 在需要弹窗的地方调用接口
1> 创建并弹出使用代理监听点击事件的默认的alert / actionSheet
```
// alert
[SLAlertView alertViewWithTitle:@"title"
                            message:@"messagemessagemessagemessagemessagemessagemessagemessaemessagemessage"
                           delegate:self
                     preferredStyle:SLAlertViewStyleAlert
                  cancelButtonTitle:@"cancel"
                  otherButtonTitles:nil];

 // action sheet
    [SLAlertView alertViewWithTitle:@"title"
                            message:@"this is message"
                           delegate:self
                     preferredStyle:SLAlertViewStyleActionSheet
                  cancelButtonTitle:@"cancel"
                  otherButtonTitles:@[@"other"]];
```
2> 创建并弹出使用block监听点击事件的默认的alert / actionSheet
```
// 通过block回调方式创建alert
    [SLAlertView alertViewWithTitle:@"title"
                            message:@"message"
                     preferredStyle:SLAlertViewStyleAlert
                  cancelButtonTitle:@"cancel"
                  otherButtonTitles:@[@"other"]
                       clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
        
        NSLog(@"block %ld-%@",buttonIndex,buttonTitle);
        
    }];
// 通过block回调方式创建action sheet
    [SLAlertView alertViewWithTitle:@"actionSheet"
                            message:@"sheet_default"
                     preferredStyle:SLAlertViewStyleActionSheet
                  cancelButtonTitle:@"cancel"
                  otherButtonTitles:@[@"other1",@"other2",@"other3"]
                       clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
         NSLog(@"block sheet_default %ld-%@",buttonIndex,buttonTitle);
    }];
```
3> 自定义的情况（以actionSheet为例，alert用法完全一样）
```
 [SLAlertView alertViewWithTitle:@"title"
                            message:@"message"
                     preferredStyle:SLAlertViewStyleActionSheet
                  cancelButtonTitle:@"cancel"
                  otherButtonTitles:@[@"other1",@"other2"]
                     settingHandler:^(SLAlertView * _Nonnull alertView) {
        
                         alertView.titleBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.messageBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.otherBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.cancelBackgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.titleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.messageColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.otherTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.cancelTitleColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.separatorColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
                         alertView.titleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
                         alertView.messageFont = [UIFont fontWithName:@"AmericanTypewriter" size:16];
                         alertView.otherTitleFont = [UIFont fontWithName:@"DBLCDTempBlack" size:16];
                         alertView.cancelTitleFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
    }
                       clickHandler:^(SLAlertView * _Nonnull alertView, NSInteger buttonIndex, NSString * _Nullable buttonTitle) {
        
        NSLog(@"block sheet_customBackgroundColor %ld-%@",buttonIndex,buttonTitle);
        
    }];
```
4> 代理方法。遵守协议 <SLAlertViewProtocol>
```
 - (void)actionSheet:(SLActionSheet *)actionSheet didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString *)buttonTitle {
    NSLog(@"actionSheet:didSelectedButtonWithButtonIndex:%ld buttonTitle:%@",index,buttonTitle);
}
 - (void)alertView:(SLAlert *)alertView didSelectedButtonWithButtonIndex:(NSInteger)index buttonTitle:(NSString *)buttonTitle {
    NSLog(@"alertView:didSelectedButtonWithButtonIndex:%ld buttonTitle:%@",index,buttonTitle);
}
```
