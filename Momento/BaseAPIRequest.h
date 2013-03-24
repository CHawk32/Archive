//
//  BaseAPIRequest.h
//  Momento
//
//  Created by Cameron Hawkins on 3/23/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIResponse.h"

@interface BaseAPIRequest : NSObject

- (BaseAPIRequest *) initWithPAth:(NSString *) path;

// Run the request
- (APIResponse *) doRequest;

// url params
- (void) addURLParamters:(NSDictionary *) params;

// content & content type
- (void) addContent:(NSData *) content
             ofType:(NSString *) type;

@end
