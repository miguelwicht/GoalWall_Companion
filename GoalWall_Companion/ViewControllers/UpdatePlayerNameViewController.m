//
//  UpdatePlayerNameViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "UpdatePlayerNameViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface UpdatePlayerNameViewController ()

@end

@implementation UpdatePlayerNameViewController

- (void)loadView
{
    [super loadView];
    
    [self getStatistic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions

- (IBAction)selectImageButtonPressed:(UIButton *)sender
{
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    if ([availableMediaTypes containsObject:(NSString *)kUTTypeImage])
    {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        self.imagePickerController.allowsEditing = YES;
        self.imagePickerController.delegate = self;
        
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    NSLog(@"POP");
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Networking

- (void)getStatistic
{
    self.getStatisticManager = [[URLConnectionManager alloc] init];
    self.getStatisticManager.url = [NSURL URLWithString:@"http://goalwall.de/statistics/latest/1?user=mail@miguelwicht.com&password=password"];
    self.getStatisticManager.delegate = self;
    [self.getStatisticManager get];
}

- (void)updateStatistic
{
    self.postManager = [[URLConnectionManager alloc] init];
    self.postManager.delegate = self;
    self.postManager.url = [NSURL URLWithString:@"http://goalwall.de/statistics/update/player"];
    self.postManager.method = @"POST";
    NSString *user = @"mail@miguelwicht.com";
    NSString *password = @"password";
    NSString *name = self.editNameTextField.text;
    NSString *statisticId = [NSString stringWithFormat:@"%@", self.statistic[@"id"]];
    //NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"logo"]);
    
    // set post data
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:user forKey:@"user"];
    [postDict setObject:password forKey:@"password"];
    [postDict setObject:statisticId forKey:@"id"];
    [postDict setObject:name forKey:@"player_name"];
    
    NSMutableData *body = [[NSMutableData alloc] init];
    [self.postManager appendDictionary:postDict toBody:body];
//    [self.postManager appendImage:[self.selectImageButton.imageView.image withName:@"image" filename:@"imageFilename" toBody:body];
    [self.postManager appendImage:self.selectImageButton.imageView.image withName:@"image" filename:@"imageFilename" toBody:body];
    [self.postManager postFormWithBody:body];
}

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didPickImage");
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:finishedSavingWithError:contextInfo:),nil);
    [self.selectImageButton setImage:image forState:UIControlStateNormal];
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image/video"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - URLConnectionManagerDelegate Methods

- (void)manager:(URLConnectionManager *)manager didFinishLoading:(NSData *)data
{
    if (manager == self.getStatisticManager) {
        NSError *error;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        NSLog(@"response: %@", responseDict);
        self.statistic = [[NSDictionary alloc] initWithDictionary:responseDict];
        [self initLabelsWithStatistic:responseDict];
    }
    else if (manager == self.postManager)
    {
        NSLog(@"postManager didFinish");
        [self getStatistic];
    }
    
    
    //NSLog(@"response: %@", responseDict);
}


- (void)initLabelsWithStatistic:(NSDictionary *)statistic
{
    self.gameModeLabel.text = [NSString stringWithFormat:@"%@", [[statistic objectForKey:@"mode"] objectForKey:@"title"]];
    
    self.labelOne.text = [NSString stringWithFormat:@"%@", [statistic objectForKey:@"score"]];
    self.labelTwo.text = [NSString stringWithFormat:@"%@", statistic[@"shots"]];
    self.labelThree.text = [NSString stringWithFormat:@"%i", [statistic[@"shots"] integerValue] - [statistic[@"misses"] integerValue]];
    self.labelFour.text = [NSString stringWithFormat:@"%.0F %%", ([statistic[@"shots"] floatValue] - [statistic[@"misses"] floatValue]) / [statistic[@"shots"] floatValue] * 100];
    
    self.selectImageButton.imageView.image = [UIImage imageNamed:@"camera"];
    
    NSLog(@"%@", self.labelFour.text);
    
    //round(($statistic->shots - $statistic->misses) / $statistic->shots, 2) * 100 . ' %'
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

- (IBAction)updatePlayerButtonPressed:(UIButton *)sender
{
    [self updateStatistic];
}
@end
