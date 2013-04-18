//
//  APIResponse.h
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIResponse : NSObject

@property (nonatomic, strong) NSData *content;
@property (nonatomic) int status;

- (APIResponse *) initWithStatus:(int) status
                         content:(NSData *) content;
- (BOOL) failed;
- (id) JSONObjFromData;

@end
