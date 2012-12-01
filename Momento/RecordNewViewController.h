//
//  RecordNewViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordNewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *cameraPreview;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) AVCaptureSession *session;
@end
