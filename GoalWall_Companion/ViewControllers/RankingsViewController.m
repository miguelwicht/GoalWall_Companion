//
//  RankingsViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "RankingsViewController.h"

@interface RankingsViewController ()

@end

@implementation RankingsViewController

- (void)loadView
{
    [super loadView];
    //[self saveImage:[UIImage imageNamed:@"camera"] withName:@"uploads/players/player.jpg"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.settings = [[NSDictionary alloc] initWithDictionary:[defaults objectForKey:@"settings"]];
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    [self switchToGameMode:GameModeClassic];
    
    [self getData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)getData
{
    self.classicManager = [[URLConnectionManager alloc] init];
    self.classicManager.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/statistics/rankings/%@/%i?user=%@&password=%@", self.settings[@"host"], self.settings[@"eventID"], self.gameMode, self.settings[@"username"], self.settings[@"password"]]];
    self.classicManager.delegate = self;
    [self.classicManager get];
}

#pragma mark - URLConnectionManagerDelegate Methods

- (void)manager:(URLConnectionManager *)manager didFinishLoading:(NSData *)data
{
    if (manager == self.classicManager)
    {
        NSError *error;
        NSArray *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"response: %@", response);
        [self createDataSourceFromRankings:response];
        
        [self hideLoadingScreen];
    }
}

- (void)createDataSourceFromRankings:(NSArray *)rankings
{
    //NSLog(@"Rankings: %@", rankings);
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in rankings)
    {
//        NSLog(@"%@", dict);
        NSNumber *points = [NSNumber numberWithInt:[dict[@"score"] intValue]];
        NSNumber *shots = [NSNumber numberWithInt:[dict[@"shots"] intValue]];
        NSNumber *goals = [NSNumber numberWithInt:([dict[@"shots"] intValue] - [dict[@"misses"] intValue])];
        NSNumber *misses = [NSNumber numberWithInt:[dict[@"misses"] intValue]];
        NSString *accuracy = [NSString stringWithFormat:@"%.0F%%", ([shots floatValue] - [misses floatValue]) / [shots floatValue] * 100];
        
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imagesDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"uploads/players/%@", [dict[@"player_image_path"] lastPathComponent]]];
        NSLog(@"imagesDirectory: %@", imagesDirectory);
        UIImage *image;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagesDirectory])
        {
            image = [UIImage imageWithContentsOfFile:imagesDirectory];
        }
        
        [dataSource addObject:[[NSMutableDictionary alloc] initWithDictionary:@{@"name": dict[@"player_name"],
                               @"values": @[
                                       @{@"label": points,
                                         @"description": @"Points"},
                                       @{@"label": shots,
                                         @"description": @"Shots"},
                                       @{@"label": goals,
                                         @"description": @"Goals"},
                                       @{@"label": accuracy,
                                         @"description": @"Accuracy"},
                                       ],
                                @"image_path": dict[@"player_image_path"],
                                @"image": image != nil ? image : [NSNull null]
                                }]];
    }
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:dataSource];
    
    NSLog(@"DataSource: %@", self.dataSource);
    
    [self downloadImages];
    [self.tableView reloadData];
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name
{
    NSString *ext = [name pathExtension];
    name = [name lastPathComponent];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imagesDirectory = [documentsDirectory stringByAppendingPathComponent:@"uploads/players/"];
    
    // create directory
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagesDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:imagesDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSString *pathToFile = [imagesDirectory stringByAppendingFormat:@"/%@", name];
//    NSLog(@"filename: %@", pathToFile);
//    NSLog(@"name: %@", name);
    NSData *data;
    
    if ([ext isEqualToString:@"jpg"])
    {
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    
    BOOL success = [data writeToFile:pathToFile atomically:YES];
//    NSLog(@"Success = %d, error = %@", success, error);
}

- (void)downloadImages
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < [self.dataSource count]; i++)   //download array have url links
    {
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.settings[@"host"], self.dataSource[i][@"image_path"]]];
        
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:URL];
        
        if (self.dataSource[i][@"image"] == [NSNull null])
        {
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 NSString *responseUrl = response.URL.relativeString;
                 if([data length] > 0 && [[NSString stringWithFormat:@"%@",error] isEqualToString:@"(null)"])
                 {
                     //make your image here from data.
                     UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithData:data]];
                     [self saveImage:image withName:responseUrl];
                     //                 NSLog(@"Image: %@", image);
                     __block NSIndexPath *indexPath;
                     
                     if (image != nil) {
                         for (int j = 0; j < [self.dataSource count]; j++)
                         {
                             //                     NSLog(@"dataSource: %@, response: %@", self.dataSource[j][@"image_path"], responseUrl);
                             
                             
                             if ([responseUrl rangeOfString:self.dataSource[j][@"image_path"]].location != NSNotFound)
                             {
                                 NSLog(@"dataSource: %@, response: %@", self.dataSource[j][@"image_path"], responseUrl);
                                 indexPath = [NSIndexPath indexPathForRow:j inSection:0];
                                 [self.dataSource[j] setObject:image forKey:@"image"];

                                 dispatch_async(dispatch_get_main_queue(), ^{ // 2
                                     RankingTableViewCell *cell = (RankingTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                                     cell.profileImageView.image = image;
                                     
                                 });
                             }
                         }
                     }
                     
                 }
                 else if ([data length] == 0 && [[NSString stringWithFormat:@"%@",error] isEqualToString:@"(null)"])
                 {
                     NSLog(@"No Data!");
                 }
                 else if (![[NSString stringWithFormat:@"%@",error] isEqualToString:@"(null)"]){
                     NSLog(@"Error = %@", error);
                 }
             }];
        }
        
        
    }
}


#pragma mark -

- (void)switchToGameMode:(GameMode)gameMode
{
    switch (gameMode)
    {
        case GameModeClassic:
            self.gameModeLabel.text = @"CLASSIC";
            break;
        case GameModeSniper:
            self.gameModeLabel.text = @"SNIPER";
            break;
        default:
            break;
    }
    
    self.gameMode = gameMode;
    [self showLoadingScreen];
    [self getData];
}

- (void)hideLoadingScreen
{
    [self.activityIndicator stopAnimating];
    [self.overlayView setHidden:YES];
}

- (void)showLoadingScreen
{
    [self.activityIndicator startAnimating];
    [self.overlayView setHidden:NO];
}


- (IBAction)classicButtonPressed:(id)sender
{
    [self switchToGameMode:GameModeClassic];
}

- (IBAction)sniperButtonPressed:(id)sender
{
    [self switchToGameMode:GameModeSniper];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isEven = indexPath.row % 2;
    
    RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingCell"];
    NSDictionary *data = self.dataSource[indexPath.row];
//    NSLog(@"%@", data);
    cell.rankLabel.text = [NSString stringWithFormat:@"%i.", indexPath.row + 1];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", data[@"name"]];
    
    
    cell.valueLabel01.text = [NSString stringWithFormat:@"%@", data[@"values"][0][@"label"]];
    cell.valueDescriptionLabel01.text = [NSString stringWithFormat:@"%@", data[@"values"][0][@"description"]];

    cell.valueLabel02.text = [NSString stringWithFormat:@"%@", data[@"values"][1][@"label"]];
    cell.valueDescriptionLabel02.text = [NSString stringWithFormat:@"%@", data[@"values"][1][@"description"]];
    
    cell.valueLabel03.text = [NSString stringWithFormat:@"%@", data[@"values"][2][@"label"]];
    cell.valueDescriptionLabel03.text = [NSString stringWithFormat:@"%@", data[@"values"][2][@"description"]];
    
    cell.valueLabel04.text = [NSString stringWithFormat:@"%@", data[@"values"][3][@"label"]];
    cell.valueDescriptionLabel04.text = [NSString stringWithFormat:@"%@", data[@"values"][3][@"description"]];
    
    //NSLog(@"data: %@, NSNull: %@", data[@"image"], [NSNull null]);
    
    if (data[@"image"] != [NSNull null])
    {
        cell.profileImageView.image = data[@"image"];
    }
    else
    {
        cell.profileImageView.image = [UIImage imageNamed:@"user_image_normal"];
    }
    
    cell.isEven = isEven;
    [cell updateCellStyle];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

//- (void)viewDidLayoutSubviews
//{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark -

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
