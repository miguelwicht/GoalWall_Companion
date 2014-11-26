//
//  UpdatePlayerNameViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "UpdatePlayerNameViewController.h"

@interface UpdatePlayerNameViewController ()

@end

@implementation UpdatePlayerNameViewController

-(void)loadView
{
    [super loadView];
    
    [self initView];
}

- (void)setupNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)initView
{
    self.updatePlayerNameView = [[UpdatePlayerNameView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.updatePlayerNameView];
    
    [self.updatePlayerNameView initViews];
    [self.updatePlayerNameView.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
