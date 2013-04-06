//
//  APIRequest.h
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIResponse.h"

@interface APIRequest : NSObject

// API Requests
+ (APIResponse *) loginWithName:(NSString *) username
                       password:(NSString *) password;

+ (APIResponse *) sigupWithName:(NSString *) username
                          email:(NSString *) email
                       password:(NSString *) password;

+ (APIResponse *) getFeed:(NSString *) userId;

+ (APIResponse *) userSearch:(NSString *) query;

+ (APIResponse *) follow:(NSString *) follower person:(NSString *) followee;

+ (APIResponse *) unfollow:(NSString *) follower person:(NSString *) followee;

+ (APIResponse *) comment:(NSString *) comment onVideo:(NSString *) videoId fromUser:(NSString *) userId;

+ (APIResponse *) userProfile:(NSString *) userId;

+ (APIResponse *) videoView:(NSString *) videoId;

// Upload Video

@end
