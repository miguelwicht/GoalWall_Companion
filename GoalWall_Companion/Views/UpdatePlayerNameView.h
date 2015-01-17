//
//  UpdatePlayerNameView.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"

@interface UpdatePlayerNameView : UIView

@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *modeTitleLabel;
@property (strong, nonatomic) IBOutlet OBShapedButton *userImageButton;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) UILabel *points;
@property (strong, nonatomic) UILabel *pointsLabel;

//@property (strong, nonatomic) UILabel *points;
//@property (strong, nonatomic) UILabel *pointsLabel;

@property (strong, nonatomic) UIImageView *statisticRow;

- (void)initViews;

@end
