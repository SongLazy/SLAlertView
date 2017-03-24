//
//  UIView+SLAutolayout.m
//  SLAlertView
//
//  Created by Mac－pro on 17/3/20.
//  Copyright © 2017年 SongLazy All rights reserved.
//

#import "UIView+SLAutolayout.h"

@implementation UIView (SLAutolayout)

-(void)addConstraint:(NSLayoutAttribute)attribute value:(CGFloat)value
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:value]];
}

-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to toAttribute:(NSLayoutAttribute)toAttribute offset:(CGFloat)offset
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to attribute:toAttribute multiplier:1.0 constant:offset]];
}

-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to offset:(CGFloat)offset
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to attribute:attribute multiplier:1.0 constant:offset]];
}

-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to multiplier:(CGFloat)multiplier
{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to attribute:attribute multiplier:multiplier constant:0]];
}

-(void)addConstraint:(NSLayoutAttribute)attribute equalTo:(UIView *)to fromConstraint:(NSLayoutAttribute)fromAttribute offset:(CGFloat)offset
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:to attribute:fromAttribute multiplier:1.0 constant:offset]];
}

- (void)removeAutoLayout:(NSLayoutConstraint *)constraint
{
    for (NSLayoutConstraint *con in self.superview.constraints) {
        if ([con isEqual:constraint]) {
            [self.superview removeConstraint:con];
        }
    }
}

- (void)removeAllAutoLayout
{
    for (NSLayoutConstraint *con in self.constraints)
    {
        [self removeConstraint:con];
    }
}



@end
