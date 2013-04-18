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
@property (nonatomic, strong) NSString *videoID;

- (void) setup;

@end

@implementation VideoMetaDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [self setup];
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}

- (void) setup {
  NSLog(@"Uploading video with at path: %@", self.videoPath);

  self.submitButton.hidden = YES;

  // Get video uploading in the background
  [self.progressLabel setText:@"Uploading"];
  [self uploadVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) uploadVideo {
  dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self uploadComplete:[APIRequest uploadVideo:self.videoPath fromUser:@"4"]];
  });
}

- (void) uploadComplete:(APIResponse *) response {
  NSLog(@"Video Upload Complete with status: %d", response.status);
  self.videoID = [(NSDictionary *)response.content objectForKey:@"videoID"];
  self.submitButton.hidden = NO;
  [self.progressLabel setText:@"Complete"];
}

- (IBAction)submitButtonPressed:(id)sender {
  if (self.videoID == nil) {
    NSLog(@"Wait till its uploaded");
    return;
  }

  // DO SOMETHING WITH META DATA
  /* Make JSON Object like:
  {
     int VideoId;
     string Title;
     string Description;
     string Location;
     string[] Tags;
     DateTime Taken;
     bool IsPublic
  }
  */
  NSString *isPublic = [self.publicSwitch isOn] ? @"true" : @"false";

  NSDictionary *metadata = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.videoID, @"VideoID",
                              self.titleField.text, @"Title",
                              self.descriptionField.text, @"Description",
                              @"", @"Location",
                              @"", @"DateTime",
                              isPublic, @"IsPublic",
                            nil];
  

  dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [APIRequest uploadVideoMetadata:metadata];
  });

  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backgroundTouched:(id)sender {
  [self.descriptionField resignFirstResponder];
}

@end
