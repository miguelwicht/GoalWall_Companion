//
//  URLConnectionManagerDelegate.h
//  GoalWall_Companion
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 17/01/15.
//  Copyright (c) 2015 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <Foundation/Foundation.h>
@class URLConnectionManager;

@protocol URLConnectionManagerDelegate <NSObject>

- (void)manager:(URLConnectionManager *)manager didFinishLoading:(NSData *)data;
- (void)manager:(URLConnectionManager *)manager didFailWithError:(NSError *)error;

@end
