//
//  MainMenuView.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuView : UIView

@property(strong, nonatomic) UIButton *updatePlayerNameButton;
@property(strong, nonatomic) UIImageView *logoImage;

- (void)initViews;

@end
