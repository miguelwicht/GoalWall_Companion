//
//  UIView+MDWViewHelper.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 25/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MDWViewHelper)

- (CGFloat)originX;
- (CGFloat)originY;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (CGFloat)originBottom;
- (CGFloat)originRight;

@end
