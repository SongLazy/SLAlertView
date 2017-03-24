//
//  UIView+SLAutolayout.h
//  SLAlertView
//
//  Created by Mac－pro on 17/3/20.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SLAutolayout)

-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to toAttribute:(NSLayoutAttribute)toAttribute offset:(CGFloat)offset;

-(void)addConstraint:(NSLayoutAttribute)attribute value:(CGFloat)value;
-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to offset:(CGFloat)offset;
-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to multiplier:(CGFloat)multiplier;
-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to fromConstraint:(NSLayoutAttribute)fromAttribute offset:(CGFloat)offset;
- (void)removeAutoLayout:(NSLayoutConstraint *)constraint;
- (void)removeAllAutoLayout;

@end
