//
//  RankingsViewController.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingTableViewCell.h"
#import "URLConnectionManager.h"
#import "GameMode.h"

@interface RankingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, URLConnectionManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSDictionary *settings;
@property (strong, nonatomic) URLConnectionManager *classicManager;
@property (strong, nonatomic) NSDictionary *rankings;
@property (nonatomic) GameMode gameMode;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)classicButtonPressed:(id)sender;
- (IBAction)sniperButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
@end
