//
//  MainMenuViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SettingsViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions

- (IBAction)settingsButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
             initWithTitle:NSLocalizedString(@"Please enter the password:", @"")
             message:nil
             delegate:self
             cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
             otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex: %li", (long)buttonIndex);
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    NSString *text = alertTextField.text;
    
    switch (buttonIndex)
    {
        case 1:
        {
            if ([text isEqualToString:@"!h_da_hobit_2015!"])
            {
                SettingsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
                
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"Wrong password", @"")
                                      message:nil
                                      delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                      otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
                [alert show];
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
