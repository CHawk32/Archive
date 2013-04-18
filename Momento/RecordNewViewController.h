//
//  RecordNewViewController.h
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoMetaDataViewController.h"

@interface RecordNewViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic, strong) NSString *moviePath;
@property (weak, nonatomic) IBOutlet UILabel *videoPathLabel;

- (IBAction)captureNewVideo:(id)sender;
- (IBAction)findExistingVideo:(id)sender;

@end

/*@interface RecordNewViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cameraPreview;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (readonly) NSDictionary *videoSettings;
@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterInput;
@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *pixelBufferAdaptor;
@property (nonatomic) int frameNumber;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (readonly) NSString *defaultFilelocation;

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection;
@end
 */
