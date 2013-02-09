static BOOL isLoggedIn = NO;//
//  LoginViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 2/9/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "LoginViewController.h"

static BOOL _isLoggedIn = NO;

@interface LoginViewController ()

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
  
}

+ (BOOL) isLoggedIn {
  return isLoggedIn;
}

- (void) logIn {
  
}

@end
