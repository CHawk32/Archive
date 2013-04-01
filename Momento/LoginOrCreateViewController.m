//
//  LoginOrCreateViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 3/30/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "LoginOrCreateViewController.h"

@interface LoginOrCreateViewController ()
- (void) setup;

@end

@implementation LoginOrCreateViewController

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
	// Do any additional setup after loading the view.
}

- (void) setup {
  self.ErrorMessageLabel.hidden = YES;
}

- (IBAction)LoginPressed:(id)sender {
  NSString *username = self.UsernameField.text;
  NSString *password = self.PasswordField.text;
  
  // Asynchronously call request.dorequest
  dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self loginComplete:[APIRequest loginWithName:username Password:password]];
  });
}

- (void) loginComplete:(APIResponse *) response {
  if (response.failed) {
    self.ErrorMessageLabel.hidden = NO;
  } else {
    NSLog(@"Login Successful");
    [self.navigationController popToRootViewControllerAnimated:YES];
  }
}

@end
