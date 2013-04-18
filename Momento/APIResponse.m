//
//  APIResponse.m
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "APIResponse.h"

@interface APIResponse()

@end

@implementation APIResponse

- (APIResponse *) initWithStatus:(int) status
                         content:(NSData *) content {
  if (self = [super init]) {
    self.status = status;
    self.content = content;
  }
  return self;
}

- (BOOL) failed {
  if (self.status == 200) {
    return NO;
  }
  return YES;
}

- (id) JSONObjFromData {
  return [NSJSONSerialization JSONObjectWithData:self.content options:NSJSONReadingMutableContainers error:nil];
}

@end
