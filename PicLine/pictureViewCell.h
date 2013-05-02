//
//  TimelineCell.h
//  FinalProjectT
//
//  Created by students on 3/28/13.
//  Copyright (c) 2013 IuryPainelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewCell : UITableViewCell
{
}

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *emoticonImage;
@property (retain, nonatomic) IBOutlet UIImageView *mainImage;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *detailsLabel;

@end
