//
//  VideoCell.m
//  Momento
//
//  Created by Cameron Hawkins on 4/9/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*- (void) setWebViewHtml:(NSURL *) url {
  NSString *html = [NSString stringWithFormat:
  @"<html>\
      <body>\
        <video controls>\
          <source src=\"%@\" type=\"video/mp4\"\
        </video>\
      </body>\
   </html>", url];

  [self.VideoThumbnail loadHTMLString:html baseURL:nil];
}*/

@end
