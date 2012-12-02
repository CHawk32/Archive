//
//  GalleryViewController.m
//  Momento
//
//  Created by Cameron Hawkins on 12/1/12.
//  Copyright (c) 2012 BAMF's. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController ()

@property (nonatomic) bool isLoaded;

@end

@implementation GalleryViewController

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
  [self setup];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setup {
  self.isLoaded = NO;
  self.WebView.hidden = YES;
  [self.activityIndicator startAnimating];
  
  dispatch_queue_t queue = dispatch_queue_create("pageLoadQueue", 0);
  dispatch_async(queue, ^ {
    [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://momento.wadec.com"]]];
    dispatch_async(dispatch_get_main_queue(), ^ {
      self.isLoaded = YES;
      self.WebView.hidden = NO;
      self.activityIndicator.hidden = YES;
      [self.activityIndicator stopAnimating];
    });
  });

  
}

@end
