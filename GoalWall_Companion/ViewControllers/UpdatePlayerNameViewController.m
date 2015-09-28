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
    
    [self.scrollView setDelaysContentTouches:NO];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.settings = [[NSDictionary alloc] initWithDictionary:[defaults objectForKey:@"settings"]];
    
    //self.defaultImage = [UIImage imageNamed:@"user_image_normal"];
    UIImage *image = self.selectImageButton.imageView.image;
    self.defaultImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:image.scale orientation:image.imageOrientation];
    
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
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        self.imagePickerController.allowsEditing = YES;
        self.imagePickerController.delegate = self;
        
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Networking

- (void)getStatistic
{
    self.getStatisticManager = [[URLConnectionManager alloc] init];
    self.getStatisticManager.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/statistics/latest/%@?user=%@&password=%@", self.settings[@"host"], self.settings[@"eventID"], self.settings[@"username"], self.settings[@"password"]]];
    
    self.getStatisticManager.delegate = self;
    [self.getStatisticManager get];
}

- (void)updateStatistic
{
    self.postManager = [[URLConnectionManager alloc] init];
    self.postManager.delegate = self;
    self.postManager.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/statistics/update/player", self.settings[@"host"]]];
    self.postManager.method = @"POST";
    NSString *user = self.settings[@"username"];
    NSString *password = self.settings[@"password"];
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
    
    if (self.selectImageButton.imageView.image != self.defaultImage)
    {
        [self.postManager appendImage:self.selectImageButton.imageView.image withName:@"image" filename:@"imageFilename.jpg" toBody:body];
    }
    
    [self.postManager postFormWithBody:body];
}

- (void)hideLoadingScreen
{
    [self.activityIndicator stopAnimating];
    [self.overlayView setHidden:YES];
}

- (void)showLoadingScreen
{
    [self.activityIndicator startAnimating];
    [self. overlayView setHidden:NO];
}

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
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

        self.statistic = [[NSDictionary alloc] initWithDictionary:responseDict];
        [self initLabelsWithStatistic:responseDict];
    }
    else if (manager == self.postManager)
    {
        [self getStatistic];
    }
    
    [self hideLoadingScreen];
}

- (void)manager:(URLConnectionManager *)manager didFailWithError:(NSError *)error {
    self.errorAlertView = [[UIAlertView alloc]
                            initWithTitle:NSLocalizedString(@"Could not find any new data.", @"")
                            message:nil
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:NSLocalizedString(@"Menu", @""), nil];
    [self.errorAlertView show];
}

- (void)disableSaveButton
{
    [self.uploadDataButton setEnabled:NO];
}

- (void)enableSaveButton
{
    [self.uploadDataButton setEnabled:YES];
}

- (void)showError
{
    self.labelOne.hidden = YES;
    self.labelOneTitle.hidden = YES;
    self.labelTwo.hidden = YES;
    self.labelTwoTitle.hidden = YES;
    self.labelThree.hidden = YES;
    self.labelThreeTitle.hidden = YES;
    self.labelFour.hidden = YES;
    self.labelFourTitle.hidden = YES;
    self.gameModeLabel.hidden = YES;
    self.selectImageButton.hidden = YES;
    self.editNameTextField.hidden = YES;
    
    self.errorLabel.hidden = NO;
    
    [self disableSaveButton];
}

- (void)hideError
{
    self.labelOne.hidden = NO;
    self.labelOneTitle.hidden = NO;
    self.labelTwo.hidden = NO;
    self.labelTwoTitle.hidden = NO;
    self.labelThree.hidden = NO;
    self.labelThreeTitle.hidden = NO;
    self.labelFour.hidden = NO;
    self.labelFourTitle.hidden = NO;
    self.gameModeLabel.hidden = NO;
    self.selectImageButton.hidden = NO;
    self.editNameTextField.hidden = NO;
    
    self.errorLabel.hidden = YES;
    [self enableSaveButton];
}


- (void)initLabelsWithStatistic:(NSDictionary *)statistic
{
    
    if (statistic != nil)
    {
        self.gameModeLabel.text = [NSString stringWithFormat:@"%@", [[statistic objectForKey:@"mode"] objectForKey:@"title"]];
        
        self.labelOne.text = [NSString stringWithFormat:@"%@", [statistic objectForKey:@"score"]];
        self.labelTwo.text = [NSString stringWithFormat:@"%@", statistic[@"shots"]];
        self.labelThree.text = [NSString stringWithFormat:@"%i", [statistic[@"shots"] integerValue] - [statistic[@"misses"] integerValue]];
        self.labelFour.text = [NSString stringWithFormat:@"%.0F %%", ([statistic[@"shots"] floatValue] - [statistic[@"misses"] floatValue]) / [statistic[@"shots"] floatValue] * 100];
        
        [self.selectImageButton setImage:self.defaultImage forState:UIControlStateNormal];
        self.editNameTextField.text = @"";
        
        [self hideError];
    }
    else
    {
        [self showError];
    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.noNameAlertView) {
    
        switch (buttonIndex)
        {
            case 1:
            {
                [self showLoadingScreen];
                [self updateStatistic];
                break;
            }
            
            default:
                break;
        }
    } else if (alertView == self.errorAlertView){
        switch (buttonIndex)
        {
            case 1:
            {
                [self.navigationController popViewControllerAnimated:YES];
                break;
            }
                
            default:
                [self.navigationController popViewControllerAnimated:YES];
                break;
        }
    }
}

#pragma mark - keyboard notifications

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppearHandler:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappearHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillAppearHandler:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, self.editNameTextField.frame.origin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, self.editNameTextField.frame.origin.y - visibleRect.size.height + self.editNameTextField.frame.size.height);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillDisappearHandler:(NSNotification *)notification
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
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

- (IBAction)updatePlayerButtonPressed:(UIButton *)sender
{
    if ([self.editNameTextField.text isEqualToString:@""])
    {
        self.noNameAlertView = [[UIAlertView alloc]
                                    initWithTitle:NSLocalizedString(@"You haven't entered a name! Do you really want to continue?", @"")
                                    message:nil
                                    delegate:self
                                    cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                    otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
        [self.noNameAlertView show];
    }
    else
    {
        [self showLoadingScreen];
        [self updateStatistic];
    }
}

- (IBAction)reloadButtonPressed:(id)sender
{
    [self showLoadingScreen];
    [self getStatistic];
}
@end
