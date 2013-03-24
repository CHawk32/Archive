//
//  VideoFeedModel.m
//  Momento
//
//  Created by Cameron Hawkins on 2/26/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "VideoFeedModel.h"

@implementation VideoFeedModel

- (NSDictionary *) videos {
  return [NSDictionary dictionaryWithObjectsAndKeys:
          @"Cameron's Video #1", @"Video1_name",
          @"Cameron's Video #2", @"Video2_name",
          @"Cameron's Video #3", @"Video3_name",
          @"Cameron's Video #4", @"Video4_name",
          @"Cameron's Video #5", @"Video5_name",
          @"Cameron's Video #6", @"Video6_name",
          nil];
}

@end
