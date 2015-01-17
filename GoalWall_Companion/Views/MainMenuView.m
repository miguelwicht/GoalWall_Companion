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
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self addSubview:self.backgroundImageView];
    
//    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 158)];
//    [self.logoImage setImage:[UIImage imageNamed:@"logo"]];
//    [self addSubview:self.logoImage];
    
    self.settingsButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"menu_menu_item_settings_normal"] forState:UIControlStateNormal];
    [self addSubview:self.settingsButton];
    
    self.lastMatchButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.lastMatchButton setBackgroundImage:[UIImage imageNamed:@"menu_menu_item_last_match_normal"] forState:UIControlStateNormal];
    [self addSubview:self.lastMatchButton];
    
    self.rankingsButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.rankingsButton setBackgroundImage:[UIImage imageNamed:@"menu_menu_item_rankings_normal"] forState:UIControlStateNormal];
    [self addSubview:self.rankingsButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self.logoImage setOriginX:(self.frame.size.width - self.logoImage.frame.size.width) / 2];
//    [self.logoImage setOriginY:(self.frame.size.height - self.logoImage.frame.size.height) / 2];
    
    [self.settingsButton setOriginX:229];
    [self.settingsButton setOriginY:200];
    [self.settingsButton sizeToFit];
    
    [self.lastMatchButton setOriginX:456];
    [self.lastMatchButton setOriginY:113];
    [self.lastMatchButton sizeToFit];
    
    [self.rankingsButton setOriginX:420];
    [self.rankingsButton setOriginY:352];
    [self.rankingsButton sizeToFit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
