//
//  VideoMetaDataViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequest.h"


@interface VideoMetaDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;

@property (nonatomic, strong) NSString *videoPath;

- (void) uploadVideo;

@end
