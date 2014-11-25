//
//  MainMenuViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "MainMenuViewController.h"
#import "UpdatePlayerNameViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)loadView
{
    [super loadView];
    [self setupNavigationBar];
    [self initView];
    NSLog(@"loadView");
    
}

- (void)setupNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)initView
{
    self.mainMenuView = [[MainMenuView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mainMenuView];
    
    [self.mainMenuView initViews];
    [self.mainMenuView.updatePlayerNameButton addTarget:self action:@selector(updatePlayerNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)updatePlayerNameButtonPressed:(id)sender
{
    UpdatePlayerNameViewController *viewController = [[UpdatePlayerNameViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
