//
//  MainMenuView.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"

@interface MainMenuView : UIView

@property(strong, nonatomic) UIImageView *logoImage;
@property(strong, nonatomic) UIImageView *backgroundImageView;
@property(strong, nonatomic) IBOutlet OBShapedButton *settingsButton;
@property(strong, nonatomic) IBOutlet OBShapedButton *rankingsButton;
@property(strong, nonatomic) IBOutlet OBShapedButton *lastMatchButton;

- (void)initViews;

@end
