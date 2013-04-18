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

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, strong) NSArray *videoFeed;

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

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
    [self setup];
  }
  return self;
}

- (void) setup {
  // if (!logged in)

  self.spinner.hidesWhenStopped = YES;
  self.videoFeed = nil;
  [self getFeed];

  // if not logged in
  //[self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
  //[self.view addSubview:self.videoFeed.view];
}

- (void) getFeed {
  if (self.videoFeed == nil) {
    NSLog(@"Getting new feed");

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
    //[self.spinner stopAnimating];
    //[self.preparingFeedLabel setHidden:YES];
  }
  
  // id JSONObject = [NSJSONSerialization JSONObjectWithData:response.content options:NSJSONReadingMutableContainers error:nil];

  //if (JSONObject == nil) {
    //NSLog(@"Error Deserializing JSON");
  //} else {
    self.videoFeed = [response JSONObjFromData];//JSONObject;
  //}
  
  [self renderFeed];
}

- (void) renderFeed {
  if (self.videoFeed == nil) {
    // No bueno, gotta go get the feed, then will automatically come back
    [self getFeed];
    return;
  }

  // Draw the tableview
  [self.tableView reloadData];
  // self.debugMessage.text = @"Feed Ready";
  
}

// GETTERS AND SETTERS





// EVENT HANDLERS



// Run the TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.videoFeed == nil) {
    //NSLog(@"Number of rows called with nil videoFeed");
    return 0;
  } else {
    //NSLog(@"Number of rows called with videoFeed: %d", self.videoFeed.count);
    return self.videoFeed.count;
  }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  VideoCell *cell;
  
  cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];

  if (cell == nil) {
    cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoCell"];
  }

  NSInteger rowNum = indexPath.row;
  NSDictionary *video = [self.videoFeed objectAtIndex:rowNum];
  NSDictionary *user = [video objectForKey:@"User"];

  cell.VideoNameLabel.text = [video objectForKey:@"Title"];//@"Default";
  cell.UserNameLabel.text = [user objectForKey:@"Username"];

  cell.VideoThumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[video objectForKey:@"MediumImageUrl"]]]];
  cell.UserImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[user objectForKey:@"Avatar"]]]];
  cell.videoURL = [video objectForKey:@"VideoUrl"];
  cell.DescriptionText.text = [video objectForKey:@"Description"];

  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
  NSDictionary *video = [self.videoFeed objectAtIndex:indexPath.row];
  NSURL *videoUrl = [NSURL URLWithString:[video objectForKey:@"VideoUrl"]];

  NSLog(@"New Video Player with URL:%@", videoUrl);

  self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
  [self.moviePlayerController prepareToPlay];

  self.moviePlayerController.controlStyle = MPMovieControlStyleDefault;
  self.moviePlayerController.shouldAutoplay = YES;
  
  //moviePlayerController.movieSourceType = MPMovieSourceTypeStreaming;

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerController];
  
  // Pass the selected object to the new view controller.
  [self.moviePlayerController setFullscreen:YES animated:YES];
  [self.view addSubview:self.moviePlayerController.view];
  //[self.moviePlayerController play];
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
  MPMoviePlayerController *player = [notification object];

  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:MPMoviePlayerPlaybackDidFinishNotification object:player];
  [player.view removeFromSuperview];
  self.moviePlayerController = nil;
}

// SEGUE CODE
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"Preparing for '%@' segue.", segue.identifier);

  // Initialization stuff goes here
  if ([segue.identifier isEqualToString:@"NewRecordingSegue"]) {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RecordNewViewController"] animated:YES];
  } else {
    NSLog(@"Error, attempting to use an undefined segue");
  }
}

@end













