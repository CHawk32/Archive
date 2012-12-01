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
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) setup {
  self.isRecording = NO;
  [self.recordButton setTitle:@"Start" forState:UIControlStateNormal];
}

- (IBAction) recordButtonPressed:(UIButton *)sender {
  NSLog(@"Record Button Pressed");
  if (!self.isRecording) {
    [self.session startRunning];
    [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.isRecording = YES;
  } else {
    [self.session stopRunning];
    [self.recordButton setTitle:@"ReStart" forState:UIControlStateNormal];
    self.isRecording = NO;
  }
}

- (AVCaptureSession *)session {
  if (!_session) {
    NSError *error = nil;

    // Get a AVCapture Session Object. Need to research this object more, but I believe it is a high level interface for
    // getting data from the camera and microphone
    _session = [[AVCaptureSession alloc] init];
    // Setting the desired quality level to HIGH
    _session.sessionPreset = AVCaptureSessionPresetMedium;

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
    [_session addInput:input];

    // Set up the preview
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    captureVideoPreviewLayer.frame = self.cameraPreview.bounds;
    [self.cameraPreview.layer addSublayer:captureVideoPreviewLayer];

    // Set up out data output
    //AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    //output.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], (id)kCVPixelBufferPixelFormatTypeKey, nil];

    // Set up our capture delegate
    //dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    //[output setSampleBufferDelegate:self.videoDelegate queue:queue];
    //[_session addOutput:output];
    //dispatch_release(queue);
  }
  return _session;
}

@end
