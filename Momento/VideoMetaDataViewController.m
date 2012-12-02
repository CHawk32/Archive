//
//  VideoMetaDataViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "VideoMetaDataViewController.h"

@interface VideoMetaDataViewController ()

@property (nonatomic) int totalSize;
@property (nonatomic) int sentSoFar;

@end

@implementation VideoMetaDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void) uploadVideo {
  NSLog(@"Welcome to finish button pressed handler!");
  if ([[NSFileManager defaultManager] fileExistsAtPath:self.videoPath])
  {
    NSLog(@"file exists");
  }
  //NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:self.defaultFilelocation]];
  NSData *data = [NSData dataWithContentsOfFile:self.videoPath];
  NSLog(@"Data length %d", data.length);
  NSLog(@"Have data, will travel");
  AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL fileURLWithPath:@"http://momento.wadec.com/upload"]];
  if (client) {
    NSLog(@"Client Made");
  }
  NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"http://momento.wadec.com/upload" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
    [formData appendPartWithFileURL:[NSURL fileURLWithPath:self.videoPath] name:@"video" error:nil];
  }];
  NSLog(@"URL Request created");

  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  /*[operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
   NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
   }];*/

  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Posted successfully with message");
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error)  {
    NSLog(@"Posted failed with error %@", error);
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
  }];

  self.totalSize = 0;
  self.sentSoFar = 0;
  self.progressLabel.hidden = NO;

  [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    self.totalSize = totalBytesExpectedToWrite;
    self.sentSoFar = totalBytesWritten;

    [self.progressLabel setText:[NSString stringWithFormat:@"%d of %d bytes sent", self.sentSoFar, self.totalSize]];
    //NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
  }];

  NSLog(@"Calling operation start");
  [operation start];
  NSLog(@"All done.");
}

- (IBAction)submitButtonPressed:(id)sender {
  // DO SOMETHING WITH META DATA

  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backgroundTouched:(id)sender {
  [self.descriptionField resignFirstResponder];
}

@end
