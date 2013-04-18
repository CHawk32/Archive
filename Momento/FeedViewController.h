//
//  ViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "APIRequest.h"
#import "APIResponse.h"
#import "VideoCell.h"

@interface FeedViewController : UITableViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *debugMessage;
@property (weak, nonatomic) IBOutlet UILabel *preparingFeedLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (void) feedReady:(APIResponse *)response;

@end
