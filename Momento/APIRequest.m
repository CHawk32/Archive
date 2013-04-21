//
//  APIRequest.m
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "APIRequest.h"
#import "BaseAPIRequest.h"

@implementation APIRequest

/*
 * login
 */
+ (APIResponse *) loginWithName:(NSString *) username
                       password:(NSString *) password {
  // Build the base request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/login"];

  // Give add username and password as a json string
  NSDictionary *requestBodyDictionary = [NSDictionary dictionaryWithObjectsAndKeys:username, @"Username", password, @"Password", nil];
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:requestBodyDictionary
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];

  // Synchronous Call
  return [apiRequest doRequest];
}

/*
 * signup
 */
+ (APIResponse *) sigupWithName:(NSString *) username
                          email:(NSString *) email
                       password:(NSString *) password {
  // Build the base request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/signup"];

  // Give add username and password as a json string
  NSDictionary *requestBodyDictionary = [NSDictionary dictionaryWithObjectsAndKeys:username, @"Username", password, @"Password", email, @"Email", nil];
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:requestBodyDictionary
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];

  // Synchronous Call
  return [apiRequest doRequest];
}

/*
 * getFeed
 */
+ (APIResponse *) getFeed:(NSString *) userId {
  NSLog(@"APIRequest.getFeed(%@)", userId);
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/videos/feed"];

  // Add userID url parameters
  NSDictionary *urlParameters = [NSDictionary dictionaryWithObjectsAndKeys:userId, @"UserId", nil];
  [apiRequest addURLParamters:urlParameters];

  // TODO Authentication in content

  // Do the request
  return [apiRequest doRequest];
}

/*
 * userSearch
 */
+ (APIResponse *) userSearch:(NSString *) query {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/user/search"];

  // Search query as URL parameter
  NSDictionary *urlParameters = [NSDictionary dictionaryWithObjectsAndKeys:query, @"Search", nil];
  [apiRequest addURLParamters:urlParameters];

  // Do the request
  return [apiRequest doRequest];
}

/*
 * userFollow
 */
+ (APIResponse *) follow:(NSString *) follower person:(NSString *) followee {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/user/follow"];

  // Give add userId and followId as a json string
  NSDictionary *requestBodyDictionary = [NSDictionary dictionaryWithObjectsAndKeys:follower, @"UserId", followee, @"FollowingId", nil];
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:requestBodyDictionary
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];

  // Do the request
  return [apiRequest doRequest];
}

/*
 * userUnfollow
 */
+ (APIResponse *) unfollow:(NSString *) follower person:(NSString *) followee {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/user/unfollow"];

  // Give add userId and followId as a json string
  NSDictionary *requestBodyDictionary = [NSDictionary dictionaryWithObjectsAndKeys:follower, @"UserId", followee, @"FollowingId", nil];
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:requestBodyDictionary
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];

  // Do the request
  return [apiRequest doRequest];
}

/*
 * comment
 */
+ (APIResponse *) comment:(NSString *) comment onVideo:(NSString *) videoId fromUser:(NSString *) userId {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/video/comment"];

  // Give add videoId, userId, comment as a json string
  NSDictionary *requestBodyDictionary = [NSDictionary dictionaryWithObjectsAndKeys:videoId, @"VideoId", userId, @"UserId", comment, @"Comment", nil];
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:requestBodyDictionary
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];
  
  // Do the request
  return [apiRequest doRequest];
}

/*
 * userProfile
 */
+ (APIResponse *) userProfile:(NSString *) userId {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/user/profile"];

  // Search query as URL parameter
  NSDictionary *urlParameters = [NSDictionary dictionaryWithObjectsAndKeys:userId, @"UserId", nil];
  [apiRequest addURLParamters:urlParameters];

  // Do the request
  return [apiRequest doRequest];
}

/*
 * viewVideo
 */
+ (APIResponse *) videoView:(NSString *) videoId {
  // Base http request
  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/video/view"];

  // Search query as URL parameter
  NSDictionary *urlParameters = [NSDictionary dictionaryWithObjectsAndKeys:videoId, @"VideoId", nil];
  [apiRequest addURLParamters:urlParameters];

  // Do the request
  return [apiRequest doRequest];
}

/*
 * uploadVideo
 */
+ (APIResponse *) uploadVideo:(NSString *) videoPath fromUser:(NSString *) userID {
  // Step 1) Create the video and get its videoID
  BaseAPIRequest *apiRequestCreateVideo = [[BaseAPIRequest alloc] initWithPAth:@"/createvideo"];

  // userID as URL parameter
  NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:userID, @"UserId", nil];
  [apiRequestCreateVideo addContent:[NSJSONSerialization dataWithJSONObject:content
                                                                    options:0
                                                                      error:nil] ofType:@"application/JSON"];

  // Get the video ID from the response
  NSLog(@"Creating Video");
  APIResponse *createResponse = [apiRequestCreateVideo doRequest];
  NSString *videoID = [[createResponse JSONObjFromData] objectForKey:@"VideoId"];
  NSLog(@"videoID: %@", videoID);

  //if (videoID)

  
  // Step 2) upload the video's image
  BaseAPIRequest *apiRequestUploadVideoImage = [[BaseAPIRequest alloc] initWithPAth:@"/uploadvideoimage"];

  // Add the video id as a url param
  NSDictionary *videoUrlParameters = [NSDictionary dictionaryWithObjectsAndKeys:videoID, @"VideoID", nil];
  [apiRequestUploadVideoImage addURLParamters:videoUrlParameters];

  // Add the actual image
  NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
  MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
  UIImage *image = [player thumbnailImageAtTime:1.0
                                     timeOption:MPMovieTimeOptionNearestKeyFrame];

  [apiRequestUploadVideoImage addContent:UIImageJPEGRepresentation(image, 0.7) ofType:@"image/jpg"];

  NSLog(@"Uploading Image");
  [apiRequestUploadVideoImage doRequest];
  
  // Step 3) upload the video file
  BaseAPIRequest *apiRequestUploadVideo = [[BaseAPIRequest alloc] initWithPAth:@"/uploadvideofile"];
  
  [apiRequestUploadVideo addURLParamters:videoUrlParameters];
  [apiRequestUploadVideo addContent:[NSData dataWithContentsOfURL:videoURL] ofType:@"video/mp4"];

  NSLog(@"Uploading Video");
  
  APIResponse *uploadResonse = [apiRequestUploadVideo doRequest];

  uploadResonse.debug = videoID;

  return uploadResonse;
}

/*
 * uploadMetadata
 */
+ (APIResponse *) uploadVideoMetadata:(NSDictionary *) metadata {

  BaseAPIRequest *apiRequest = [[BaseAPIRequest alloc] initWithPAth:@"/uploadvideometadata"];

  // Give add username and password as a json string
  NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:metadata
                                                     options:0
                                                       error:nil];

  [apiRequest addContent:JSONdata ofType:@"application/JSON"];

  return [apiRequest doRequest];
}



@end
