//
//  UpdatePlayerNameViewController.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLConnectionManager.h"

@interface UpdatePlayerNameViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate, URLConnectionManagerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelOneTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelTwoTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelThreeTitle;

@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFourTitle;

@property (strong, nonatomic) URLConnectionManager *postManager;
@property (strong, nonatomic) URLConnectionManager *getStatisticManager;

@property (strong, nonatomic) NSDictionary *statistic;

- (IBAction)selectImageButtonPressed:(UIButton *)sender;
- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)updatePlayerButtonPressed:(UIButton *)sender;

@end
