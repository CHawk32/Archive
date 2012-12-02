//
//  RecordNewViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "RecordNewViewController.h"

@interface RecordNewViewController ()

@property (nonatomic) bool isRecording;

-(void) setup;

@end

@implementation RecordNewViewController

- (RecordNewViewController *) init {
  if (self = [super init]) {
    [self setup];
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self setup];
}

- (NSString *) defaultFilelocation {
  NSString *returnString = [NSHomeDirectory()
                            stringByAppendingPathComponent:@"Documents"];
  return [returnString stringByAppendingPathComponent:@"DefualtVideoFile.mp4"];
}

- (NSDictionary *) videoSettings {
  return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey, nil];
}

- (AVAssetWriter *) assetWriter {
  if (!_assetWriter) {
    NSURL *newVideoURL = [NSURL fileURLWithPath:self.defaultFilelocation];
    NSLog(@"Try to write to %@", newVideoURL);
    NSError *error = nil;
    _assetWriter = [[AVAssetWriter alloc] initWithURL:newVideoURL
                              fileType:AVFileTypeMPEG4
                                 error:&error];

    if (!_assetWriter || error) {
      NSLog(@"An error occured creating the asset writer");
    } else {
      NSLog(@"Asset writer created successfully");
    }
    [_assetWriter addInput:self.assetWriterInput];
  }
  return _assetWriter;
}

- (AVAssetWriterInput *) assetWriterInput {
  if (!_assetWriterInput) {
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:320], AVVideoWidthKey,
                                    [NSNumber numberWithInt:240], AVVideoHeightKey,
                                    AVVideoCodecH264, AVVideoCodecKey, nil];
    _assetWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                           outputSettings:outputSettings];
    _assetWriterInput.expectsMediaDataInRealTime = YES;
  }
  return _assetWriterInput;
}

- (AVAssetWriterInputPixelBufferAdaptor *) pixelBufferAdaptor {
  if (!_pixelBufferAdaptor) {
    _pixelBufferAdaptor = [[AVAssetWriterInputPixelBufferAdaptor alloc] initWithAssetWriterInput:self.assetWriterInput
                                                                     sourcePixelBufferAttributes:self.videoSettings];
  }
  return _pixelBufferAdaptor;
}

- (void) setup {
  self.isRecording = NO;
  self.mainLabel.hidden = YES;
  [self.recordButton setTitle:@"Start" forState:UIControlStateNormal];

  if (!self.session || !self.assetWriter || !self.assetWriterInput || !self.pixelBufferAdaptor) {
    NSLog(@"Error instatiating avasset writer objects");
  } else {
    NSLog(@"Setup successful");
  }
}

- (IBAction) recordButtonPressed:(UIButton *)sender {
  NSLog(@"Record Button Pressed");
  if (!self.isRecording) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.defaultFilelocation]) {
      NSLog(@"deleting old file");
      [[NSFileManager defaultManager]  removeItemAtPath:self.defaultFilelocation error:nil];
    }
    NSLog(@"Starting asset Writer");
    self.frameNumber = 0;
    [self.assetWriter startWriting];
    [self.assetWriter startSessionAtSourceTime:kCMTimeZero];
    NSLog(@"Starting capture session");
    [self.session startRunning];
    [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.isRecording = YES;
    NSLog(@"Running...");
  } else {
    NSLog(@"Stopping capture session");
    [self.session stopRunning];
    NSLog(@"Stopping Writing");
    [self.assetWriter finishWritingWithCompletionHandler:^(){
      NSLog (@"finished writing");
    }];
    self.assetWriter = nil;
    self.assetWriterInput = nil;
    [self.recordButton setTitle:@"ReStart" forState:UIControlStateNormal];
    self.isRecording = NO;
    NSLog(@"Finished.");
  }
}

- (IBAction)finishButtonPressed:(id)sender {
  
}

- (AVCaptureSession *)session {
  if (!_session) {
    NSError *error = nil;

    // Get a AVCapture Session Object. Need to research this object more, but I believe it is a high level interface for
    // getting data from the camera and microphone
    _session = [[AVCaptureSession alloc] init];
    // Setting the desired quality level to HIGH
    self.session.sessionPreset = AVCaptureSessionPresetLow;

    // Now that the session is done, we set up the device we are using, in this case the default device
    // for video media (ie the camera/microphone)
    AVCaptureDevice *videoDevice;
    NSArray *videoDevices = [AVCaptureDevice devices];

    for (AVCaptureDevice *device in videoDevices)
    {
      if (device.position == AVCaptureDevicePositionFront) // Default to front facing camera
      {
        videoDevice = device;
        break;
      }
    }

    if (!videoDevice) {
      videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }

    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (!input) {
      // Handle the error appropriately.
      NSLog(@"ERROR: trying to open camera: %@", error);
      return nil;
    }
    [self.session addInput:input];

    // Set up the preview
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoPreviewLayer.frame = self.cameraPreview.bounds;
    self.cameraPreview.hidden = NO;
    [self.cameraPreview.layer addSublayer:captureVideoPreviewLayer];

    // Set up out data output
    AVCaptureVideoDataOutput *outputVideo = [[AVCaptureVideoDataOutput alloc] init];
    // AVCaptureAudioDataOutput *outputAudio = [[AVCaptureAudioDataOutput alloc] init];
    [outputVideo setVideoSettings:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey, nil]];

    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [outputVideo setSampleBufferDelegate:self queue:queue];
    // [outputAudio setSampleBufferDelegate:self queue:queue];
    [self.session addOutput:outputVideo];
    // [self.session addOutput:outputAudio];
  }
  return _session;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
  CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
  CVPixelBufferLockBaseAddress(pixelBuffer, 0);

  // NSLog(@"PixelBuffer width %ul",CVPixelBufferGetWidth(pixelBuffer));

  // a very dense way to keep track of the time at which this frame
  // occurs relative to the output stream, but it's just an example!
  //NSLog(@"Asset Writer Status: %d", self.assetWriter.status);
  if (self.assetWriterInput.readyForMoreMediaData) {
    if ([self.pixelBufferAdaptor appendPixelBuffer:pixelBuffer
                              withPresentationTime:CMTimeMake(self.frameNumber, 15)]) {
      //NSLog(@"Frame appended successfully");
    } else {
      //NSLog(@"error writing frame %d", self.frameNumber);
    }
    self.frameNumber++;
  } else {
    NSLog(@"Skipping frame");
  }
  CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"Preparing for '%@' segue.", segue.identifier);

  // Initialization stuff goes here
  if ([segue.identifier isEqualToString:@"NewRecordToMetaDataSegue"]) {
    VideoMetaDataViewController *mdvc = (VideoMetaDataViewController *)segue.destinationViewController;
    mdvc.videoPath = self.defaultFilelocation;
    [mdvc uploadVideo];
  }
}

@end
