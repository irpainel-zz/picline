//
//  setDetailsViewController.h
//  PicLine
//
//  Created by students on 4/25/13.
//  Copyright (c) 2013 Painelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Line.h"
#import "Picture.h"
#import "piclineAppDelegate.h"

@interface setDetailsViewController : UIViewController <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    
    piclineAppDelegate *app;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageDetail;
@property (retain, nonatomic) IBOutlet UITextField *picTitle;
@property (retain, nonatomic) IBOutlet UITextField *picDetails;
@property (retain, nonatomic) IBOutlet UISegmentedControl *emoticonSelection;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) UIImage *imageFromUser;
- (IBAction)savePicture:(id)sender;
- (IBAction)cancelPicture:(id)sender;
@property (strong, retain) Line *piclineObject;
@property (strong, retain) Picture *pictureObject;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
