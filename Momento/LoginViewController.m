//
//  LoginViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 2/9/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterNavigationController.h"
#import "APIRequest.h"
#import "LoginOrCreateViewController.h"


@interface LoginViewController ()

@property (nonatomic) BOOL isLoggedIn;

- (void) setup;

@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
  [self setup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) setup {
  // TODO: CHECK USER SAVED CACHE TO KNOW IF WE HAVE VALID CREDENTIALS
  if (self.isLoggedIn == YES) {
    [self.parentViewController addChildViewController:[[MasterNavigationController alloc] init]];
    [self.parentViewController removeFromParentViewController];
    NSLog(@"Should not have gotten here");
  }
}

- (IBAction)login:(id)sender {
  NSLog(@"Login pressed");
  [self performSegueWithIdentifier: @"LoginFormSegue" sender: self];
}

- (void) loginComplete:(APIResponse*) response {
  if ([response failed]) {
    NSLog(@"Login failed.");
  } else {
    NSLog(@"Login successful!");
  }
};

@end
