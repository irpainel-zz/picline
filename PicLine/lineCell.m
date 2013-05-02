//
//  TimelineCell.m
//  FinalProjectT
//
//  Created by students on 3/28/13.
//  Copyright (c) 2013 IuryPainelli. All rights reserved.
//

#import "LineCell.h"

@implementation LineCell

@synthesize titleLabel = titleLabel;
@synthesize lineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [lineImage release];
    [super dealloc];
}
@end
