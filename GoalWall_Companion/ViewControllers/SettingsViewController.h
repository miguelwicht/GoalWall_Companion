//
//  SettingsViewController.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 17/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *hostTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) UITextField *selectedTextField;

- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)backButtonPressed:(id)sender;
@end
