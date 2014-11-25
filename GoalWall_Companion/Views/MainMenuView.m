//
//  MainMenuView.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "MainMenuView.h"
#import "UIView+MDWViewHelper.h"

@implementation MainMenuView

- (void)initViews
{
    self.updatePlayerNameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.updatePlayerNameButton setTitle:@"Update player names" forState:UIControlStateNormal];
    [self addSubview:self.updatePlayerNameButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.updatePlayerNameButton setOriginX:20];
    [self.updatePlayerNameButton setOriginY:100];
    [self.updatePlayerNameButton sizeToFit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
