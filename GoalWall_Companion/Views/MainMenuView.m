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
    self.backgroundColor = [UIColor whiteColor];
    self.updatePlayerNameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.updatePlayerNameButton setTitle:@"Update player names" forState:UIControlStateNormal];
    [self addSubview:self.updatePlayerNameButton];
    
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 158)];
    [self.logoImage setImage:[UIImage imageNamed:@"logo"]];
    [self addSubview:self.logoImage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.updatePlayerNameButton setOriginX:20];
    [self.updatePlayerNameButton setOriginY:100];
    [self.updatePlayerNameButton sizeToFit];
    
    [self.logoImage setOriginX:(self.frame.size.width - self.logoImage.frame.size.width) / 2];
    [self.logoImage setOriginY:(self.frame.size.height - self.logoImage.frame.size.height) / 2];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
