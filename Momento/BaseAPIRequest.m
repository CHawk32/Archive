//
//  BaseAPIRequest.m
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface BaseAPIRequest()

@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSData *content;

@end

@implementation BaseAPIRequest

// Desgnated initter
- (BaseAPIRequest *) initWithPAth:(NSString *) path {
  if (self = [super init]) {
    // build basic request
    self.requestURL = [@"http://trout.wadec.com/api" stringByAppendingFormat:@"%@?", path];
  }

  return self;
}

// Run the request, the hard part
- (APIResponse *) doRequest {
  // assemble request
  NSLog(@"Building HTTP request with URL: %@", self.requestURL);
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.requestURL]];
  [request setValue:@"ios-dev" forHTTPHeaderField:@"X-ApiKey"];
  
  // TODO: request authentication

  // if content
  if (self.content != nil) {
    // request must be post
    request.HTTPMethod = @"POST";

    // add content type to request header
    [request setValue:self.contentType forHTTPHeaderField:@"content-type"];

    // add content to request body
    [request setHTTPBody:self.content];
  } else {
    // request is a get
    request.HTTPMethod = @"GET";
  }
  
  // Send request
  NSHTTPURLResponse* urlResponse = nil;
  NSError *requestError = nil;
  NSData *responseBody = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];

  if (requestError) {
    NSLog(@"URL Error: %@", requestError);
  }

  NSDictionary *responseBodyDictionary = [NSJSONSerialization JSONObjectWithData:responseBody options:0 error:nil];

  // parse response
  APIResponse *response = [[APIResponse alloc] initWithStatus:[urlResponse statusCode] content:responseBodyDictionary];

  // return response
  return response;
}

// url params to url 
- (void) addURLParamters:(NSDictionary *) params {
  NSMutableString *paramsString = [[NSMutableString alloc] init];
  int paramsCount = params.count;

  for (id key in params) {
    paramsCount--;
    id value = [params valueForKey:key];
    [paramsString appendFormat:@"%@=%@", key, value];
    
    if (paramsCount != 0) {
      [paramsString appendFormat:@"&"];
    }
  }

  self.requestURL = [self.requestURL stringByAppendingString:paramsString];
}

// content & content type
- (void) addContent:(NSData *) content
             ofType:(NSString *) type {
  self.contentType = type;
  self.content = content;
}

@end
