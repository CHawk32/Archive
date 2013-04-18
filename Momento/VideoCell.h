//
//  VideoCell.h
//  Momento
//
//  Created by Cameron Hawkins on 4/9/13.
//  Copyright (c) 2013 BAMF's. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *VideoThumbnail;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;

@property (weak, nonatomic) IBOutlet UILabel *VideoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLabel;

@property (weak, nonatomic) IBOutlet UITextView *DescriptionText;

@property (nonatomic, strong) NSString *videoURL;


@end
