//
//  ViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "FeedViewController.h"
#import "LoginViewController.h"

@interface FeedViewController ()

- (void) setup;

@end

@implementation FeedViewController

// INITIALIZATION CODE
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}

- (FeedViewController *) init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

- (void) setup {
  self.title = @"Feed";

  // if not logged in
  [self.navigationController presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"] animated:YES completion:nil];
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
