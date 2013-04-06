//
//  LoginOrCreateViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 3/30/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequest.h"

@interface LoginOrCreateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UITextField *UsernameField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswrodField;
@property (weak, nonatomic) IBOutlet UILabel *EmailPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConfirmPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ErrorMessageLabel;

@end
