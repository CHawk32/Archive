//
//  ViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *loggedInLabel;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic) BOOL isLoggedIn;

- (IBAction) loginButtonPressed:(id)sender;

@end
