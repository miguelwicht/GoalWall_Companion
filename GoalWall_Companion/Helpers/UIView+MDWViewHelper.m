//
//  UIView+MDWViewHelper.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 25/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "UIView+MDWViewHelper.h"

@implementation UIView (MDWViewHelper)

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    [self setFrame:frame];
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    [self setFrame:frame];
}

- (CGFloat)originBottom
{
    return self.originY + self.frame.size.height;
}

- (CGFloat)originRight
{
    return self.originY + self.frame.size.height;
}

@end
