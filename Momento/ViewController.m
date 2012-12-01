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

- (void)viewDidLoad
{
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
  

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"Preparing for '%@' segue.", segue.identifier);

  // Initialization stuff goes here
  if ([segue.identifier isEqualToString:@"NewRecordingSegue"]) {
    
  } else if ([segue.identifier isEqualToString:@"NewRecordingSegue"]) {

  } else {
    NSLog(@"Error, attempting to use an undefined segue");
  }
}

@end
