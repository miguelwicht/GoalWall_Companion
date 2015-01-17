//
//  URLConnectionManager.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 17/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "URLConnectionManagerDelegate.h"

@interface URLConnectionManager : NSObject <NSURLConnectionDelegate>
@property (strong, nonatomic) id<URLConnectionManagerDelegate> delegate;

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSDictionary *postData;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *boundary;

//@property(strong, nonatomic) NSMutableURLRequest *request;
//@property(strong, nonatomic) NSURLConnection *conn;
//@property(strong, nonatomic) NSMutableData *requestBodyData;
//@property(strong, nonatomic) NSString *url;
//@property(strong, nonatomic) NSData *responseData;

- (void)get;
- (void)postFormWithBody:(NSMutableData *)body;
- (void)appendDictionary:(NSDictionary *)dictionary toBody:(NSMutableData *)body;
- (void)appendImage:(UIImage *)image withName:(NSString*)name filename:(NSString *)filename toBody:(NSMutableData *)body;
@end
