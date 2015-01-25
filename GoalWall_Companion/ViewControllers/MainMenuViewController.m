//
//  MainMenuViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "MainMenuViewController.h"
#import "UpdatePlayerNameViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SettingsViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

//- (void)loadView
//{
//    [super loadView];
////    [self setupNavigationBar];
////    [self initView];
//    NSLog(@"loadView");
//    
//}

//- (void)setupNavigationBar
//{
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void)initView
//{
//    self.mainMenuView = [[MainMenuView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:self.mainMenuView];
//    
//    [self.mainMenuView initViews];
//    [self.mainMenuView.lastMatchButton addTarget:self action:@selector(updatePlayerNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (IBAction)updatePlayerNameButtonPressed:(id)sender
//{
//    UpdatePlayerNameViewController *viewController = [[UpdatePlayerNameViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)settingsButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
             initWithTitle:NSLocalizedString(@"Please enter the password:", @"")
             message:nil
             delegate:self
             cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
             otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
//    UITextField *textField = [alert textFieldAtIndex:0];
//    textField.placeholder = NSLocalizedString(@"Title", @"placeholder text where user enters name for new playlist");
//    textField.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex: %i", buttonIndex);
    
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
    
    
    
    

    
    // do whatever you want to do with this UITextField.
}

@end
