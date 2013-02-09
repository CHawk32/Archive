//
//  ViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void) setup;

@end

@implementation ViewController

// INITIALIZATION CODE
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}

- (ViewController *) init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

- (void) setup {
  self.isLoggedIn = NO;

  // Attempt to login

  if (self.isLoggedIn) {
    self.loginButton.hidden = YES;
    self.loggedInLabel.hidden = NO;
  } else {
    self.loginButton.hidden = NO;
    self.loggedInLabel.hidden = YES;
  }
}



// GETTERS AND SETTERS
- (void) setIsLoggedIn:(BOOL)isLoggedIn {
  if (isLoggedIn) {
    self.loginButton.hidden = YES;
    self.loggedInLabel.hidden = NO;
  } else {
    self.loginButton.hidden = NO;
    self.loggedInLabel.hidden = YES;
  }
  _isLoggedIn = isLoggedIn; 
}






// EVENT HANDLERS
- (IBAction) loginButtonPressed:(id)sender {
  self.isLoggedIn = YES;
}






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
