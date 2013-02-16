//
//  MasterNavigationController.m
//  Momento
//
//  Created by Cameron Hawkins on 2/10/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "MasterNavigationController.h"

@interface MasterNavigationController ()

- (void) setup;

@end

@implementation MasterNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    [self setup];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}

- (void) setup {
  
}

@end
