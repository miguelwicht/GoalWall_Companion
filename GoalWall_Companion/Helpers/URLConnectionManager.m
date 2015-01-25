//
//  URLConnectionManager.m
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 17/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "URLConnectionManager.h"

@implementation URLConnectionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.boundary = @"---------------------------14737809831466499882746641449";
    }
    return self;
}

//- (void)startConnection
//{
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:self.url]
//            completionHandler:^(NSData *data,
//                                NSURLResponse *response,
//                                NSError *error) {
//                // handle response
//                self.responseData = [[NSData alloc] initWithData:data];
//                NSNotificationCenter
//                
//            }] resume];
//}
/*
- (void)postForm
{
    NSURL *url = [NSURL URLWithString:@"http://goalwall.app/statistics/update/player"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    NSMutableData *body = [NSMutableData data];
    
    NSString *user = @"mail@miguelwicht.com";
    NSString *password = @"password";
    //NSString *name = self.nameTextField.text ? self.nameTextField.text : nil;
    //NSString *statisticId = self.statisticData[@"id"];
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
*/

#pragma mark - Request

- (void)get
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:self.url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//     Create the request.
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    // Create url connection and fire request
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)postFormWithBody:(NSMutableData *)body
{
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", self.boundary];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:self.url];
    [request setHTTPMethod:self.method];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:body];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)appendDictionary:(NSDictionary *)dictionary toBody:(NSMutableData *)body
{
    for(NSString *key in dictionary)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [dictionary objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (void)appendImage:(UIImage *)image withName:(NSString*)name filename:(NSString *)filename toBody:(NSMutableData *)body
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // add image data
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
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
//    NSError *error;
//    self.statisticData = [NSJSONSerialization JSONObjectWithData:self.responseData
//                                                         options:kNilOptions
//                                                           error:&error];
//    NSLog(@"%@", self.statisticData);
//    [self initLabels];
    
//    NSError *error;
//    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:self.responseData
//                                                                 options:kNilOptions
//                                                                   error:&error];
    
    [self.delegate manager:self didFinishLoading:self.responseData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"DidFailWithError: %@", error);
}


@end
