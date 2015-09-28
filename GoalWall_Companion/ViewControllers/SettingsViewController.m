//
//  SettingsViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 17/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

- (void)loadView
{
    [super loadView];
    
    [self initTextFields];
    [self.scrollView setDelaysContentTouches:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self deregisterKeyboardNotifications];
}

- (void)initTextFields
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *settings = [defaults objectForKey:@"settings"];
    
    self.hostTextField.text = [settings objectForKey:@"host"];
    self.usernameTextField.text = [settings objectForKey:@"username"];
    self.passwordTextField.text = [settings objectForKey:@"password"];
    self.eventIDTextField.text = [settings objectForKey:@"eventID"];
    
    self.hostTextField.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.eventIDTextField.delegate = self;
}

#pragma mark - UITextField delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.selectedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.selectedTextField = nil;
}

#pragma mark - Keyboard notifications

- (void)registerKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppearHandler:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappearHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillAppearHandler:(NSNotification *)notification
{
//    NSLog([NSString stringWithFormat:@"ContentOffset.y: %f", self.scrollView.contentOffset.y]);
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, self.selectedTextField.frame.origin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, self.selectedTextField.frame.origin.y - visibleRect.size.height + self.selectedTextField.frame.size.height + 20);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillDisappearHandler:(NSNotification *)notification
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - IBActions

- (IBAction)saveButtonPressed:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithDictionary:[defaults objectForKey:@"settings"]];
    
    [settings setObject:self.hostTextField.text forKey:@"host"];
    [settings setObject:self.usernameTextField.text forKey:@"username"];
    [settings setObject:self.passwordTextField.text forKey:@"password"];
    [settings setObject:self.eventIDTextField.text forKey:@"eventID"];
    [defaults setObject:settings forKey:@"settings"];
    [defaults synchronize];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
