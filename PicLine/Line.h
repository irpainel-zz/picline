//
//  Line.h
//  PicLine
//
//  Created by students on 4/12/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Line : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * piclineId;
@property (nonatomic, retain) NSSet *pictures;
@end

@interface Line (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(NSManagedObject *)value;
- (void)removePicturesObject:(NSManagedObject *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

@end
