//
//  Picture.h
//  PicLine
//
//  Created by students on 4/23/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pictureId;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * emoticon;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) Line *lines;

@end
