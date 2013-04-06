//
//  ViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "FeedViewController.h"
//#import "VideoFeedViewController.h"

@interface FeedViewController ()

- (void) setup;

@property (nonatomic, strong) NSDictionary *videoFeed;

@end

@implementation FeedViewController

// INITIALIZATION CODE
- (void) viewDidLoad {
  [super viewDidLoad];

  [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (FeedViewController *) init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

//- (VideoFeedViewController *) videoFeed {
  //if (_videoFeed == nil) {
  //  _videoFeed = [[VideoFeedViewController alloc] init];
  //}
  //return _videoFeed;
//}

- (void) setup {
  // if (!logged in)

  self.spinner.hidesWhenStopped = YES;
  [self getFeed];

  // if not logged in
  //[self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
  //[self.view addSubview:self.videoFeed.view];
}

- (void) getFeed {
  if (self.videoFeed == nil) {
    // Got to ask the server for a feed
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [self feedReady:[APIRequest getFeed:@"1"]];
    });
    [self.spinner startAnimating];
  }
}

- (void) feedReady:(APIResponse *)response {
  if (response.failed) {
    NSLog(@"Feed request failed with signal: %d", response.status);
  } else {
    //NSLog(@"Feed request succeded");
    [self.spinner stopAnimating];
    [self.preparingFeedLabel setHidden:YES];
  }

  self.videoFeed = response.content;
  [self renderFeed];
}

- (void) renderFeed {
  if (self.videoFeed == nil) {
    // No bueno, gotta go get the feed, then will automatically come back
    [self getFeed];
    return;
  }

  // Draw the tableview
  self.debugMessage.text = @"Feed Ready";
  
}

// GETTERS AND SETTERS





// EVENT HANDLERS







// SEGUE CODE
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"Preparing for '%@' segue.", segue.identifier);

  // Initialization stuff goes here
  if ([segue.identifier isEqualToString:@"NewRecordingSegue"]) {
    
  } else if ([segue.identifier isEqualToString:@"ViewGallerySegue"]) {
    
  } else {
    NSLog(@"Error, attempting to use an undefined segue");
  }
}

@end
