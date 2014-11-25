//
//  ViewController.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 23/11/14.
//  Copyright (c) 2014 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadStatistic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadStatistic
{
    // Create the request.
    NSURL *url = [NSURL URLWithString:@"http://goalwall.app/statistics/latest/1"];
    
    NSString *user = @"mail@miguelwicht.com";
    NSString *password = @"password";
    
    NSData *postData = [[[NSString alloc] initWithFormat:@"user=%@&password=%@", user, password] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)sendUpdatedStatistic
{
    NSURL *url = [NSURL URLWithString:@"http://goalwall.app/statistics/update/player"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    NSMutableData *body = [NSMutableData data];
    
    NSString *user = @"mail@miguelwicht.com";
    NSString *password = @"password";
    NSString *name = self.nameTextField.text ? self.nameTextField.text : nil;
    NSString *statisticId = self.statisticData[@"id"];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"logo"]);
    
    // set post data
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:user forKey:@"user"];
    [postDict setObject:password forKey:@"password"];
    [postDict setObject:statisticId forKey:@"id"];
    [postDict setObject:name forKey:@"player_name"];
    
    for(NSString *key in postDict)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [postDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", name]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:body];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)submitFormAction:(id)sender
{
    [self sendUpdatedStatistic];
}


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *error;
    self.statisticData = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSLog(@"%@", self.statisticData);
    [self initLabels];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"DidFailWithError");
}

#pragma mark - Helpers

- (void)initLabels
{
    self.eventTitleLabel.text = self.statisticData[@"event"][@"title"];
    self.modeTitleLabel.text = self.statisticData[@"mode"][@"title"];
}

@end
